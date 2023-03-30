import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CabBookingController extends GetxController {
  var isCourses = false.obs;
  var isTrainings = false.obs;
  var radioSelected = 1.obs;
  var cabSelected = 1.obs;
  final DateRangePickerController controller = DateRangePickerController();
  String date = DateFormat('dd, MMMM yyyy').format(DateTime.now()).toString();
  TextEditingController dateInput = TextEditingController();
  String selectedValue = "0";
  String selectedMonthlyPackage = "0";
  TextEditingController fromTimeEditingTextController = TextEditingController();
  TextEditingController toTimeEditingTextController = TextEditingController();



  var sellEarnList = [
    {"key": "In City", "value" : false},
    {"key": "Monthly Package", "value" : false},
    {"key": "Out Station", "value" : false},
  ];
  List<DropdownMenuItem<String>> get dropdownItemsMonthlyPackage {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "0", child: Text("1 Month (for RS 1,500)")),
      const DropdownMenuItem(value: "Hatchback", child: Text("3 Month (for RS 2,500)")),
      const DropdownMenuItem(value: "Sedan", child: Text("2 Month (for RS 2,800)")),
      const DropdownMenuItem(value: "SUV/MUV", child: Text("6 Month (for RS 7,000)")),
    ];
    return menuItems;
  }
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "0", child: Text("Select Your Car Type")),
      const DropdownMenuItem(value: "Hatchback", child: Text("Hatchback")),
      const DropdownMenuItem(value: "Sedan", child: Text("Sedan")),
      const DropdownMenuItem(value: "SUV/MUV", child: Text("SUV/MUV")),
      const DropdownMenuItem(value: "Luxury/Premium", child: Text("Luxury/Premium")),
    ];
    return menuItems;
  }


}
