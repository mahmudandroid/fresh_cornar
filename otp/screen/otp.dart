import 'package:flutter/material.dart';
import 'package:fresh_cornar/Exception/http_exception.dart';
import 'package:fresh_cornar/register/provider/auth.dart';
import 'package:fresh_cornar/registration_home/screen/user-admin.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';

class VerifyOtp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

Auth _auth = new Auth();

class _MyAppState extends State<VerifyOtp> {
  bool _isloading = false;

  int _otpCodeLength = 5;
  bool _isLoadingButton = false;
  bool _enableButton = false;
  String _otpCode = "";
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _getSignatureCode();
  }

  /// get signature code
  _getSignatureCode() async {
    String signature = await SmsRetrieved.getAppSignature();
    print("signature $signature");
  }

  _onSubmitOtp() {
    setState(() {
      _isLoadingButton = !_isLoadingButton;
      _isloading = true;
      _verifyOtpCode();
    });
  }

  _onOtpCallBack(String otpCode, bool isAutofill) {
    setState(() {
      this._otpCode = otpCode;
      if (otpCode.length == _otpCodeLength && isAutofill) {
        _enableButton = false;
        _isLoadingButton = true;
        _verifyOtpCode();
      } else if (otpCode.length == _otpCodeLength && !isAutofill) {
        _enableButton = true;
        _isLoadingButton = false;
      } else {
        _enableButton = false;
      }
    });
  }

  _verifyOtpCode() async {
    FocusScope.of(context).requestFocus(new FocusNode());

    setState(() {
      _isLoadingButton = false;
      _enableButton = false;
    });

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String code = preferences.getString("code");

    String name = preferences.getString("name");
    String phone = preferences.getString("phone");
    String password = preferences.getString("password");
    String email = preferences.getString("email");

    if (code == _otpCode) {
      setState(() {
        _isLoadingButton = false;
        _enableButton = false;
        _isloading = true;
      });
     regiseterUser(phone, password, name, email);

    } else {
      setState(() {
        _isLoadingButton = true;
        _enableButton = true;
        _isloading = false;
      });
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text("Verification OTP Code $_otpCode Fail")));
    }
  }


   BuildContext tempContext  ;

  @override
  Widget build(BuildContext context) {

    tempContext =  context ;
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Verfiy Phone",
            style: Theme.of(context).primaryTextTheme.headline6,
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFieldPin(
                  filledColor: Colors.grey.shade200,
                  borderStyeAfterTextChange: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(3))),
                  filled: true,
                  codeLength: _otpCodeLength,
                  boxSize: 46,
                  filledAfterTextChange: true,
                  textStyle: TextStyle(fontSize: 16),
                  borderStyle: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  onOtpCallback: (code, isAutofill) =>
                      _onOtpCallBack(code, isAutofill),
                ),
                SizedBox(
                  height: 32,
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 30),
                      _isloading
                          ? CircularProgressIndicator()
                          : Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: MaterialButton(
                                    child: Text("VERIFY SMS",
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .button),
                                    height: 40,
                                    onPressed:
                                        _enableButton ? _onSubmitOtp : null,
//                        child: if (_isLoadingButton ) ? : ,
                                    color: Theme.of(context).primaryColor,
                                    disabledColor:
                                        Theme.of(context).primaryColorLight,
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }

  Widget _setUpButtonChild() {
    if (_isLoadingButton) {
      return Container(
        width: 19,
        height: 19,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      return Text(
        "Verify",
        style: TextStyle(color: Colors.white),
      );
    }
  }

  Future<void> regiseterUser(String phone  ,String password,String  name  ,String email) async {
    try {
      var response = await Provider.of<Auth>(context)
          .signup(phone, password, name, email);
//      _showSnack(context, response);

      if(response == 'Now you can login'){
        _scaffoldKey.currentState.showSnackBar(
            SnackBar(content: Text("Verification OTP Code $_otpCode Success s")));

      }else {
        _scaffoldKey.currentState.showSnackBar(
            SnackBar(content: Text("Verification OTP Code $_otpCode fail regiser") ,backgroundColor:Theme.of(context).errorColor));
      }

      print("responce reg");
      print(response);

      setState(() {
        _isLoadingButton = true;
        _enableButton = true;
        _isloading = false;
      });

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) {
            return UserAdmin();
          }));
    } on HttpException catch (error) {
      var errorMessage = error.toString();
//      _showSnack(context, errorMessage);
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text("Verification OTP Code $_otpCode fail 1")));
    } catch (error) {
      var errorMessage = "Registration is not available ";
//      _showSnack(context, errorMessage);
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text("Verification OTP Code $_otpCode fail 2")));
    }
  }
}
