import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_your_driver/helper/constansts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/local/shared_preference_keys.dart';

class SignInSignUpController extends GetxController {
  var isSignInTab = false.obs;
  var isSignUpTab = false.obs;
  var isOTPPage = false.obs;
  var isLoading = false.obs;

  /// sign variable
  final formKeyMobileNumber = GlobalKey<FormState>();
  final formKeySingUpMobileNumber = GlobalKey<FormState>();
  final formKeyUserName = GlobalKey<FormState>();
  final formKeyEmail = GlobalKey<FormState>();
  final formKeyOtp = GlobalKey<FormState>();

  // var phoneTextEditingController =  TextEditingController();
  var phoneSignUpTextEditingController = TextEditingController();
  var usernameTextEditingController = TextEditingController();
  var emailTextEditingController = TextEditingController();
  var checkBoxValue = false.obs;

  TextEditingController otpTextEditingController = new TextEditingController();
  Duration duration = Duration();

  late Timer _timer;
  var start = 10.obs;

  selectTab(bool isSignIn) {
    if (isSignIn) {
      isSignInTab(true);
      isSignUpTab(false);
    } else {
      isSignInTab(false);
      isSignUpTab(true);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  clearAllField() {
    // phoneSignUpTextEditingController.clear();
    emailTextEditingController.clear();
    usernameTextEditingController.clear();
    checkBoxValue.value = false;
  }

  signUpClick() async {
    var headers = {
      'Cookie': 'ci_session=5ac53b9fb5f52fecf4fa02849e196d74d3854cac'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${URLs.STATGING_BASE_URL}${URLs.signup}'));
    request.fields.addAll({
      "name": usernameTextEditingController.text,
      "mobile": phoneSignUpTextEditingController.text,
      "email": emailTextEditingController.text,
      "src": "Mobile"
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var dd = json.decode(await response.stream.bytesToString());
      print('dd $dd');
      if (dd['status'].toString() == 'false') {
        start.value = 10;
        isOTPPage.value = true;
        isLoading.value = false;
        // startTimer();
        Fluttertoast.showToast(msg: dd['message']);
        print('isOTPPage.value: ${isOTPPage.value}');
      } else {
        isLoading.value = false;
        Fluttertoast.showToast(msg: dd['message']);
      }

      print('response: ${dd['message']}');
    } else {
      isLoading.value = false;
      print(response.reasonPhrase);
    }
  }

  signInClick() async {
    var headers = {
      'x-api-key': 'R9OH5BHSKP8XGYDQGMC6OBAZ',
      'Cookie': 'ci_session=3ee28706a753bac191b4eba0b748098213b9d8d0'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${URLs.STATGING_BASE_URL}${URLs.signin}'));
    request.fields.addAll({'mobile': phoneSignUpTextEditingController.text});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var dd = json.decode(await response.stream.bytesToString());
      print('dd $dd');
      if (dd['error'].toString() == 'false') {
        start.value = 10;
        isOTPPage.value = true;
        isLoading.value = false;
        startTimer();
        Fluttertoast.showToast(msg: "${dd['message']}");
        print('isOTPPage.value: ${isOTPPage.value}');
      } else {
        isLoading.value = false;
        Fluttertoast.showToast(msg: dd['message']);
      }


      print('response: ${dd['message']}');
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    print('onesec $oneSec');
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start.value == 0) {
          timer.cancel();
        } else {
          start.value--;
        }
      },
    );
  }

  signUpVerify() async {
    var headers = {
      'Cookie': 'ci_session=591a6942ff3ecb8a6675384b8360cb5d67b42c80'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${URLs.STATGING_BASE_URL}${URLs.VerifySignUpOTP}'));
    request.fields.addAll({'otp': '5366', 'mobile_number': '9082948703'});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
  // var dd = '{ "status": 200,"error": false,"message": "Registered successfully", "data": {"userid": "14263","username": "Shubham jain","emailId": "sjainipc@gmail.com","password": null,"token": "q5tldbx46vwlm0big4i13hdab3pxfso2nyb","mobile": "8130573517","profile_image": null,"userInfo": null,"address": null,"web_user_status": "ACTIVE","web_token": "Null","deviceId": "2147483647","dob": null,"deviceType": "1","fcm_id": null,"userCreationDate": "2023-04-07 20:31:17","pastModifiedDate": "2023-04-07 20:31:17","gender": null,"status": "ACTIVE","city": null,"admin_email_shoot": "INACTIVE"}}';
  veryfyOTP(BuildContext context)async{
    // var dat = json.decode(dd);
    // var details=json.decode(dat['data']['emailId']);

    var headers = {
      'x-api-key': 'R9OH5BHSKP8XGYDQGMC6OBAZ',
      'Cookie': 'ci_session=3ee28706a753bac191b4eba0b748098213b9d8d0'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${URLs.STATGING_BASE_URL}${URLs.VerifySignUpOTP}'));
    request.fields.addAll({
      'mobile': phoneSignUpTextEditingController.text,
      'otp': otpTextEditingController.text,
      'deviceId': '3423451231423423',
      'deviceType': '1',
      'name': usernameTextEditingController.text,
      'email': emailTextEditingController.text
    });

    request.headers.addAll(headers);
    print('request.fields: ${request.fields}');

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var dd = json.decode(await response.stream.bytesToString());
      print('dd $dd');
      if (dd['error'].toString() == 'false') {
        Fluttertoast.showToast(msg: "${dd['message']}");
        var prefs = await SharedPreferences.getInstance();
        prefs.setString(SPKeys.USERTOKEN, dd['data']['token']);
        print('datatddd: ${prefs.getString(SPKeys.USERTOKEN)}');
        clearAllField();
        isLoading.value = false;
        Navigator.of(context,rootNavigator: true).pop();
       otpTextEditingController.clear();
      } else {
        isLoading.value = false;
        Fluttertoast.showToast(msg: dd['message']);
        otpTextEditingController.clear();
      }
    }
    else {
    print(response.reasonPhrase);
    }

  }
}
