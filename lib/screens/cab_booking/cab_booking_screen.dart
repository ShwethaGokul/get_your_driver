import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../theme_manager.dart';
import 'cab_booking_controller.dart';

class CabBookingScreen extends StatefulWidget {
  const CabBookingScreen({Key? key}) : super(key: key);

  @override
  _CabBookingScreenState createState() => _CabBookingScreenState();
}

class _CabBookingScreenState extends State<CabBookingScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  CabBookingController cabBookingController = Get.put(CabBookingController());

  @override
  void initState() {
    cabBookingController.dateInput.text =
        ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 160.0,
              child: Stack(
                children: <Widget>[
                  Container(
                    color: Colors.red,
                    width: MediaQuery.of(context).size.width,
                    height: Get.height * 0.16,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Book your Driver",
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                      ]),
                    ),
                  ),
                  Positioned(
                    top: 100.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: Colors.black, width: 0.2),
                            color: Colors.white),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(
                                Icons.location_on,
                                color: Colors.black,
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                    hintText: "Vijay Nagar, Indore",
                                    border: InputBorder.none),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20,bottom: 20),
                child: Column(
                  children: [
                    Container(
                        height: 120,
                        child: ListView.builder(
                            itemCount: cabBookingController.sellEarnList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: EdgeInsets.all(5),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap:(){
                                        for(var i=0;i<cabBookingController.sellEarnList.length;i++){
                                          if(cabBookingController.sellEarnList[i]['value']==true) {
                                            setState(() {
                                              cabBookingController
                                                  .sellEarnList[i]['value'] =
                                              false;
                                            });
                                          }else{
                                            setState(() {
                                              cabBookingController.sellEarnList[index]['value'] = true;
                                            });
                                          }
                                        }
                                      },
                                      child: Container(
                                        color: cabBookingController.sellEarnList[index]['value'] == true ? Colors.redAccent : Colors.transparent,
                                        child: Card(
                                          child: Stack(
                                            children: [
                                              Image.asset(
                                                "assets/images/car.jpg",
                                                height: 80,
                                                width: 80,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5,),
                                    Text("${cabBookingController.sellEarnList[index]['key']}")
                                  ],
                                ),
                              );
                            })),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Container(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            // border: Border.all(color: Colors.black, width: 0.2),
                            color: Color.fromRGBO(219, 220, 219, 120)),
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Enter your pickup location",
                              // fillColor: Color.fromRGBO(219, 220, 219, 120),
                              border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                        isDense: true,
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 24,
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Container(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            // border: Border.all(color: Colors.black, width: 0.2),
                            color: Color.fromRGBO(219, 220, 219, 130)),
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Enter destination location",
                              // fillColor: Color.fromRGBO(219, 220, 219, 120),
                              border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                          filled: true,
                          isDense: true,
                          prefixIcon: Icon(
                                Icons.search,
                                color: Colors.black,
                            size: 24,
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Container(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Color.fromRGBO(219, 220, 219, 120)),
                        child: TextField(
                          controller: cabBookingController.dateInput,
                          decoration: InputDecoration(
                              hintText: "Select Date",
                              fillColor: Color.fromRGBO(219, 220, 219, 120),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              isDense: true,
                              suffixIcon: Icon(
                                Icons.date_range_outlined,
                                color: Colors.black,
                                size: 24,
                              )),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime(2100));
                            if (pickedDate != null) {
                              print(
                                  pickedDate);
                              String formattedDate =
                                  DateFormat('dd/MM/yyyy').format(pickedDate);
                              print(
                                  formattedDate);
                              setState(() {
                                cabBookingController.dateInput.text =
                                    formattedDate;
                              });
                            } else {}
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              'Select Time',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 3),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: Container(
                                    child: Text('From: '),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async{
                                    TimeOfDay? pickedTime =  await showTimePicker(
                                      initialTime: TimeOfDay?.now(),
                                      context: context,
                                    );
                                    if(pickedTime != null ){
                                      setState(() {
                                        cabBookingController.fromTimeEditingTextController.text = pickedTime.format(context); //set the value of text field.
                                      });
                                    }else{
                                      print("Time is not selected");
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                      border: Border.all(
                                        color: Color.fromRGBO(219, 220, 219, 1),
                                      ),
                                      color: Color.fromRGBO(219, 220, 219, 1),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0,
                                          right: 8.0,
                                          top: 8,
                                          bottom: 8),
                                      child: Text(
                                        "${cabBookingController.fromTimeEditingTextController.text == "" ? "00:00" : cabBookingController.fromTimeEditingTextController.text}",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    child: Text('   To: '),
                                  ),
                                ),
                                InkWell(
                                  onTap: ()async{
                                    TimeOfDay? pickedTime =  await showTimePicker(
                                      initialTime: TimeOfDay?.now(),
                                      context: context,
                                    );
                                    if(pickedTime != null ){
                                      setState(() {
                                        cabBookingController.toTimeEditingTextController.text = pickedTime.format(context); //set the value of text field.
                                      });
                                    }else{
                                      print("Time is not selected");
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                      border: Border.all(
                                        color: Color.fromRGBO(219, 220, 219, 1),
                                      ),
                                      color: Color.fromRGBO(219, 220, 219, 1),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0,
                                          right: 8.0,
                                          top: 8,
                                          bottom: 8),
                                      child: Text(
                                        "${cabBookingController.toTimeEditingTextController.text == '' ? "00:00" : cabBookingController.toTimeEditingTextController.text}",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          Container(
                            child: Text(
                              'Estimated Ride Time: 02.30hr',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ]),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Radio(
                                value: 1,
                                groupValue:
                                    cabBookingController.radioSelected.value,
                                activeColor: AppColors.redColor,
                                onChanged: (value) {
                                  setState(() {
                                    cabBookingController.radioSelected.value =
                                        value!;
                                  });
                                },
                              ),
                              const Text("MANUAL",
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 15)),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 2,
                                groupValue:
                                    cabBookingController.radioSelected.value,
                                activeColor: AppColors.redColor,
                                onChanged: (value) {
                                  setState(() {
                                    cabBookingController.radioSelected.value =
                                        value!;
                                    // _radioVal = 'male';
                                    // _site = value;
                                  });
                                },
                              ),
                              Text("AUTOMATIC",
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 15)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Container(
                      width: Get.width,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            // border: Border.all(color: Colors.black, width: 0.2),
                            color: Color.fromRGBO(219, 220, 219, 130)),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                                isDense: true,
                                value: cabBookingController.selectedMonthlyPackage,
                                onChanged: (newValue) {
                                  setState(() {
                                    cabBookingController.selectedMonthlyPackage =
                                    newValue!;
                                    print(
                                        "selectedValue ${cabBookingController.selectedValue}");
                                  });
                                },
                                items: cabBookingController.dropdownItemsMonthlyPackage),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Container(
                      width: Get.width,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            // border: Border.all(color: Colors.black, width: 0.2),
                            color: Color.fromRGBO(219, 220, 219, 130)),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                                isDense: true,
                                value: cabBookingController.selectedValue,
                                onChanged: (newValue) {
                                  setState(() {
                                    cabBookingController.selectedValue =
                                    newValue!;
                                    print(
                                        "selectedValue ${cabBookingController.selectedValue}");
                                  });
                                },
                                items: cabBookingController.dropdownItems),
                          ),
                        ),
                      ),
                    ),

                    // Container(
                    //   height: 53,
                    //   child: InputDecorator(
                    //     decoration: const InputDecoration(
                    //         border: OutlineInputBorder(
                    //             borderSide: BorderSide(width: 0.1),
                    //             gapPadding: 2)),
                    //     child: DropdownButtonHideUnderline(
                    //       child: DropdownButton(
                    //           style: TextStyle(
                    //               fontSize: 12, color: Colors.black),
                    //           isDense: true,
                    //           value: cabBookingController.selectedValue,
                    //           onChanged: (newValue) {
                    //             setState(() {
                    //               cabBookingController.selectedValue =
                    //                   newValue!;
                    //               print(
                    //                   "selectedValue ${cabBookingController.selectedValue}");
                    //             });
                    //           },
                    //           items: cabBookingController.dropdownItems),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Row(
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
                                        side: BorderSide(color: Colors.red))),
                                // elevation: MaterialStateProperty.all(3.0),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.red),
                              ),
                              child: Text(
                                'ONE WAY',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    ),
                              ),
                              onPressed: () {
                                // _buildPopupDialog();
                              },
                            ),
                          ),
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
                                        side: BorderSide(color: Colors.red))),
                                // elevation: MaterialStateProperty.all(3.0),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.red),
                              ),
                              child: Text(
                                'ROUND TRIP',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15),
                              ),
                              onPressed: () {
                                // _buildPopupDialog();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    SchedulerBinding.instance.addPostFrameCallback((duration) {
      setState(() {
        cabBookingController.date =
            DateFormat('dd, MMMM yyyy').format(args.value).toString();
      });
    });
  }
}
