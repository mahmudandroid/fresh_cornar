import 'package:fresh_cornar/Exception/http_exception.dart';
import 'package:fresh_cornar/utility/URL.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationOtp {
  //  functon for check sms code otp
  Future<int> verifyOtp(String phone, String code) async {
    String url_otp = "";
    var response = await http.post(url_otp, body: {
      "phone": phone,
      "code": code,
    });

    switch (response.statusCode) {
      case 200:
        try {
          var data = jsonDecode(response.body);
          bool success = data['success'];
          print(success);

          if (success == true) {
            return 1;
          } else {
            return 0;
          }
        } catch (Exception) {
          // throw Exception() ;
          return 0;
        }
        break;
    }

    print(response.body);
    return 0;
  }

  Future<int> restPassword (String  phone) async{
    String urlRestPassword =  Url.urlGetCode;
    try {
      final _response = await http.post(urlRestPassword, body: {
        'phone': phone,
      });


      switch (_response.statusCode) {
        case 200:
          var data = jsonDecode(_response.body);
          String code = data['code'];
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setString("code", code);
          print(code);
          return 200;
          break;
        default :
          return 210;

//        case 201:
//          return 201;
//          break;
//       case 401:
//          return 401;
//          break;
//        case 404:
//          return 404;
//          break;
//        case 403:
//          return 403;
//          break;
//        case 500:
//          return 500;
//          break;
//        case 503:
//          return 501;
//          break;
//        case 201:
//          return 201;
//          break;
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
