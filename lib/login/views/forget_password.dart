import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../theme_manager.dart';
import '../controllers/forget_password_controller.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  ForgetController _forgetPasswordController = Get.put(ForgetController());
  final _formKeyEmail = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.grey[200],
          child: Image.asset(
            "assets/images/png/backgroun_image.png",
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Card(
              semanticContainer: false,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 20,
              color: Colors.white,
              child: Container(
                  padding: EdgeInsets.all(20.0),
                  color: Colors.transparent,
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Forgot",
                          style: Theme.of(context).textTheme.caption?.copyWith(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Forgot your password",
                          style: Theme.of(context).textTheme.caption?.copyWith(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                          // style: TextStyle(
                          //     fontSize: 14,
                          //     fontWeight: FontWeight.normal,
                          //     color: Color(0xffaeb3cb)
                          // ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  suffixIcon: Icon(
                                    Icons.email,
                                    color: Color.fromRGBO(99, 99, 255, 1),
                                  ),
                                  label: const Text('Email'),
                                  focusColor: Color.fromRGBO(99, 99, 255, 1)),
                              controller: _forgetPasswordController
                                  .emailTextEditingController,
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 50.0,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          side: BorderSide(
                                              color: Color.fromRGBO(
                                                  99, 99, 255, 1)))),
                                  elevation: MaterialStateProperty.all(3.0),
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromRGBO(99, 99, 255, 1)),
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                ),
                                child: const Text(
                                  'Continue',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      letterSpacing: 0.6),
                                ),
                                onPressed: () {

                                  // login();
                                  // print('on press');
                                  // login(context);
                                  // callDeclaration(context);
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Text(
                                "Or login with social media",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    // signInWithGoogle();
                                  },
                                  child: Image.asset(
                                      'assets/images/png/google.png',
                                      width: 30),
                                ),
                                SizedBox(width: 30),
                                InkWell(
                                    onTap: () {
                                      // signInWithFacebook();
                                    },
                                    child: Image.asset(
                                        'assets/images/png/facebook.png',
                                        width: 37)),
                                // SizedBox(width: 30),
                                // InkWell(
                                //     onTap:(){
                                //
                                //     },
                                //     child: Image.asset('assets/twitter.png',width: 42)),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an Account ?",
                              style:
                                  Theme.of(context).textTheme.caption?.copyWith(
                                        color: Colors.black,
                                      ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => ForgotPasswordScreen(),
                                //   ),
                                // );
                                // Navigator.pushReplacementNamed(
                                //     context, Routes.Signup);
                              },
                              child: Center(
                                child: Text(
                                  "Sign Up",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
                                          color: Colors.black,
                                          decoration: TextDecoration.underline),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        )
      ],
    );
  }
}

class OTPVerify extends StatefulWidget {
  const OTPVerify({Key? key}) : super(key: key);

  @override
  _OTPVerifyState createState() => _OTPVerifyState();
}

class _OTPVerifyState extends State<OTPVerify> {
  late Timer _timer;
  int _start = 60;
  RxBool isLoading = false.obs;

  ForgetController _forgetPasswordController = Get.put(ForgetController());
  final _formKeyOTP = GlobalKey<FormState>();

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    print('datat');
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Image.asset(
            "assets/images/png/backgroun_image.png",
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
        ),
    Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Card(
                  semanticContainer: false,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  elevation: 20,
                  color: Colors.white,
                  child: Container(
                      padding: EdgeInsets.all(20.0),
                      color: Colors.transparent,
                      child: SingleChildScrollView(
                        reverse: true,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Verify OTP",
                              style: Theme.of(context).textTheme.caption?.copyWith(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "We have sent OTP to your Register Email",
                              style: Theme.of(context).textTheme.caption?.copyWith(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                              // style: TextStyle(
                              //     fontSize: 14,
                              //     fontWeight: FontWeight.normal,
                              //     color: Color(0xffaeb3cb)
                              // ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15)),
                                      // suffixIcon: Icon(Icons.,color: Color(0xfff78361),),
                                      label: const Text('OTP'),
                                      focusColor: Color.fromRGBO(99, 99, 255, 1)),
                                  controller: _forgetPasswordController
                                      .emailTextEditingController,
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 50.0,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              side: BorderSide(
                                                  color: Color.fromRGBO(
                                                      99, 99, 255, 1)))),
                                      elevation: MaterialStateProperty.all(3.0),
                                      backgroundColor: MaterialStateProperty.all(
                                          Color.fromRGBO(99, 99, 255, 1)),
                                      foregroundColor:
                                          MaterialStateProperty.all(Colors.white),
                                    ),
                                    child: const Text(
                                      'Verify',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          letterSpacing: 0.6),
                                    ),
                                    onPressed: () {
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                _start > 0
                                    ? Center(
                                        child: Container(
                                        height: 30,
                                        width: 30,
                                        child: CircularProgressIndicator(
                                          color: AppColors.googleRed,
                                        ),
                                      ))
                                    : Center(
                                        child: InkWell(
                                          onTap: () {
                                            startTimer();
                                          },
                                          child: Text(
                                            "Resend OTP ?",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                ?.copyWith(
                                                    color: Color.fromRGBO(
                                                        99, 99, 255, 1),
                                                    decoration:
                                                        TextDecoration.underline),
                                          ),
                                        ),
                                      ),
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: Text(
                                    "$_start sec",
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        ?.copyWith(
                                          fontSize: 16,
                                          color: Color.fromRGBO(99, 99, 255, 1),
                                        ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: Text(
                                    "Or login with social media",
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        ?.copyWith(
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      child: Image.asset(
                                          'assets/images/png/google.png',
                                          width: 30),
                                    ),
                                    SizedBox(width: 30),
                                    InkWell(
                                        onTap: () {
                                          // signInWithFacebook();
                                        },
                                        child: Image.asset(
                                            'assets/images/png/facebook.png',
                                            width: 37)),
                                    // SizedBox(width: 30),
                                    // InkWell(
                                    //     onTap:(){
                                    //
                                    //     },
                                    //     child: Image.asset('assets/twitter.png',width: 42)),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an Account ?",
                                  style:
                                      Theme.of(context).textTheme.caption?.copyWith(
                                            color: Colors.black,
                                          ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => ForgotPasswordScreen(),
                                    //   ),
                                    // );
                                    // Navigator.pushReplacementNamed(
                                    //     context, Routes.Signup);
                                  },
                                  child: Center(
                                    child: Text(
                                      "Sign Up",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          ?.copyWith(
                                              color: Colors.black,
                                              decoration: TextDecoration.underline),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            )
      ],
    );
  }
}
