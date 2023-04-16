import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_your_driver/screens/cab_booking/screens/cab_booking_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../helper/route_helper.dart';
import '../../main.dart';
import '../../theme_manager.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    // requestCameraPermission();
    Timer(Duration(seconds: 3), () => launchLoginWidget());
  }

  // launch login screen
  Future<void> launchLoginWidget() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => CabBookingScreen()));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildSplashForMobile(),
    );
  }

  Widget buildSplashForMobile() {
    return Stack(
      children: [
        buildSplashBG(),
        buildSplashLogo(),
      ],
    );
  }

  Widget buildSplashLogo() {
    return Center(
      child: Container(
        child: Image.asset(
          "assets/logo/logo.png",
          width: MediaQuery.of(context).size.width/2,
          height: MediaQuery.of(context).size.height/4.5,
        ),
      ),
    );
  }

  Widget buildSplashBG() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: AppColors.white,
    );
  }


}
