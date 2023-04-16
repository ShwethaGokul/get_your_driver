import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_your_driver/screens/login/sign_in_controller.dart';

import '../../theme_manager.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);
  SignInSignUpController signInSignUpController =
      Get.put(SignInSignUpController());

  @override
  Widget build(BuildContext context) {
    return bottomSheet(context);
  }

  bottomSheet(BuildContext context) {
    signInSignUpController.isOTPPage.value = false;
    signInSignUpController.clearAllField();
    signInSignUpController.selectTab(true);
    signInSignUpController.phoneSignUpTextEditingController.clear();
    showModalBottomSheet(
        context: context,
        // barrierColor: popupBackground,
        isScrollControlled: true, // only work on showModalBottomSheet function
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (context) => Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                height: 400, //height or you can use Get.width-100 to set height
                child: ListView(
                  children: [
                    // SizedBox(height: Get.height*0.1),
                    Obx(() => Container(
                          margin: EdgeInsets.only(left: 12, right: 12, top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: SizedBox(
                                  height: 45,
                                  width: Get.width / 2.40,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              side: const BorderSide(
                                                  color: Color(0xffFF7373)))),
                                      backgroundColor: signInSignUpController
                                              .isSignInTab.value
                                          ? MaterialStateProperty.all(
                                              Color(0xffFF7373))
                                          : MaterialStateProperty.all(
                                              Colors.white),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              Color(0xffFF7373)),
                                    ),
                                    child: Text(
                                      'SIGN-IN',
                                      style: TextStyle(
                                        color: signInSignUpController
                                                .isSignInTab.value
                                            ? Colors.white
                                            : Color(0xffFF7373),
                                        fontSize: 15,
                                      ),
                                    ),
                                    onPressed: () {
                                      signInSignUpController.isOTPPage.value = false;
                                      signInSignUpController.selectTab(true);
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.08,
                              ),
                              Container(
                                child: SizedBox(
                                  height: 45,
                                  width: Get.width / 2.40,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              side: const BorderSide(
                                                  color: Color(0xffFF7373)))),
                                      backgroundColor: signInSignUpController
                                              .isSignUpTab.value
                                          ? MaterialStateProperty.all(
                                              Color(0xffFF7373))
                                          : MaterialStateProperty.all(
                                              Colors.white),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              Color(0xffFF7373)),
                                    ),
                                    child: Text(
                                      'SIGN-UP',
                                      style: TextStyle(
                                          color: signInSignUpController
                                                  .isSignUpTab.value
                                              ? Colors.white
                                              : Color(0xffFF7373),
                                          fontSize: 15),
                                    ),
                                    onPressed: () {
                                      signInSignUpController.isOTPPage.value = false;
                                      signInSignUpController.selectTab(false);
                                      signInSignUpController
                                          .phoneSignUpTextEditingController
                                          .clear();
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                    Obx(() => signInSignUpController.isSignInTab.value
                        ? signInView(context)
                        : signUpView(context))
                  ],
                ),
              ),
            ));
    // signInSignUpController.isOTPPage.value = false;
    // showModalBottomSheet(
    //     isScrollControlled: true,
    //     context: context,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.only(
    //           topRight: Radius.circular(15), topLeft: Radius.circular(15)),
    //     ),
    //     builder: (context) => Container(
    //           height: 400,
    //           child: ListView(
    //             children: [
    //               // SizedBox(height: Get.height*0.1),
    //               Obx(() => Container(
    //                     margin: EdgeInsets.only(left: 12, right: 12, top: 20),
    //                     child: Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       children: [
    //                         Container(
    //                           child: SizedBox(
    //                             height: 45,
    //                             width: Get.width / 2.40,
    //                             child: ElevatedButton(
    //                               style: ButtonStyle(
    //                                 shape: MaterialStateProperty.all<
    //                                         RoundedRectangleBorder>(
    //                                     RoundedRectangleBorder(
    //                                         borderRadius:
    //                                             BorderRadius.circular(5.0),
    //                                         side: const BorderSide(
    //                                             color: Color(0xffFF7373)))),
    //                                 backgroundColor:
    //                                     signInSignUpController.isSignInTab.value
    //                                         ? MaterialStateProperty.all(
    //                                             Color(0xffFF7373))
    //                                         : MaterialStateProperty.all(
    //                                             Colors.white),
    //                                 foregroundColor: MaterialStateProperty.all(
    //                                     Color(0xffFF7373)),
    //                               ),
    //                               child: Text(
    //                                 'SIGN-IN',
    //                                 style: TextStyle(
    //                                   color: signInSignUpController
    //                                           .isSignInTab.value
    //                                       ? Colors.white
    //                                       : Color(0xffFF7373),
    //                                   fontSize: 15,
    //                                 ),
    //                               ),
    //                               onPressed: () {
    //                                 signInSignUpController.selectTab(true);
    //                               },
    //                             ),
    //                           ),
    //                         ),
    //                         SizedBox(
    //                           height: Get.height * 0.08,
    //                         ),
    //                         Container(
    //                           child: SizedBox(
    //                             height: 45,
    //                             width: Get.width / 2.40,
    //                             child: ElevatedButton(
    //                               style: ButtonStyle(
    //                                 shape: MaterialStateProperty.all<
    //                                         RoundedRectangleBorder>(
    //                                     RoundedRectangleBorder(
    //                                         borderRadius:
    //                                             BorderRadius.circular(5.0),
    //                                         side: const BorderSide(
    //                                             color: Color(0xffFF7373)))),
    //                                 backgroundColor:
    //                                     signInSignUpController.isSignUpTab.value
    //                                         ? MaterialStateProperty.all(
    //                                             Color(0xffFF7373))
    //                                         : MaterialStateProperty.all(
    //                                             Colors.white),
    //                                 foregroundColor: MaterialStateProperty.all(
    //                                     Color(0xffFF7373)),
    //                               ),
    //                               child: Text(
    //                                 'SIGN-UP',
    //                                 style: TextStyle(
    //                                     color: signInSignUpController
    //                                             .isSignUpTab.value
    //                                         ? Colors.white
    //                                         : Color(0xffFF7373),
    //                                     fontSize: 15),
    //                               ),
    //                               onPressed: () {
    //                                 signInSignUpController.selectTab(false);
    //                               },
    //                             ),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   )),
    //               Obx(() => signInSignUpController.isSignInTab.value
    //                   ? signInView(context)
    //                   : signUpView(context))
    //             ],
    //           ),
    //         ));
  }

  signInView(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: Get.height * 0.02,
        ),
        signInSignUpController.isOTPPage.value == false
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: signInSignUpController.formKeyMobileNumber,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        return null;
                      } else {
                        return ' Mobile Number';
                      }
                    },
                    decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        label: const Text('Mobile Number',
                            style: TextStyle(color: Color(0xffFF7373))),
                        focusedBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          borderSide: BorderSide(color: Color(0xffFF7373)),
                        )),
                    controller:
                        signInSignUpController.phoneSignUpTextEditingController,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10)
                    ], // for mobile
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: signInSignUpController.formKeyOtp,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        return null;
                      } else {
                        return 'Enter OTP';
                      }
                    },
                    decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xffFF7373), width: 0.0),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        label: const Text(
                          'OTP',
                          style: TextStyle(color: Color(0xffFF7373)),
                        ),
                        focusedBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          borderSide: BorderSide(color: Color(0xffFF7373)),

                        )),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(4)
                    ],
                    controller: signInSignUpController.otpTextEditingController,
                  ),
                ),
              ),
        const SizedBox(height: 40),
        signInSignUpController.isOTPPage.value
            ? Container(
                margin: EdgeInsets.only(top: 15),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 45.0,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      side: const BorderSide(
                                          color: Color(0xffFF7373)))),
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xffFF7373)),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.white),
                            ),
                            child: signInSignUpController.isLoading.value
                                ? Container(
                                    width: 30,
                                    height: 30,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    'VERIFY OTP',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        letterSpacing: 0.6),
                                  ),
                            onPressed: () {
                              if (!signInSignUpController
                                  .formKeyOtp.currentState!
                                  .validate()) {
                                return;
                              } else {
                                signInSignUpController.isLoading.value = true;
                                signInSignUpController.veryfyOTP(context);
                              }
                            }),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    signInSignUpController.start.value > 0
                        ? Container(
                            margin: EdgeInsets.only(top: 20),
                            child: InkWell(
                              onTap: () {},
                              child: Text(
                                "You can resend otp in ${signInSignUpController.start.value}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(
                                      color: Colors.black,
                                      decoration: TextDecoration.underline,
                                    ),
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: double.infinity,
                              height: 45.0,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          side: const BorderSide(
                                              color: Color(0xffFF7373)))),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                ),
                                child: const Text(
                                  'RESEND OTP',
                                  style: TextStyle(
                                      color: Color(0xffFF7373),
                                      fontSize: 18,
                                      letterSpacing: 0.6),
                                ),
                                onPressed: () {
                                  signInSignUpController.signInClick();
                                },
                              ),
                            ),
                          ),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: BorderSide(color: Color(0xffFF7373)))),
                      elevation: MaterialStateProperty.all(3.0),
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xffFF7373)),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    child: signInSignUpController.isLoading.value
                        ? Container(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            'SIGN IN',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                letterSpacing: 0.6),
                          ),
                    onPressed: () {
                      if (!signInSignUpController
                          .formKeyMobileNumber.currentState!
                          .validate()) {
                        return;
                      } else {
                        signInSignUpController.isLoading.value = true;
                        signInSignUpController.signInClick();
                      }
                    },
                  ),
                ),
              ),
        SizedBox(
          height: 20,
        ),
        Visibility(
          visible: signInSignUpController.isOTPPage.value ? false : true,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "New to GetYourDriver ?",
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: Colors.black, decoration: TextDecoration.underline),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  signInSignUpController.selectTab(false);
                  signInSignUpController.phoneSignUpTextEditingController
                      .clear(); // signUpView(context);
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
                    "Sign up",
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: Colors.black,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  signUpView(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Visibility(
          visible: signInSignUpController.isOTPPage.value ? false : true,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: signInSignUpController.formKeyUserName,
              child: TextFormField(
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return null;
                  } else {
                    return 'Enter Full Name';
                  }
                },
                decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    // suffixIcon: Icon(Icons.phone,color: Color.fromRGBO(125,1,120,1),),
                    label: const Text('Full Name',
                        style: TextStyle(color: Color(0xffFF7373))),
                    focusedBorder: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(15.0),
                      borderSide: BorderSide(color: Color(0xffFF7373)),
                    )),
                controller:
                    signInSignUpController.usernameTextEditingController,
              ),
            ),
          ),
        ),
        Visibility(
          visible: signInSignUpController.isOTPPage.value ? false : true,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: signInSignUpController.formKeySingUpMobileNumber,
              child: TextFormField(
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return null;
                  } else {
                    return ' Mobile Number';
                  }
                },
                decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    label: const Text('Mobile Number',
                        style: TextStyle(color: Color(0xffFF7373))),
                    focusedBorder: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(15.0),
                      borderSide: BorderSide(color: Color(0xffFF7373)),
                    )),
                controller:
                    signInSignUpController.phoneSignUpTextEditingController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10)
                ], // for mobile
              ),
            ),
          ),
        ),
        signInSignUpController.isOTPPage.value == false
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: signInSignUpController.formKeyEmail,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        return null;
                      } else {
                        return 'Email ID';
                      }
                    },
                    decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        label: const Text('Email ID',
                            style: TextStyle(color: Color(0xffFF7373))),
                        focusedBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          borderSide: BorderSide(color: Color(0xffFF7373)),
                        )),
                    controller:
                        signInSignUpController.emailTextEditingController,
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: signInSignUpController.formKeyEmail,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        return null;
                      } else {
                        return 'OTP';
                      }
                    },
                    decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xffFF7373), width: 0.0),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        label: const Text('OTP'),
                        focusedBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          borderSide: BorderSide(color: Color(0xffFF7373)),
                        )),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10)
                    ],
                    controller: signInSignUpController.otpTextEditingController,
                  ),
                ),
              ),
        Visibility(
          visible: signInSignUpController.isOTPPage.value ? false : true,
          child: Row(
            children: [
              Checkbox(
                  value: signInSignUpController.checkBoxValue.value,
                  activeColor: Color(0xffFF7373),
                  onChanged: (newValue) {
                    // setState(() {
                    signInSignUpController.checkBoxValue.value = newValue!;
                    // });
                  }),
              const Text('I agree all statements in'),
              const SizedBox(
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
                    "terms of service",
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: Colors.black,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ),
            ],
          ),
        ),
        signInSignUpController.isOTPPage.value
            ? Container(
                margin: EdgeInsets.only(top: 15),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 45.0,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    side: const BorderSide(
                                        color: Color(0xffFF7373)))),
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xffFF7373)),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                          ),
                          child: const Text(
                            'VERIFY OTP',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                letterSpacing: 0.6),
                          ),
                          onPressed: () {
                            if (!signInSignUpController
                                .formKeyOtp.currentState!
                                .validate()) {
                              return;
                            } else {
                              signInSignUpController.isLoading.value = true;
                              signInSignUpController.veryfyOTP(context);
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    signInSignUpController.start.value > 0
                        ? Container(
                            margin: EdgeInsets.only(top: 20),
                            child: InkWell(
                              onTap: () {},
                              child: Text(
                                "You can resend otp in ${signInSignUpController.start.value}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(
                                      color: Colors.black,
                                      decoration: TextDecoration.underline,
                                    ),
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: double.infinity,
                              height: 45.0,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          side: const BorderSide(
                                              color: Color(0xffFF7373)))),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                ),
                                child: const Text(
                                  'RESEND OTP',
                                  style: TextStyle(
                                      color: Color(0xffFF7373),
                                      fontSize: 18,
                                      letterSpacing: 0.6),
                                ),
                                onPressed: () {
                                  signInSignUpController.signUpClick();
                                },
                              ),
                            ),
                          ),
                    SizedBox(
                      height: Get.height * 0.15,
                    ),
                    InkWell(
                      onTap: () {
                        signInSignUpController.isOTPPage.value = false;
                      },
                      child: Text(
                        "Change your mobile number",
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                            ),
                      ),
                    ),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side:
                                  const BorderSide(color: Color(0xffFF7373)))),
                      elevation: MaterialStateProperty.all(3.0),
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xffFF7373)),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    child: signInSignUpController.isLoading.value
                        ? Container(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            'SIGN UP',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                letterSpacing: 0.6),
                          ),
                    onPressed: () {
                      if (!signInSignUpController.formKeyUserName.currentState!
                              .validate() ||
                          !signInSignUpController
                              .formKeySingUpMobileNumber.currentState!
                              .validate() ||
                          !signInSignUpController.formKeyEmail.currentState!
                              .validate()) {
                        return;
                      } else {
                        if (signInSignUpController.checkBoxValue.value) {
                          if (!EmailValidator.validate(
                              signInSignUpController
                                  .emailTextEditingController.text,
                              true)) {
                            Fluttertoast.showToast(
                                msg: "Please Enter Valid Email");
                          } else {
                            signInSignUpController.isLoading.value = true;
                            signInSignUpController.signInClick();
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: "Please accept Terms of service");
                        }
                      }
                    },
                  ),
                ),
              )
      ],
    ));
  }
}
