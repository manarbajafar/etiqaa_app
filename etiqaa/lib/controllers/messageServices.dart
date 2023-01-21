import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_notification_listener/flutter_notification_listener.dart';
import 'dart:isolate';
import 'dart:ui';
import 'dart:async';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../database/crud.dart';
import '../database/linkApi.dart';
import '../main.dart';

// Note: This class is only for saving fuctions temporarily

class MessageServices {
  Crud _crud = Crud();
  final myServerUrl = 'http://192.168.8.102:5000/';

  Future getMsg() async {
    return await _crud.getRequest(linkGetMsg);
  }

  Future<String> getMsgLabel(String text) async {
    //url to send the post request to
    final url = myServerUrl;
    //sending a post request to the url
    final response =
        await http.post(Uri.parse(url), body: json.encode({'message': text}));

    //converting the fetched data from json to key value pair that can be displayed on the screen
    final decoded = json.decode(response.body) as Map<String, dynamic>;

    return decoded['message'];
  }

//need to test
  void updateMsgLabel(String msg_id, String label) async {
    var response = await _crud.postRequest2(linkUpdateLabel, {
      "msg_id": msg_id,
      "label": label,
    });
    print("response ${response}");
  }
}

// void main()
// {

// }
