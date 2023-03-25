import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/sign_up_controller.dart';

class SignUpVerifyPage extends StatefulWidget {
  const SignUpVerifyPage({Key? key}) : super(key: key);

  @override
  _SignUpVerifyPageState createState() => _SignUpVerifyPageState();
}

class _SignUpVerifyPageState extends State<SignUpVerifyPage> {
  TextEditingController otpTextEditingController = new TextEditingController();
  SignUpController _signUpController = Get.put(SignUpController());
 Duration duration = Duration();

  late Timer _timer;
  int _start = 60;

  RxBool isLoading = false.obs;

  @override
  void initState() {
    // TODO: implement initState
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
    return Scaffold(
        backgroundColor: Colors.white,
        body:  ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0,top: 25),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: Image.asset("assets/images/logo.png",
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              height:170,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(5, 75, 169, 1),
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(220),)
                                //more than 50% of width makes circle
                              ),
                            ),

                          ),
                        ],
                      ),
                      Stack(
                          children:[ Container(
                            height:100,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(5, 75, 169, 1),
                                borderRadius: BorderRadius.circular(100)
                              //more than 50% of width makes circle
                            ),
                          ),
                            Container(
                              child: Image.asset("assets/images/Done.png",
                                width: 100,
                                height: 100,
                              ),
                            ),
                          ]),
                      SizedBox(height: 20,),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Text("Sign Up",
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              ?.copyWith(
                            fontSize: 32,
                            color: Color.fromRGBO(5, 75, 169, 1),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Text("Verify Your Email Address.",
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              ?.copyWith(
                            fontSize: 14,
                            color: Color.fromRGBO(0, 0, 0, 1),

                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: otpTextEditingController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                              label: Text('OTP'),
                              focusColor: Color.fromRGBO(5, 75, 169, 1)
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50.0,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      side: BorderSide(color: Color.fromRGBO(9, 74, 157, 1))
                                  )
                              ),
                              elevation: MaterialStateProperty.all(10.0),
                              backgroundColor:
                              MaterialStateProperty.all(Color.fromRGBO(9, 74, 157, 1)),
                              foregroundColor: MaterialStateProperty.all(Colors.white),
                            ),
                            child: isLoading.value ? Center(child: CircularProgressIndicator(
                              color: Colors.white,
                            ),):  Text(
                              'Verify',
                              style: TextStyle(color: Colors.white,fontSize: 16,letterSpacing: 0.6),
                            ),
                            onPressed: ()async {
                              var prefs = await SharedPreferences.getInstance();
                              // setState(() {
                              //   isLoading.value = true;
                              // });
                              // if (otpTextEditingController != "") {
                              //   _signUpController.verifyOTP(
                              //       _signUpController.emailTextEditingController
                              //           .text, otpTextEditingController.text)
                              //       .then((value) {
                              //     if (value['msg'] != "You have enterd wrong otp") {
                              //         setState(() {
                              //           isLoading.value = true;
                              //         });
                              //       prefs.setString(SPKeys.LOGINDONE, 'DONE');
                              //       Get.offAllNamed(MRouter.homeScreen);
                              //     } else {
                              //       Fluttertoast.showToast(
                              //         msg: "${value['msg']}",
                              //         toastLength: Toast.LENGTH_SHORT,
                              //         gravity: ToastGravity.BOTTOM,
                              //         fontSize: 14.0,
                              //       );
                              //       setState(() {
                              //         isLoading.value = false;
                              //       });
                              //     }
                              //   });
                              // } else {
                              //   Fluttertoast.showToast(
                              //     msg: "Please Enter OTP",
                              //     toastLength: Toast.LENGTH_SHORT,
                              //     gravity: ToastGravity.BOTTOM,
                              //     fontSize: 14.0,
                              //   );
                              // }
                            }
                          )
    ),
                      ),
                      Spacer(),
                      _start > 0 ? Center(child: Container(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(color: Color.fromRGBO(9, 74, 157, 1),),)) : Center(
                        child: InkWell(
                          onTap: (){
                            // _signUpController.otpClick();
                            // setState(() {
                            //   isLoading.value = true;
                            //   _start = 60;
                            // });
                            startTimer();
                            // _signUpController.signUpClick().then((value) {
                            //   if(value == 200) {
                            //     setState(() {
                            //       isLoading.value = false;
                            //     });
                            //   }else{
                            //     setState(() {
                            //       isLoading.value = false;
                            //     });
                            //   }
                            // });
                          },
                          child: Text(
                            "Resend OTP ?",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(
                                color: Color.fromRGBO(9, 74, 157, 1),
                                decoration:
                                TextDecoration.underline),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text("$_start sec",
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            ?.copyWith(
                          fontSize: 16,
                          color: Color.fromRGBO(9, 74, 157, 1),),
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already Have An Account ?",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color.fromRGBO(5, 75, 169, 1)
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      SizedBox(height: 40,)
                    ],
                  )
              ),
            ]));
  }
}
