import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  //

  Future<bool> register(Map data) async {
    String url = 'http://10.0.2.2/api/register';

    try {
      final res = await http.post(url,
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          encoding: Encoding.getByName("utf-8"),
          body: json.encode({
            "name": data['name'],
            "email": data['email'],
            "password": data['password']
          }));

      var body = json.decode(res.body);
      print(body);
      if (body['success']) {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString('token', body['token']);
        localStorage.setString('user', json.encode(body['user']));
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('error_register');
      print(e.toString());
    }
  }

  Future<bool> login(Map data) async {
    String url = 'http://10.0.2.2/api/login';

    try {
      final res = await http.post(url,
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          encoding: Encoding.getByName("utf-8"),
          body: json
              .encode({"email": data['email'], "password": data['password']}));

      var body = json.decode(res.body);
      print(body);
      if (body['success']) {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString('token', body['token']);
        localStorage.setString('user', json.encode(body['user']));
        return true;
      }
      return false;
    } catch (e) {
      print('error_login');
      print(e.toString());
      return false;
    }
  }
}
