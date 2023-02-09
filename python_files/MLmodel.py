import json
import os  # used for operating system functionalitie s -method getcwd() returns current working directory of a process-
import pickle
import re


from camel_tools.disambig.mle import MLEDisambiguator
from camel_tools.tokenizers.word import simple_word_tokenize
from camel_tools.utils.dediac import dediac_ar
from camel_tools.utils.normalize import (normalize_alef_ar,
                                         normalize_alef_maksura_ar,
                                         normalize_teh_marbuta_ar)


#for API
from flask import Flask, jsonify, request
from flask_cors import CORS

#noti
import requests
import json
serverToken = 'AAAAHOZII2Q:APA91bH97LruGt8WxmkCMeEfwVGhGotxXkH0HbtDo_RgXr_ytAOo-dC0cWtH8nX4KwwxTA_VlVYLvaLdSwc3DIc3xNbUY5mpOoI4_hKuiypkaS1iSerG6P_1kmzvbWibD_LwF5uhVtm6'
deviceToken = '' #get it from db

#for DB
import mysql.connector

mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password="",
  database="etiqaa"
)

    
app = Flask(__name__) #intance of our flask application 


CORS(app)
cors = CORS(app, resource={
    r"/*":{
        "origins":"*"
    }
})

def cleaning(text):

  # these stuff starting with a (\u) represent the ASCII of Arabic characters and digits in addition to tashkil and punctuation, take a look to this website >> https://unicode-table.com/en/blocks/arabic/, https://ar.wikipedia.org/wiki/%D8%A7%D9%84%D8%AE%D8%B7_%D8%A7%D9%84%D8%B9%D8%B1%D8%A8%D9%8A_%D9%81%D9%8A_%D9%8A%D9%88%D9%86%D9%8A%D9%83%D9%88%D8%AF
  cleaned_text = re.sub(r'[^\u0621-\u06D3|\u0660-\u066D|^\uFB50-\uFBE9|^\uFE80-\uFEFC]',' ', text) # remove any non-Arabic char

  cleaned_text = re.sub(r'[\u064B-\u065F]|\u0640|\u0670]','', cleaned_text) # remove some Arabic symbols and diactrties

  cleaned_text = re.sub(r'([\u0621-\u06D3|\uFB50-\uFBE9|\uFE80-\uFEFC])\1{2,}', r'\1', cleaned_text) # replace reapeted of more than 2 char to be only 1 

  cleaned_text = re.sub(r'\s\s+',' ', cleaned_text) # replace extra spaces with one space

  cleaned_text = cleaned_text.strip() # trim spaces

  return cleaned_text




mle = MLEDisambiguator.pretrained() #هذا يستخدم في ميثود المعالجة، بس حبذا يترك لحاله لان استدعاؤه ثقيل


def ANLP(text):

  normalized_text = normalize_teh_marbuta_ar(normalize_alef_ar(normalize_alef_maksura_ar(text))) # normalize the sentence
  tokens = simple_word_tokenize(normalize_alef_ar(normalized_text)) # tokenize the sentence into list of words
  
  disambig = mle.disambiguate(tokens) # analyse each token
  lem = [d.analyses[0].analysis['lex'] for d in disambig] # take the lemma

  dediac_text = dediac_ar(' '.join(lem))
     
  processedText = normalize_teh_marbuta_ar(normalize_alef_ar(normalize_alef_maksura_ar(dediac_text)))

  return processedText

#==========================================================================================================================================================================



def relativePath(path):
    cwd = os.getcwd()
    return cwd+"/python_files/"+path

result = ''

def sendnoti (title , body , token):
    serverKey = 'AAAAHOZII2Q:APA91bH97LruGt8WxmkCMeEfwVGhGotxXkH0HbtDo_RgXr_ytAOo-dC0cWtH8nX4KwwxTA_VlVYLvaLdSwc3DIc3xNbUY5mpOoI4_hKuiypkaS1iSerG6P_1kmzvbWibD_LwF5uhVtm6';
    msg = { 'title' :  title ,'body' : body,'sound': 'default'}
    data={} #i will send data
    fields = {
                        'to' : token, 
                        'notification'  : msg,
                        'data' : data,
                        'priority' : 'high'
                        
    }
    headers = {
        'Content-Type' : 'application/json',
        'Authorization': 'key=' + serverKey,
    }
    URL = 'https://fcm.googleapis.com/fcm/send'
    res = requests.post(url= URL , headers= headers , data=json.dumps(fields))
    print(res.text)

#Route '/' to facilitate get request from our flutter app
@app.route('/', methods = ['POST'])


def index():

  # import trained vectorizer and model
  vectorizer = pickle.load(open(relativePath("LemCountVectorizer.pickle"), "rb")) # rb stand for read binary
  model = pickle.load(open(relativePath("LR_LemModelWithSW_81,2.pickle"), "rb"))



  request_data = request.data #getting the response data
  request_data = json.loads(request_data.decode('utf-8')) #converting it from json to key value pair
  text = request_data['content'] #assigning it to name
  sender = request_data['sender']
  date_time = request_data['date_time']
  parent_id = request_data['parent_id']
  child_name = request_data['child_name']

  cleanedText = cleaning(text)
  print(cleanedText)
   

  processedText = [ANLP(cleanedText)]
  print(processedText)

  featuredText = vectorizer.transform(processedText)
  predictedClass = model.predict(featuredText)
  print(predictedClass)
  print(type(predictedClass))

  result = str(predictedClass[0])

  ######
  # here If it is inappropriate, store it in the data base

  if (result == 'NOT_APROP'):
    mycursor = mydb.cursor(buffered=True)


    sql1="SELECT max(msg_id) FROM whats_app_message WHERE parent_id = %s AND child_name = %s"
    val1 = (parent_id, child_name)
    mycursor.execute(sql1, val1)
    result1=mycursor.fetchone()
    if(result1[0] is None):
      msg_id=0
    else:
      msg_id=int(result1[0])

    sql = "INSERT INTO whats_app_message (parent_id, child_name, date_time, sender, content, msg_id) VALUES (%s, %s, %s, %s, %s,%s)"
    val = (parent_id, child_name, date_time, sender, text, msg_id +1)
    mycursor.execute(sql, val)

    # select token
    sql_token="SELECT token FROM parent WHERE parent_id = %s"
    val_token = (parent_id,)
    print('here')
    mycursor.execute(sql_token, val_token)
    result_token=mycursor.fetchone()
    deviceToken=result_token[0]
    print('deviceToken:', deviceToken)
    mydb.commit()

    #send notification
    # noti_data={'content':text, 'date_time':date_time, 'sender':sender,'parent_id': parent_id ,'child_name':child_name}
    sendnoti('اتقاء', 'اكتشفنا مشكلة محتملة لدى ' + child_name , deviceToken) 
    

      ####################
    # return jsonify({'label' : result})
  ######
  return jsonify({'label' : result}) #returning key-value pair in json format
  
 

url='192.168.8.102' #manar
# url='192.168.43.62' #lama


# url='192.168.8.103' #manar modem
# url='192.168.1.13' #maram

# url='127.0.0.1'


portNum= 5000

if __name__ == "__main__":
    app.run(host = url, port = portNum, debug = True) #debug will allow changes without shutting down the server 



#  d={}
#     d['query']= str(request.args['query'])
#     return jsonify(d)
