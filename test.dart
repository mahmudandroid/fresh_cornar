import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fresh_cornar/Exception/http_exception.dart';
import 'package:fresh_cornar/home/screen/home.dart';
import 'package:fresh_cornar/login/screen/login.dart';
import 'package:fresh_cornar/otp/provider/checkOtp.dart';
import 'package:fresh_cornar/register/provider/auth.dart';
import 'package:fresh_cornar/registration_home/screen/user-admin.dart';
import 'package:fresh_cornar/utility/CountDown.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';

class VerifyOtp extends StatefulWidget {
  @override
  _VerifyOtpState createState() => _VerifyOtpState();
}

FToast suToast;

class _VerifyOtpState extends State<VerifyOtp> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _testError = "";

  bool _isloading = false;
  int _otpCodeLength = 5;
  bool _isLoadingButton = false;
  bool _enableButton = false;
  String _otpCode = "";

  bool _isResendEnable = false;
  String otpWaitTimeLabel = "";

  @override
  void initState() {
    super.initState();
    // startTimer();
    _getSignatureCode();
  }

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

//    setState(() {
//      _isLoadingButton = !_isLoadingButton;
//      _verifyOtpCode(context);
//    });
  }

  _onOtpCallBack(String otpCode, bool isAutofill) {
    setState(() {
      this._otpCode = otpCode;
      if (otpCode.length == _otpCodeLength && isAutofill) {
        _enableButton = false;
        _isLoadingButton = true;
        // todo :
        _verifyOtpCode();
      } else if (otpCode.length == _otpCodeLength && !isAutofill) {
        _enableButton = true;
        _isLoadingButton = false;
      } else {
        _enableButton = false;
      }
    });
  }

  _verifyOtpCode() {
    FocusScope.of(context).requestFocus(new FocusNode());
    setState(() async {
      _isLoadingButton = false;
      _enableButton = false;
      Text("Verification OTP Code $_otpCode Success");

      print("this is code :");
      print(_otpCode);
      print("this is phone  :");

      SharedPreferences preferences = await SharedPreferences.getInstance();
      String code = preferences.getString("code");

      String name = preferences.getString("name");
      String phone = preferences.getString("phone");
      String password = preferences.getString("password");
      String email = preferences.getString("email");

      if (code == _otpCode) {
        try {
          var response = await Provider.of<Auth>(context)
              .signup(phone, password, name, email);
          _showSnack(context, response);

          print("responce");
          print(response);

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
                return Login();
              }));
        } on HttpException catch (error) {
          var errorMessage = error.toString();
          setState(() {
            _isloading = false;
          });
          _showSnack(context, errorMessage);
        } catch (error) {
          var errorMessage = "Registration is not available ";
          setState(() {
            _isloading = false;
          });
          _showSnack(context, errorMessage);
        }
        setState(() {
          _isloading = false;
        });
      } else {
        print("error in code ");
        // _testError =" Error in Code";
        // here to enable botton
        setState(() {
          _enableButton = true;
//          _isLoadingButton = true;
          _isloading = false;
        });
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
            "error code",
            textAlign: TextAlign.center,
          ),
          backgroundColor: Theme.of(context).errorColor,
        ));
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Please Write Sms Code ",
                          style: Theme.of(context).primaryTextTheme.subtitle1),
                      SizedBox(
                        height: 30,
                      ),
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
                        height: 22,
                      ),
                      Text(_testError),
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

//                    Container(
//                      width: double.maxFinite,
//                      child: MaterialButton(
//                        child: Text("VERIFY SMS",
//                            style: Theme.of(context).primaryTextTheme.button),
//                        height: 40,
//                        onPressed: _enableButton ? _onSubmitOtp : null,
////                        child: if (_isLoadingButton ) ? : ,
//                        color: Theme.of(context).primaryColor,
//                        disabledColor: Theme.of(context).primaryColorLight,
//                      ),
//                    ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                otpWaitTimeLabel == "0:0"
                                    ? ""
                                    : otpWaitTimeLabel + " s",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text("you didn't receive a code?",
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .subtitle2),
                            ],
                          ),
                          GestureDetector(
                            onTap: () => null,
                            child: Text("Click here!"),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void startTimer() {
    setState(() {
      _isResendEnable = false;
    });

    var sub = CountDown(new Duration(minutes: 2)).stream.listen(null);

    sub.onData((Duration d) {
      setState(() {
        int sec = d.inSeconds % 60;
        otpWaitTimeLabel = d.inMinutes.toString() + ":" + sec.toString();
      });
    });

    sub.onDone(() {
      setState(() {
        _isResendEnable = true;
      });
    });
  }

  void _resendOtp() {
    if (_isResendEnable) {
      // _nexmoSmsVerificationUtil.resentOtp();
    }
  }

}
