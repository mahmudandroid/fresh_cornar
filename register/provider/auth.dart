import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:fresh_cornar/Exception/http_exception.dart';
import 'package:fresh_cornar/utility/URL.dart';
import 'package:http/http.dart' as http;


class Auth with ChangeNotifier {
  String _token;
  DateTime _expireDate;
  DateTime _userId;

  Future<String> signup(
      String phone, String password, String name, String email) async {
    const url = Url.register;

    try {
      final _response = await http.post(url, body: {
        'name': name,
        'password': password,
        'phone': phone,
        'email': email,
        'user_type_id': "1",
        'status_id': "1",
      });
      print(_response.body);
      switch (_response.statusCode) {
        case 200:
          return "Now you can login";
          break;
        case 201:
          return "Now you can login";
          break;
      /* case 1062:
          return "please use unused number";
          break;
        case 401:
          return "you are unotherized";
          break;
        case 404:
          return "this page not found";
          break;*/
        case 403:
          return "Forbiden";
          break;
      /*
        case 500:
          return "Internal Server Error";
          break;
        case 503:
          return "services Not Available";
          break;
        case 550:
          return "Permission Denied";
          break;*/
      }
      final _responseData = json.decode(_response.body);

      if (_responseData["success"] != true) {
        throw HttpException("Please use another number");
      }
    } catch (error) {
      throw error;
    }

/*switch(response.statusCode){
      case 200  :
        return  200 ;
        break ;
    }*/
  }

  Future<String> login(String phone, String password) async {
    try {
      const url = Url.login;
      final _response = await http.post(url, body: {
        'phone': phone,
        'password': password,
      });
      switch (_response.statusCode) {
        case 200:
          return "now logged in";
          break;
        case 201:
          return "now logged in";
          break;
      /*  case 401:
          return "you are unotherized";
          break;
        case 404:
          return "this page not found";
          break;
        case 403:
          return "Forbiden";
          break;
        case 500:
          return "Internal Server Error";
          break;
        case 503:
          return "services Not Available";
          break;
        case 201:
          return "Permission Denied";
          break;*/
      }
      print(_response.body);

      final _responseData = json.decode(_response.body);

      if (_responseData["message"] != null) {
        throw HttpException(_responseData["message"]);
      }
    } catch (error) {
      throw error;
    }
  }
}
