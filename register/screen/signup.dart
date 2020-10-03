import 'package:flutter/material.dart';
import 'package:fresh_cornar/Exception/http_exception.dart';
import 'package:fresh_cornar/otp/provider/checkOtp.dart';
import 'package:fresh_cornar/otp/screen/otp.dart';
import 'package:fresh_cornar/register/provider/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart';
import 'package:provider/provider.dart';


AuthenticationOtp _authenticationPhone = new AuthenticationOtp();

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUp> {
  final _passwordFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _repasswordFocus = FocusNode();

  //final passwordFocus = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> _formData = {
    'phone': '',
    'password': '',
    'name': '',
    'email': ''
  };
  var _isloading = false;
  final _passwordController = TextEditingController();

  void _showSnack(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      backgroundColor: message == "Now you can login"
          ? Theme.of(context).dialogBackgroundColor
          : Theme.of(context).errorColor,
    ));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isloading = true;
    });
    try {
      int _response =
      await _authenticationPhone
          .restPassword(
          _formData['phone']);
      switch (_response) {
        case 200:
          SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
          sharedPreferences.setString("name", _formData['name']);
          sharedPreferences.setString("phone", _formData['phone']);
          sharedPreferences.setString("password", _formData['password']);
          sharedPreferences.setString("email", _formData['email']);
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

//      var response = await Provider.of<Auth>(context).signup(_formData['phone'],
//          _formData['password'], _formData['name'], _formData['email']);
//      _showSnack(context, response);


    } on HttpException catch (error) {
      var errorMessage = error.toString();
      _showSnack(context, errorMessage);
    } catch (error) {
      var errorMessage = "Registration is not available ";
      _showSnack(context, errorMessage);
    }
    setState(() {
      _isloading = false;
    });
  }

  @override
  void dispose() {
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _repasswordFocus.dispose();
    _phoneFocus.dispose();

    return super.dispose();
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
              SizedBox(height: MediaQuery.of(context).size.height / 17),
              Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "name",
                    ),
                    validator: (String value) {
                      if (value.isEmpty ||
                          RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                              .hasMatch(value)) {
                        return 'please enter your name';
                      }
                    },
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_emailFocus),
                    onSaved: (value) => _formData['name'] = value,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    focusNode: _emailFocus,
                    decoration: InputDecoration(
                      hintText: "email (optional)",
                    ),
                    validator: (String value) {
                      if (!value.isEmpty) {
                        if (!RegExp(
                                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                            .hasMatch(value)) {
                          return "Enter a valid email";
                        }
                      }
                    },
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_phoneFocus),
                    onSaved: (value) => _formData['email'] = value,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    focusNode: _phoneFocus,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_passwordFocus),
                    decoration: InputDecoration(
                      hintText: "Phone Number",
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (String value) {
                      if (value
                              .isEmpty /*||
                          !RegExp().hasMatch(value)*/
                          ) {
                        return 'Please enter a valid number';
                      }
                    },
                    onSaved: (value) => _formData['phone'] = value,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    focusNode: _passwordFocus,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: "Password",
                    ),
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_repasswordFocus),
                    obscureText: true,
                    validator: (String value) {
                      if (value.isEmpty || value.length < 6) {
                        return 'Password invalid';
                      }
                    },
                    onSaved: (value) => _formData['password'] = value,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                      focusNode: _repasswordFocus,
                      decoration: InputDecoration(
                        hintText: "Password Again",
                      ),
                      obscureText: true,
                      validator: (String value) {
                        if (value != _passwordController.text) {
                          return 'Password not matched!!';
                        }
                      },
                      onFieldSubmitted: (_) => _submit),
                ],
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 30),
                    _isloading
                        ? CircularProgressIndicator()
                        : Container(
                            width: double.infinity,
                            child: RaisedButton(
                              color: Theme.of(context).primaryColor,
                              child: Text("Signup",
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .button),
                              onPressed: _submit,
                            ),
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
