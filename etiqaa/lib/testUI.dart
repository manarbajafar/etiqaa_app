import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//This is a temporary page, it will be deleted
class testUi extends StatefulWidget {
  @override
  _testUiState createState() => _testUiState();
}

class _testUiState extends State<testUi> {
  String text = ""; //user's response will be assigned to this variable
  String final_response =
      ""; //will be displayed on the screen once we get the data from the server

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          //"http://192.168.8.102"; // phone
          //http://127.0.0.1:5000/ //web
          children: [
            ElevatedButton(
              onPressed: () async {
                // text = 'سُدي حلقك لا اذبحك4 !! 🪒 بيدي،تشوف كيف';
                text = 'السلام عليكم كيفك !! 🪒 #';
                //url to send the post request to
                final url = 'http://192.168.8.102:5000/';
                print(text);
                //sending a post request to the url
                final response = await http.post(Uri.parse(url),
                    body: json.encode({'message': text}));
              },
              child: Text('SEND'),
            ),

            SizedBox(height: 100),

            ElevatedButton(
              onPressed: () async {
                //url to send the get request to
                final url = 'http://192.168.8.102:5000/';

                //getting data from the python server script and assigning it to response
                final response = await http.get(Uri.parse(url));

                //converting the fetched data from json to key value pair that can be displayed on the screen
                final decoded =
                    json.decode(response.body) as Map<String, dynamic>;

                //changing the UI be reassigning the fetched data to final response
                setState(() {
                  final_response = decoded['message'];
                });
              },
              child: Text('GET'),
            ),
            SizedBox(height: 100),
            //displays the data on the screen
            Text(
              final_response,
              style: TextStyle(fontSize: 24),
            )
          ],
        ),
      ),
    );
  }
}
