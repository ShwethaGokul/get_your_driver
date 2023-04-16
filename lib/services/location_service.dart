import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../screens/cab_booking/controller/cab_booking_controller.dart';

class LocationServices extends GetxController with WidgetsBindingObserver{

  late AppLifecycleState _notification;

  @override
  void initState() {
    // super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
      _notification = state;

    print("_notification ${_notification}");
    if (_notification == AppLifecycleState.resumed){

      determinePosition();
    }
  }
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        Fluttertoast.showToast(msg: "Location permissions are denied");
        // exit(0);
        // return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {

      print('indindnd: ${permission}');

      openAppSettings().then((value) => {
        print('openAppSettings: ${value}')
      });
      Fluttertoast.showToast(msg: "Location permissions are permanently denied, we cannot request permissions.");
      // exit(0);
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissionsQ.');

    }
    var latLong = await Geolocator.getCurrentPosition();
    List<Placemark> placemarks = await placemarkFromCoordinates(latLong.latitude, latLong.longitude);
    CabBookingController().getCurrentAddress.value = "${placemarks.first.subLocality}, ${placemarks.first.locality}";
    return await Geolocator.getCurrentPosition();
  }

}