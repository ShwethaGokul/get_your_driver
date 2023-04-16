// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_your_driver/helper/constansts.dart';
import 'package:get_your_driver/services/location_service.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../../../helper/local/shared_preference_keys.dart';
import '../../login/sign_in_screen.dart';
import '../screens/driver_final_booking_view.dart';

class CabBookingController extends GetxController {
  var isCourses = false.obs;
  var isTrainings = false.obs;
  var radioSelected = 1.obs;
  var cabSelected = 1.obs;
  String date = DateFormat('dd, MMMM yyyy').format(DateTime.now()).toString();
  TextEditingController dateInput = TextEditingController();
  String selectedValue = "0";
  String selectedMonthlyPackage = "0";
  TextEditingController pickupEditingTextController = TextEditingController();
  TextEditingController dropEditingTextController = TextEditingController();
  TextEditingController searchAddressController = TextEditingController();
  var getCurrentAddress = "".obs;
  // String? dropDownValue;
  String? dropDownValue;
  String? dropDownValue1;

  /// Monthly package variables
  TextEditingController monthlyPackagePickupLocationController =
      TextEditingController();
  TextEditingController monthlyPackageSelectDateController =
      TextEditingController();
  TextEditingController monthlyPackageHourController = TextEditingController();
  TextEditingController monthlyPackageMinuteController =
      TextEditingController();
  TextEditingController monthlyPackageNoteController = TextEditingController();
  TextEditingController enterEstimatedHoursController = TextEditingController();
  var isPrivateSelected = false.obs;
  var isCormmercialSelected = false.obs;
  var estimatedFareForMonthly = '0'.obs;
  var selectedLtlongMonthlyPickup = ''.obs;
  var selectHours = 0.0.obs;
  var selectDays = 0.0.obs;
  var viewBreakUpPriceInCity = [].obs;
  var viewBreakUpPriceMonthly = [].obs;

  /// Out Station
  var estimatedFareForOutStation = '0'.obs;

  var isOneWaySelected = false.obs;
  var isRoundedSelected = false.obs;
  var calculateEtimatedTime = "0".obs;
  var mapListDtt = {}.obs;
  var selectedLtlongPickup = ''.obs;
  var selectedLtlongDrop = ''.obs;

  var estimateHrsSlider = 0.0.obs;
  var estimateDaySlider = 0.0.obs;

  var estimatedFareForInCity = '0'.obs;
  var values = 1.obs;

  List<DropdownMenuItem<String>> get dropdownItemsMonthlyPackage {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "0", child: Text("1 Month (for RS 1,500)")),
      const DropdownMenuItem(
          value: "Hatchback", child: Text("3 Month (for RS 2,500)")),
      const DropdownMenuItem(
          value: "Sedan", child: Text("2 Month (for RS 2,800)")),
      const DropdownMenuItem(
          value: "SUV/MUV", child: Text("6 Month (for RS 7,000)")),
    ];
    return menuItems;
  }

  List<String> suggestons = [];

  @override
  void onInit() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    getCurrentPossition();
    isRoundedSelected.value = true;
    final androiiNfor = await DeviceInfoPlugin().androidInfo;
    final androiVersion = androiiNfor.androidId;
    dateInput.text = DateFormat('  dd/MM/yyyy').format(DateTime.now());
    isPrivateSelected.value = true;
    // enterEstimatedHoursController.text = '4';
    // print('FCM Token: ${androiVersion}');
    // getDeviceToken().then((value) {
    //   print('valuedd122: $value');
    // });
    // TODO: implement onInit
    super.onInit();
  }

  selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2100));
    if (pickedDate != null) {
      String formattedDate = DateFormat('  dd/MM/yyyy').format(pickedDate);
      dateInput.text = formattedDate;
    } else {}
  }

  selectTab(bool isOneWay) {
    if (isOneWay) {
      isOneWaySelected(true);
      isRoundedSelected(false);
    } else {
      isOneWaySelected(false);
      isRoundedSelected(true);
    }
  }

  selectMonthlyPrivate(bool isPrivate) {
    if (isPrivate) {
      isPrivateSelected(true);
      isCormmercialSelected(false);
    } else {
      isPrivateSelected(false);
      isCormmercialSelected(true);
    }
  }

  // selectTime(bool isFromTime, BuildContext context) async {
  //   print("seleTime");
  //   TimeOfDay? pickedTime = await showTimePicker(
  //     initialTime: TimeOfDay?.now(),
  //     context: context,
  //   );
  //   if (pickedTime != null) {
  //     if (isFromTime) {
  //       fromTimeEditingTextController.text = pickedTime.format(context);
  //     } else {
  //       toTimeEditingTextController.text = pickedTime.format(context);
  //     }
  //   } else {
  //   }
  //   if (fromTimeEditingTextController.text.isNotEmpty &&
  //       toTimeEditingTextController.text.isNotEmpty) calculateEstimatedTime();
  // }

  // calculateEstimatedTime() {
  //   DateTime fromDate =
  //       DateFormat.jm().parse(fromTimeEditingTextController.text);
  //   DateTime toDatedate =
  //       DateFormat.jm().parse(toTimeEditingTextController.text);
  //   print("formated Date: ${fromDate} $toDatedate");
  //   print(DateFormat("HH").format(fromDate));
  //   print(DateFormat("HH:mm").format(fromDate));
  //   var splitFromHour = DateFormat("HH").format(fromDate);
  //   var splitFromMinute = DateFormat("mm").format(fromDate);
  //   var splitToHour = DateFormat("HH").format(toDatedate);
  //   var splitToMinute = DateFormat("mm").format(toDatedate);
  //   var fromTime = int.parse(splitFromHour) * 60 + int.parse(splitFromMinute);
  //   var toTime = int.parse(splitToHour) * 60 + int.parse(splitToMinute);
  //   var calculateTime = (toTime - fromTime) / 60;
  //   getTimeStringFromDouble(calculateTime);
  //   print('datat ${calculateTime / 60} $calculateTime');
  // }

  String getTimeStringFromDouble(double value) {
    if (value < 0) return 'Invalid Value';
    int flooredValue = value.floor();
    double decimalValue = value - flooredValue;
    RxString hourValue = getHourString(flooredValue);
    RxString minuteString = getMinuteString(decimalValue);
    calculateEtimatedTime.value = "${hourValue}:${minuteString}";
    return '$hourValue:$minuteString';
  }

  getMinuteString(double decimalValue) {
    return RxString('${(decimalValue * 60).toInt()}'.padLeft(2, '0'));
  }

  getHourString(int flooredValue) {
    return RxString('${flooredValue % 24}'.padLeft(2, '0'));
  }

  getCurrentPossition() {
    LocationServices().determinePosition().then((value) async {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(value.latitude, value.longitude);
      if(placemarks.first.subLocality.toString().isEmpty) {
        getCurrentAddress.value =
        "${placemarks.first.locality}";
      }else{
        getCurrentAddress.value =
        "${placemarks.first.subLocality}, ${placemarks.first.locality}";
      }
    });
  }

  Future<String> getDeviceToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    return token!;
  }

  getPlaces(var query) async {
    var headers = {'x-api-key': ''};
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://api.mapbox.com/geocoding/v5/mapbox.places/$query.json?country=In&autocomplete=true&limit=5&access_token=pk.eyJ1Ijoic2phaW5pcGMiLCJhIjoiY2tkZXV0d3B0MjY3MzJzazYwZ3N5aWFzdiJ9.n8_KmlL4cy-leNsLSXln1g'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    List<String> listDtt = [];
    if (response.statusCode == 200) {
      var listData = await response.stream.bytesToString();
      var jsonCod = json.decode(listData);
      for (var i = 0; i < jsonCod['features'].length; i++) {
        mapListDtt.value[jsonCod['features'][i]['place_name']] =
            jsonCod['features'][i]['center'];
        listDtt.add(jsonCod['features'][i]['place_name']);
        suggestons = listDtt;
      }
      print("listData: ${mapListDtt.value}");
    } else {
      print(response.reasonPhrase);
    }
  }

  getEstimatFare(BuildContext context) async {
    var headers = {
      'x-api-key': 'R9OH5BHSKP8XGYDQGMC6OBAZ',
      'Cookie': 'ci_session=843805842aed472bcddd36d4f25ba74dbcb06425'
    };
    var prefs = await SharedPreferences.getInstance();
    var request = http.MultipartRequest(
        'POST', Uri.parse('${URLs.STATGING_BASE_URL}${URLs.FareEstimation}'));
    var splitPickup = selectedLtlongPickup.value.split(',');
    var splitDrop = selectedLtlongDrop.value.split(',');
    request.fields.addAll({
      'token': "${prefs.getString(SPKeys.USERTOKEN)}",
      'city_name': 'New Delhi',
      'pickup_latitude': splitPickup[1].toString(),
      'pickup_longitude': splitPickup[0].toString(),
      'drop_latitude': splitDrop[1].toString(),
      'drop_longitude': splitDrop[0].toString(),
      'num_days': '2',
      'num_hours': estimateHrsSlider.value.toStringAsFixed(0),
      'num_minutes': '0',
      'pickup_datetime': dateInput.text,
      'trip_type': 'In City',
      'booking_type': isOneWaySelected.value == true ? "ONEWAY" : "Rounded"
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var listData = await response.stream.bytesToString();
      var jsonCod = json.decode(listData);
      if (jsonCod['error'] == false) {
        if (values.value == 1) {
          estimatedFareForInCity.value =
              jsonCod['data']['total_charges'].toString();
        } else if (values.value == 3) {
          estimatedFareForOutStation.value =
              jsonCod['data']['total_charges'].toString();
        }
        var mapData = {
          "initial_charge": jsonCod['data']['initial_charge'],
          "overtime_charges": jsonCod['data']['overtime_charges'],
          "driver_return_fare": jsonCod['data']['driver_return_fare'],
          "night_charges": jsonCod['data']['night_charges'],
        };
        viewBreakUpPriceInCity.value.add(mapData);
        print("dterg ${viewBreakUpPriceInCity.value}");
      } else if (jsonCod['message'] == "Invalid Token") {
        SignInPage().bottomSheet(context);
        Fluttertoast.showToast(msg: "Sorry you need to Login First");
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  showPriceBreakupInCity(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text(
        "Cancel",
        style: TextStyle(
            color: Get.theme.textTheme.headline4!.color,
            fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "OK",
        style: TextStyle(
            color: Get.theme.textTheme.headline4!.color,
            fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      content: SizedBox(
        height: 124,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Initial Charges/ 4 hr'),
                Text(viewBreakUpPriceInCity[0]['initial_charge'])
              ],
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Overtime Charges (84rs/hr)'),
                Text(viewBreakUpPriceInCity[0]['overtime_charges'].toString())
              ],
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Driver Return Charges'),
                Text(viewBreakUpPriceInCity[0]['driver_return_fare'].toString())
              ],
            ) ,
            SizedBox(
              height: Get.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Driver night Charges'),
                Text(viewBreakUpPriceInCity[0]['night_charges'].toString())
              ],
            )
          ],
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showPriceBreakupMonthly(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text(
        "Cancel",
        style: TextStyle(
            color: Get.theme.textTheme.headline4!.color,
            fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "OK",
        style: TextStyle(
            color: Get.theme.textTheme.headline4!.color,
            fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      content: SizedBox(
        height: 124,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Initial Charges/ 4 hr'),
                Text(viewBreakUpPriceMonthly[0]['initial_charge'])
              ],
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Overtime Charges (84rs/hr)'),
                Text(viewBreakUpPriceMonthly[0]['overtime_charges'].toString())
              ],
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Driver Return Charges'),
                Text(viewBreakUpPriceMonthly[0]['driver_return_fare'].toString())
              ],
            ) ,
            SizedBox(
              height: Get.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Driver Return Charges'),
                Text(viewBreakUpPriceMonthly[0]['driver_return_fare'].toString())
              ],
            )
          ],
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  getEstimatFareForMonthly(BuildContext context) async {
    print('inside: getEstimatFare');
    var headers = {
      'x-api-key': 'R9OH5BHSKP8XGYDQGMC6OBAZ',
      'Cookie': 'ci_session=843805842aed472bcddd36d4f25ba74dbcb06425'
    };
    var prefs = await SharedPreferences.getInstance();
    var request = http.MultipartRequest(
        'POST', Uri.parse('${URLs.STATGING_BASE_URL}${URLs.FareEstimation}'));
    var splitPickup = selectedLtlongMonthlyPickup.value.split(',');
    request.fields.addAll({
      'token': "${prefs.getString(SPKeys.USERTOKEN)}",
      // 'token': "p67xjdh4vnd0qafnoi4rj17ig68meldvs2u",
      // 'token': "h2dtgv7t71chmm33karzfye5orhdztj51k0",
      'city_name': 'New Delhi',
      'pickup_latitude': splitPickup[1].toString(),
      'pickup_longitude': splitPickup[0].toString(),
      'drop_latitude': splitPickup[1].toString(),
      'drop_longitude': splitPickup[0].toString(),
      'num_days': selectDays.value.toStringAsFixed(0),
      'num_hours': selectHours.value.toStringAsFixed(0),
      'num_minutes': '0',
      'pickup_datetime': dateInput.text,
      'trip_type': 'Monthly Package',
      'booking_type': isPrivateSelected.value ? 'Private' : 'Commercial'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print('datttt: ${request.fields}');
    if (response.statusCode == 200) {
      var listData = await response.stream.bytesToString();
      var jsonCod = json.decode(listData);
      if (jsonCod['error'] == false) {
        estimatedFareForMonthly.value =
            jsonCod['data']['total_charges'].toString();
        var mapData = {
          "initial_charge": jsonCod['data']['initial_charge'],
          "overtime_charges": jsonCod['data']['overtime_charges'],
          "driver_return_fare": jsonCod['data']['driver_return_fare'],
          "night_charges": jsonCod['data']['night_charges'],
        };
        viewBreakUpPriceMonthly.value.add(mapData);
        print("dterg ${jsonCod['data']['total_charges']}");
      } else if (jsonCod['message'] == "Invalid Token") {
        SignInPage().bottomSheet(context);
        Fluttertoast.showToast(msg: "Sorry you need to Login First");
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  getEstimatFareForOutstation(BuildContext context) async {
    var headers = {
      'x-api-key': 'R9OH5BHSKP8XGYDQGMC6OBAZ',
      'Cookie': 'ci_session=843805842aed472bcddd36d4f25ba74dbcb06425'
    };
    var prefs = await SharedPreferences.getInstance();
    var request = http.MultipartRequest(
        'POST', Uri.parse('${URLs.STATGING_BASE_URL}${URLs.FareEstimation}'));
    var splitPickup = selectedLtlongMonthlyPickup.value.split(',');
    request.fields.addAll({
      'token': "${prefs.getString(SPKeys.USERTOKEN)}",
      'city_name': 'New Delhi',
      'pickup_latitude': splitPickup[1].toString(),
      'pickup_longitude': splitPickup[0].toString(),
      'drop_latitude': splitPickup[1].toString(),
      'drop_longitude': splitPickup[0].toString(),
      'num_days': selectDays.value.toStringAsFixed(0),
      'num_hours': selectHours.value.toStringAsFixed(0),
      'num_minutes': '0',
      'pickup_datetime': dateInput.text,
      'trip_type': 'Monthly Package',
      'booking_type': isPrivateSelected.value ? 'Private' : 'Commercial'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var listData = await response.stream.bytesToString();
      var jsonCod = json.decode(listData);
      if (jsonCod['error'] == false) {
        estimatedFareForMonthly.value =
            jsonCod['data']['total_charges'].toString();
      } else if (jsonCod['message'] == "Invalid Token") {
        SignInPage().bottomSheet(context);
        Fluttertoast.showToast(msg: "Sorry you need to Login First");
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  validateMinuteSecondTextField(String value,
      TextEditingController textEditingController, bool isMinute) {
    if (!isNumeric(value)) {
      textEditingController.text = isMinute ? '59' : '24';
      textEditingController.selection = TextSelection.fromPosition(
          TextPosition(offset: textEditingController.text.length));
    } else if (int.parse(value) > 59 && isMinute) {
      textEditingController.text = '59';
      textEditingController.selection = TextSelection.fromPosition(
          TextPosition(offset: textEditingController.text.length));
    } else if (int.parse(value) > 24 && !isMinute) {
      textEditingController.text = '24';
      textEditingController.selection = TextSelection.fromPosition(
          TextPosition(offset: textEditingController.text.length));
    }
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text(
        "Cancel",
        style: TextStyle(
            color: Get.theme.textTheme.headline4!.color,
            fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "OK",
        style: TextStyle(
            color: Get.theme.textTheme.headline4!.color,
            fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        if (selectedLtlongPickup.isNotEmpty && selectedLtlongDrop.isNotEmpty) {
          getEstimatFare(context);
        }
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      content: Container(
        height: 124,
        child: Column(
          children: [
            Text(
              "How long will you use?",
              style: TextStyle(color: context.theme.textTheme.headline4!.color),
            ),
            SizedBox(
              height: 8,
            ),
            Obx(() => Container(
                width: MediaQuery.of(context).size.width / 4,
                height: 40,
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                          "${estimateHrsSlider.value.toStringAsFixed(0)} hrs"),
                    )))),
            Obx(() => SfSlider(
                  min: 0.0,
                  max: 24.0,
                  value: estimateHrsSlider.value,
                  showLabels: true,
                  enableTooltip: true,
                  onChanged: (dynamic value) {
                    estimateHrsSlider.value = value;
                  },
                ))
          ],
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showHoursDialogForMonthly(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text(
        "Cancel",
        style: TextStyle(
            color: Get.theme.textTheme.headline4!.color,
            fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "OK",
        style: TextStyle(
            color: Get.theme.textTheme.headline4!.color,
            fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        if (selectedLtlongMonthlyPickup.isNotEmpty) {
          getEstimatFareForMonthly(context);
        }
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      content: Container(
        height: 124,
        child: Column(
          children: [
            Text(
              "How long will you use?",
              style: TextStyle(color: context.theme.textTheme.headline4!.color),
            ),
            SizedBox(
              height: 8,
            ),
            Obx(() => Container(
                width: MediaQuery.of(context).size.width / 4,
                height: 40,
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child:
                          Text("${selectHours.value.toStringAsFixed(0)} hrs"),
                    )))),
            Obx(() => SfSlider(
                  min: 0.0,
                  max: 24.0,
                  value: selectHours.value,
                  showLabels: true,
                  enableTooltip: true,
                  onChanged: (dynamic value) {
                    selectHours.value = value;
                  },
                ))
          ],
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showDayDialogForMonthly(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text(
        "Cancel",
        style: TextStyle(
            color: Get.theme.textTheme.headline4!.color,
            fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "OK",
        style: TextStyle(
            color: Get.theme.textTheme.headline4!.color,
            fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        if (selectedLtlongMonthlyPickup.isNotEmpty) {
          getEstimatFareForMonthly(context);
        }
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      content: SizedBox(
        height: 124,
        child: Column(
          children: [
            Text(
              "How long will you use?",
              style: TextStyle(color: context.theme.textTheme.headline4!.color),
            ),
            const SizedBox(
              height: 8,
            ),
            Obx(() => SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                height: 40,
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child:
                          Text("${selectDays.value.toStringAsFixed(0)} days"),
                    )))),
            Obx(() => SfSlider(
                  min: 0.0,
                  max: 30.0,
                  value: selectDays.value,
                  showLabels: true,
                  enableTooltip: true,
                  onChanged: (dynamic value) {
                    selectDays.value = value;
                  },
                ))
          ],
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showDayAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text(
        "Cancel",
        style: TextStyle(
            color: Get.theme.textTheme.headline4!.color,
            fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "OK",
        style: TextStyle(
            color: Get.theme.textTheme.headline4!.color,
            fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        if (selectedLtlongPickup.isNotEmpty && selectedLtlongDrop.isNotEmpty) {
          getEstimatFare(context);
        }
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      content: Container(
        height: 124,
        child: Column(
          children: [
            Text(
              "How long will you use?",
              style: TextStyle(color: context.theme.textTheme.headline4!.color),
            ),
            SizedBox(
              height: 8,
            ),
            Obx(() => Container(
                width: MediaQuery.of(context).size.width / 4,
                height: 40,
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                          "${estimateHrsSlider.value.toStringAsFixed(0)} day"),
                    )))),
            Obx(() => SfSlider(
                  min: 0.0,
                  max: 12.0,
                  value: estimateHrsSlider.value,
                  showLabels: true,
                  enableTooltip: true,
                  onChanged: (dynamic value) {
                    estimateHrsSlider.value = value;
                  },
                ))
          ],
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

showDayOutStationAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text(
        "Cancel",
        style: TextStyle(
            color: Get.theme.textTheme.headline4!.color,
            fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "OK",
        style: TextStyle(
            color: Get.theme.textTheme.headline4!.color,
            fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        if (selectedLtlongPickup.isNotEmpty && selectedLtlongDrop.isNotEmpty) {
          getEstimatFare(context);
        }
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      content: Container(
        height: 124,
        child: Column(
          children: [
            Text(
              "How long will you use?",
              style: TextStyle(color: context.theme.textTheme.headline4!.color),
            ),
            SizedBox(
              height: 8,
            ),
            Obx(() => Container(
                width: MediaQuery.of(context).size.width / 4,
                height: 40,
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                          "${estimateDaySlider.value.toStringAsFixed(0)} day"),
                    )))),
            Obx(() => SfSlider(
                  min: 0.0,
                  max: 12.0,
                  value: estimateDaySlider.value,
                  showLabels: true,
                  enableTooltip: true,
                  onChanged: (dynamic value) {
                    estimateDaySlider.value = value;
                  },
                ))
          ],
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

addListForBookDriver(BuildContext context){
  var listData1 = [];
  var splitPickup = selectedLtlongPickup.value.split(',');
  var splitDrop = selectedLtlongDrop.value.split(',');
  var mapData = {
    "PickupLocation": pickupEditingTextController.text,
    "DropLocation": dropEditingTextController.text,
    "DateTime": dateInput.text,
    "EstimatedTime": estimateHrsSlider.toStringAsFixed(0),
    "EstimatedFare":estimatedFareForInCity,
    'pickup_latitude': splitPickup[1].toString(),
    'pickup_longitude': splitPickup[0].toString(),
    'drop_latitude': splitDrop[1].toString(),
    'drop_longitude': splitDrop[0].toString(),
    "car_type":dropDownValue1.toString().replaceAll('name:','').replaceAll('}',''),
    "initial_charges": viewBreakUpPriceInCity.isNotEmpty ? viewBreakUpPriceInCity[0]['initial_charge'] : '0',
    "overtime_charges": viewBreakUpPriceInCity.isNotEmpty ? viewBreakUpPriceInCity[0]['overtime_charges'].toString() : '0',
    "driver_return_fare": viewBreakUpPriceInCity.isNotEmpty ? viewBreakUpPriceInCity[0]['driver_return_fare'].toString() : '0',
    "night_charges": viewBreakUpPriceInCity.isNotEmpty ? viewBreakUpPriceInCity[0]['night_charges'].toString() : '0',
  };
  listData1.add(mapData);
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  DriverBookingFinalPage(listData: listData1,)),
  );
  print('lisdd: ${listData1}');

}
}
