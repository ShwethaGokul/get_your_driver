import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class LoginController extends GetxController {
  var isSignIn = false.obs;
  var isSignUp = false.obs;

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  bool viewPassword = true;

  var client = http.Client();


  @override
  void onInit() async {

      isSignIn.value = true;


    super.onInit();

  }

  clearAllFilledDetails(){
    passwordTextEditingController.clear();
    emailTextEditingController.clear();
  }


}
