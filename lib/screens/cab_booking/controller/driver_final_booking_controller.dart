import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_your_driver/helper/constansts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helper/local/shared_preference_keys.dart';
import '../screens/driver_booked_comfirmed.dart';

class DriverFinalBookingController extends GetxController{
  var isRescheduleSelected = false.obs;
  var isCancelSelected = false.obs;
  var isLoading = false.obs;
  var isSearching = false.obs;
  var listSearchDriver = [].obs;

  @override
  void onInit() {
    isRescheduleSelected.value = true;
    // TODO: implement onInit
    super.onInit();
  }
  selectTab(bool isOneWay) {
    print('datat: $isOneWay');
    if (isOneWay) {
      isCancelSelected(true);
      isRescheduleSelected(false);
    } else {
      isCancelSelected(false);
      isRescheduleSelected(true);
    }
  }


  bookingDriver(BuildContext context,var bookingList)async {
    var prefs = await SharedPreferences.getInstance();
    print('bookingDriver');
    try {
      var headers = {
        'x-api-key': 'R9OH5BHSKP8XGYDQGMC6OBAZ',
        'Cookie': 'ci_session=73be70994220d94f4c643c64829cb585f31957bf'
      };
      var request = http.MultipartRequest('POST', Uri.parse(
          '${URLs.STATGING_BASE_URL}stagging/${URLs.book_driver}?token=bphl0a9iqruczaepnhbb0quxqpz1tiqbchi'));
      request.fields.addAll({
        'token': 'bphl0a9iqruczaepnhbb0quxqpz1tiqbchi',
        'booking_type': 'ONEWAY',
        'car_type': 'MANUAL-Hatchback',
        'trip_type': 'In City',
        'city': 'New Delhi',
        'pickup_address': bookingList[0]['PickupLocation'],
        // 'pickup_address': 'Kharghar',
        'pickup_lat': bookingList[0]['pickup_latitude'],
        'pickup_datetime': bookingList[0]['DateTime'],
        // 'pickup_datetime': '2023-02-27T16:15',
        'pickup_long': bookingList[0]['pickup_longitude'],
        'estimated_trip_hour': bookingList[0]['EstimatedTime'].toString(),
        'estimated_trip_mniutes': '0',
        'drop_add': 'Kharghar',
        'drop_lat': bookingList[0]['drop_latitude'],
        'drop_long': bookingList[0]['drop_longitude'],
        'initial_charges': bookingList[0]['initial_charges'],
        'overtime_charges': bookingList[0]['overtime_charges'],
        'driver_return_fare': bookingList[0]['driver_return_fare'],
        'night_charges': bookingList[0]['night_charges'],
        'estimated_fare': bookingList[0]['EstimatedFare'].toString(),
        'sallary': '',
        'note': ''
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var listData = await response.stream.bytesToString();
        var jsonCod = json.decode(listData);
        print('bookingDriver ${response.statusCode} ${jsonCod}');
        if (jsonCod['error'] == true) {
          Fluttertoast.showToast(msg: "${jsonCod['message']}");
          isLoading.value = false;
        } else {
          print("jsonCod");
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DriverBookedConfirmed(bookedData: jsonCod)),
          );
          Fluttertoast.showToast(msg: jsonCod['message']);
          isLoading.value = false;
        }
      }
      else {
        print(response.reasonPhrase);
      }
      // request.fields.addAll({
      //   'token': '${prefs.getString(SPKeys.USERTOKEN)}',
      //   'booking_type': 'ONEWAY',
      //   'car_type': 'MANUAL-Hatchback',
      //   'trip_type': 'In City',
      //   'city': 'New Delhi',
      //   // 'pickup_address': bookingList[0]['PickupLocation'],
      //   'pickup_address': 'Kharghar',
      //   'pickup_lat': bookingList[0]['pickup_latitude'],
      //   // 'pickup_datetime': bookingList[0]['DateTime'],
      //   'pickup_datetime': '2023-02-27T16:15',
      //   'pickup_long': bookingList[0]['pickup_longitude'],
      //   'estimated_trip_hour': bookingList[0]['EstimatedTime'].toString(),
      //   'estimated_trip_mniutes': '0',
      //   'drop_add':'Kharghar',
      //   'drop_lat':bookingList[0]['drop_latitude'],
      //   'drop_long':bookingList[0]['drop_longitude'],
      //   'initial_charges': bookingList[0]['initial_charges'],
      //   'overtime_charges': bookingList[0]['overtime_charges'],
      //   'driver_return_fare':bookingList[0]['driver_return_fare'],
      //   'night_charges': bookingList[0]['night_charges'],
      //   'estimated_fare': bookingList[0]['EstimatedFare'].toString(),
      //   'sallary': '',
      //   'note': ''
      // });

    } catch (e) {
      print('isidid: $e');
      isLoading.value = false;
    }
  }
 Future searchDriver(var bookingId)async{
    isSearching.value = true;
    var headers = {
      'x-api-key': 'R9OH5BHSKP8XGYDQGMC6OBAZ',
      'Cookie': 'ci_session=768b89a65775b414c7c82d55c73d301a905dc6e5'
    };
    var request = http.Request('GET', Uri.parse('${URLs.STATGING_BASE_URL}stagging/${URLs.GetCurrentBookingStatus}?token=v3spiwllinxu0rsv0rfbzxbhydscx4rckfc&booking_id=${bookingId}'));

    request.headers.addAll(headers);
    print('datf: $request');

    http.StreamedResponse response = await request.send();
    print('resonse list data: ${response.statusCode}');

    if (response.statusCode == 200) {
      // var listData = await response.stream.bytesToString();
      // var jsonCod = json.decode(listData);
      // print('resonse list data: ${jsonCod['message']}');

      // if (jsonCod['error'] == true) {
      //   Fluttertoast.showToast(msg: "${jsonCod['message']}");
      //   isSearching.value = false;
      // } else {
      //   Fluttertoast.showToast(msg: jsonCod['message']);
      //   isSearching.value = false;
      // }
    }
    else {
      print(response.reasonPhrase);
    }
return await response.stream.bytesToString();
  }

}