import 'package:flutter/material.dart';
import 'package:fresh_cornar/Exception/http_exception.dart';
import 'package:fresh_cornar/home/screen/home.dart';
import 'package:fresh_cornar/otp/screen/otp.dart';
import 'package:fresh_cornar/register/provider/auth.dart';
import 'package:fresh_cornar/otp/screen/resetPassword.dart';

import 'package:provider/provider.dart';

//import 'integrated/ResetPassword_screen.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginState();
  }
}

//Login_Auth login_auth = new Login_Auth();
BuildContext context;

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isloading = false;
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _passwordController = TextEditingController();
  Map<String, String> _formData = {
    'email': '',
    'password': '',
  };

  void _showSnack(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      backgroundColor: message == "now logged in"
          ? Theme.of(context).dialogBackgroundColor
          : Theme.of(context).errorColor,
    ));
  }

  Future<void> _submit(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isloading = true;
    });
    try {
      String _response = await Provider.of<Auth>(context)
          .login(_formData['phone'], _formData['password']);
      _showSnack(context, _response);
      // await checkLogin(context,_formData['phone'], _formData['password']);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return Home();
      }));
    } on HttpException catch (error) {
      _showSnack(context, error.toString());
    } catch (error) {
      const errorMessage = "couldn't authenticate you! please try later ";
      _showSnack(context, errorMessage);
    }
    setState(() {
      _isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double _deviceWidth = MediaQuery.of(context).size.width;
    final double _targetWidth =
        _deviceWidth > 550.0 ? 500.0 : _deviceWidth * .95;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Container(
        width: _targetWidth,
        height: MediaQuery.of(context).size.height,
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 14),
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
                  TextFormField(
                    focusNode: _emailFocus,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_passwordFocus),
                    decoration: InputDecoration(
                      hintText: "Phone Number",
                    ),
                    keyboardType: TextInputType.phone,
                    onSaved: (value) => _formData['phone'] = value,
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
                  SizedBox(height: 20),
                  TextFormField(
                    focusNode: _passwordFocus,
                    onFieldSubmitted: (_) => _submit,
                    onSaved: (value) => _formData['password'] = value,
                    decoration: InputDecoration(
                      hintText: "Password",
                    ),
                    obscureText: true,
                  ),
                ],
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
                                    child: Text("Login",
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .button),
                                    onPressed: () => _submit(context)),
                              ),
                              SizedBox(height: 20),
                              Container(
                                  child: GestureDetector(
                                      child: Text(
                                        "Forget password ?",
                                        textAlign: TextAlign.center,
                                      ),
                                      onTap: () => Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return RestPassword();
                                          })))),
                            ],
                          ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
