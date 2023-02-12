# etiqaa_app
An application aimed to minimize risks and keep threats against minors from becoming a reality. The application is based on WhatsApp messages, which would then be received, analyzed, and classified using machine learning model that uses Logistic Regression (LR) algorithm which our result showed to have an accuracy of 81% to classify the message as appropriate or inappropriate based on the text of the conversation, and then the application sends a detailed alert to their parents based on the inappropriate threats that are detected. We believe that our project will have a significant impact and will provide more security to young WhatsApp users.

## Requirements
### Software:

- [Android studio](https://developer.android.com/studio) (2022.1.1.19-windows was used) 
(java version "11.0.17" 2022-10-18 LTS
Java(TM) SE Runtime Environment 18.9 (build 11.0.17+10-LTS-269)
Java HotSpot(TM) 64-Bit Server VM 18.9 (build 11.0.17+10-LTS-269, mixed mode))

- [XAMPP](https://www.apachefriends.org/)

- [Python](https://www.python.org/downloads/) (Python 3.10.7 was used)

- [Flutter](https://docs.flutter.dev/get-started/install) (version 3.3.10 was used), Dart (version 2.18.6 was used)


in Command Prompt run: 
> pip install camel-tools

> Pip install flask

> pip install Flask-Cors

in C:\Users\Your Name\AppData\Local\Programs\Python\Python310\Scripts> run:
> python -m pip install mysql-connector-python


### Hardware:
The system will be compatible with Android devices that have the following attributes:
- The device type is a smartphone.
- The device runs on android version 6.0.1(Marshmallow) or above. 
- The device is connected to the internet.  
- The device has a Minimum of 4GB RAM and 32GB storage.
- The parent device must support Google Play services.

## Instructions to run the project
1. Download [etiqaa_php folder](https://stuquedu-my.sharepoint.com/:f:/g/personal/s438018415_st_uqu_edu_sa/EhJDLmyrXpRIhzuNGtJzSyoBk2chSHN-sVAhYYfebhLKmg?e=tj98ba) and put it in C:\xampp\htdocs folder

2. Set the CAMELTOOLS_DATA environment variable to the desired path.Below are the instructions to do so (on Windows 10):
    - Press the Windows button and type env.
    - Click on Edit the system environment variables (Control panel).
    - Click on the Environment Variables… button.
    - Click on the New… button under the User variables panel.
    - Type CAMELTOOLS_DATA in the Variable name input box and path the project from your device(for example: D:\desktop\etiqaa_app\python_files) in Variable value. Alternatively, you can browse for the data directory by clicking on the Browse Directory… button.
    - Click OK on all the opened windows.

3.  Download **etiqaa_app** from [Code folder](https://stuquedu-my.sharepoint.com/:f:/g/personal/s438018415_st_uqu_edu_sa/EpS3Z_3VtK1MpoXdpSVA3P8BRxnA28cXSi4HbeA-e6Ukrw?e=pLuOjO) then open it in an editor (Visual Studio Code was used instead of Android Studio)

    - if you are running the application on a physical mobile, first connect to the same computer network, then go to computer settings, then networks, then Wi-Fi, then the network characteristics that you are connected to, copy the ipv4 address and put it in:
        - etiqaa_app\python_files\MLmodel.py  in **url** variable
        - etiqaa_app\etiqaa\lib\database\linkApi.dart file in **linkServerName** variable
        - etiqaa_app\etiqaa\lib\controllers\childUncomplete_controller.dart in **myServerUrl** variable

4. Open XAMPP and start Apache and Mysql, then click on Admin button corresponding to Mysql

5. create database with name 'etiqaa' then import [etiqaa.sql](https://stuquedu-my.sharepoint.com/:u:/g/personal/s438018415_st_uqu_edu_sa/EUrmM6XnzSxJlKlbJRFzLk0Bg63pnLvo5459NNZFo3-rQQ?e=i0LHf3)

6. in **etiqaa_app**, run python server by run Mlmodel.py file.

7. in **etiqaa_app**, run without debugging for main.dart file, and repeat this step if you want to run the app on another mobile at the same time after selecting it from the used editor



## Credits
This project was developed by:
1. Manar Ahmad Saeed Bajafar 
2. Faiza Mohammed Usman Baran
3. Lama Saleh Abdullah Alzughaybi 
4. Maram Nasser Muslih Alsaedi
5. Thraa Freed Hassan Serdar  

As a requirement for the graduation project at UQU.
