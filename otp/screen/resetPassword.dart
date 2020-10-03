import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fresh_cornar/Exception/http_exception.dart';
import 'package:fresh_cornar/login/screen/login.dart';
import 'package:fresh_cornar/otp/provider/checkOtp.dart';
import 'package:fresh_cornar/otp/screen/otp.dart';

class RestPassword extends StatefulWidget {
  static const routNameRestPassword = "restPassword";

  @override
  _restPasswordState createState() => _restPasswordState();
}

AuthenticationOtp _authenticationOtp = new AuthenticationOtp();
bool _isloading = false;

class _restPasswordState extends State<RestPassword> {
  Map<String, String> _formData = {
    'phone': '',
  };

  void _showSnack(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
//      backgroundColor: message == "now logged in"
//          ? Theme.of(context).dialogBackgroundColor
//          : Theme.of(context).errorColor,
    ));
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double _deviceWidth = MediaQuery.of(context).size.width;
    final double _targetWidth =
        _deviceWidth > 550.0 ? 500.0 : _deviceWidth * .95;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Password Rest",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Container(
          width: _targetWidth,
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: _formKey,
            autovalidate: true,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 9),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        height: 60,
                        width: 70,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/meat.png"),
                                fit: BoxFit.cover)),
                      ),
                      Text(
                        "Other Level",
                        //style: Theme.of(context).textTheme.body1,
                      ),
                      Text(
                        'FREASH CORNER',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 7),
                Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    TextFormField(
                      onSaved: (value) => _formData['phone'] = value,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        hintText: "phone",
                      ),
                      obscureText: false,
                      validator: (String value) {
                        if (value.isEmpty ||
                            !RegExp(r'(^(?:[+0]9)?[0-9]{6,14}$)')
                                .hasMatch(value)) {
                          return 'Please enter a valid number';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 30),
                      _isloading
                          ? CircularProgressIndicator(
                              // backgroundColor: Theme.of(context).primaryColor,
                              )
                          : Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: RaisedButton(
                                      color: Theme.of(context).primaryColor,
                                      child: Text("Reset",
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .button),
                                      onPressed: () async {
                                        if (!_formKey.currentState.validate()) {
                                          return;
                                        }
                                        _formKey.currentState.save();

                                        setState(() {
                                          _isloading = true;
                                        });

                                        try {
                                          int _response =
                                              await _authenticationOtp
                                                  .restPassword(
                                                      _formData['phone']);
                                          print("responce :");
                                          print(_response);
                                          switch (_response) {
                                            case 200:
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return VerifyOtp();
                                              }));
                                              break;
                                            default:
                                              _showSnack(context,
                                                  "error in phone nunmber");
                                              setState(() {
                                                _isloading = false;
                                              });
                                              print("not send sms");
                                          }
                                          // await checkLogin(context,_formData['phone'], _formData['password']);
                                        } on HttpException catch (error) {
                                          _showSnack(context, error.toString());
                                        } catch (error) {
                                          const errorMessage =
                                              "error in phone nuber ";
                                          _showSnack(context, errorMessage);
                                        }
                                        setState(() {
                                          _isloading = false;
                                        });
                                      }),
                                ),
                                SizedBox(height: 20),
//                                Container(
//                                    child: GestureDetector(
//                                        child: Text(
//                                          "Forget password ?",
//                                          textAlign: TextAlign.center,
//                                        ),
//                                        onTap: () => Navigator.push(context,
//                                                MaterialPageRoute(
//                                                    builder: (context) {
//                                              return VerifyOtp();
//                                            })))),
                              ],
                            ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
