import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;

class ForgetController extends GetxController {
  var isLoading = false.obs;

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController otpTextEditingController = TextEditingController();
  bool viewPassword = true;

  var client = http.Client();


  @override
  void onInit() async {

    super.onInit();

  }

  bool checkOTPValidation() {
    if (otpTextEditingController.text == "") {
      Fluttertoast.showToast(msg: "Please Enter OTP");
      return false;
    }
    return true;
  }

  clearAllFilledDetails(){
    otpTextEditingController.clear();
  }


  // Future<dynamic> otpClick() async {
  //   var url = Uri.parse(baseUrl + "${Apis.forget_password}?email=${emailTextEditingController.text}");
  //   print('loginClick: $url');
  //   var response = await client.post(url);
  //   print('response: ${response.body}');
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     var encoded = jsonDecode(response.body);
  //     clearAllFilledDetails();
  //     return encoded;
  //   } else {
  //     // Fluttertoast.showToast(
  //     //   msg: "Server Error ...",
  //     //   toastLength: Toast.LENGTH_SHORT,
  //     //   gravity: ToastGravity.BOTTOM,
  //     //   fontSize: 16.0,
  //     // );
  //   }
  // }

  // Future<dynamic> verifyOTP(var emailAddress,var optData) async {
  //   var url = Uri.parse(baseUrl + "${Apis.verifyOTP}?email=${emailAddress}&otp=$optData");
  //   print('verifyOTP: $url');
  //   var response = await client.post(url);
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     isLoading(false);
  //     var decoded = jsonDecode(response.body);
  //     clearAllFilledDetails();
  //     return decoded;
  //   } else {
  //     // Fluttertoast.showToast(
  //     //   msg: "Server Error ...",
  //     //   toastLength: Toast.LENGTH_SHORT,
  //     //   gravity: ToastGravity.BOTTOM,
  //     //   fontSize: 16.0,
  //     // );
  //   }
  // }


}
