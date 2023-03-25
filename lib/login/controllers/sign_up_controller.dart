import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class SignUpController extends GetxController {
  var isLoading = false.obs;

  TextEditingController usernameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  bool viewPassword = true;

  var client = http.Client();


  @override
  void onInit() async {
    super.onInit();

  }
  bool validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);

  if(!regExp.hasMatch(value)) {
      return false;
    }

    return true;
  }


  clearAllFilledDetails(){
    passwordTextEditingController.clear();
    usernameTextEditingController.clear();
    phoneTextEditingController.clear();
    emailTextEditingController.clear();
  }

}
