import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_your_driver/main.dart';
import 'package:get_your_driver/screens/login/sign_in_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../helper/local/shared_preference_keys.dart';
import '../../../helper/size/size.dart';
import '../../../helper/textstyle.dart';
import '../../../helper/widgets/booking_option.dart';
import '../../../helper/widgets/drop_down.dart';
import '../../../helper/widgets/time_field.dart';
import '../../login/sign_in_screen.dart';
import '../controller/cab_booking_controller.dart';
import '../models/car_type_drop_down_model.dart';
import 'driver_final_booking_view.dart';

class CabBookingScreen extends StatefulWidget {
  const CabBookingScreen({Key? key}) : super(key: key);

  @override
  _CabBookingScreenState createState() => _CabBookingScreenState();
}

class _CabBookingScreenState extends State<CabBookingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  CabBookingController cabBookingController = Get.put(CabBookingController());
  DropDown dropDown = Get.put(DropDown());
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    print("initState");
    setState(() {
      MyHomePage().isSelected.value = false;
    });
    cabBookingController.dateInput.text = "";
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
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
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
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
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: Colors.black, width: 0.2),
                            color: Colors.white),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Icon(
                                Icons.location_on,
                                color: Colors.black,
                              ),
                            ),
                            Obx(() => Expanded(
                                  child: TextField(
                                    controller: cabBookingController
                                        .searchAddressController,
                                    decoration: InputDecoration(
                                        hintText: cabBookingController
                                            .getCurrentAddress.value,
                                        suffixIcon: cabBookingController
                                                    .getCurrentAddress.value ==
                                                ""
                                            ? Container(
                                                margin: EdgeInsets.all(10),
                                                width: 5,
                                                height: 5,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.redAccent,
                                                  strokeWidth: 2,
                                                ))
                                            : null,
                                        border: InputBorder.none),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyRadioButton(
                  gruopValue: cabBookingController.values.value,
                  value: 1,
                  onchanged: (value) {
                    setState(
                      () => cabBookingController.values.value = value!,
                    );
                  },
                  title: 'In City',
                ),
                MyRadioButton(
                  gruopValue: cabBookingController.values.value,
                  value: 2,
                  onchanged: (value) {
                    setState(
                      () => cabBookingController.values.value = value!,
                    );
                  },
                  title: 'Monthly Package',
                ),
                MyRadioButton(
                  gruopValue: cabBookingController.values.value,
                  value: 3,
                  onchanged: (value) {
                    setState(
                      () => cabBookingController.values.value = value!,
                    );
                  },
                  title: 'Out Station',
                )
              ],
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            cabBookingController.values.value == 1
                ? inCityView()
                : cabBookingController.values.value == 2
                    ? monthlyView()
                    : outstationView()
          ],
        ),
      ),
    );
  }

  Widget inCityView() {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(right: 10, left: 10, bottom: 15),
            height: 43,
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10)),
            child: RawAutocomplete(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  return const Iterable<String>.empty();
                } else {
                  cabBookingController.getPlaces(textEditingValue.text);
                  List<String> matches = <String>[];
                  matches.addAll(cabBookingController.suggestons);
                  matches.retainWhere((s) {
                    return s
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase());
                  });
                  return matches;
                }
              },
              onSelected: (String selection) {
                print('You just selected $selection');
              },
              fieldViewBuilder: (BuildContext context,
                  TextEditingController textEditingController,
                  FocusNode focusNode,
                  VoidCallback onFieldSubmitted) {
                return TextField(
                  decoration: const InputDecoration(
                      isDense: true,
                      hintText: 'Enter Your Pickup location',
                      border: InputBorder.none,
                      icon: Padding(
                        padding: EdgeInsets.only(left: 8.0, top: 10),
                        child: Icon(
                          Icons.search,
                          color: Color(0xffFF7373),
                          size: 25,
                        ),
                      )),
                  controller: textEditingController,
                  focusNode: focusNode,
                  onSubmitted: (String value) {},
                  onChanged: (vale) {
                    if (vale.isEmpty) {
                      cabBookingController.selectedLtlongPickup.value = '';
                    }
                  },
                );
              },
              optionsViewBuilder: (BuildContext context1,
                  void Function(String) onSelected, Iterable<String> options) {
                return Material(
                    child: SizedBox(
                        height: 100,
                        child: SingleChildScrollView(
                            child: Column(
                          children: options.map((opt) {
                            return InkWell(
                                onTap: () {
                                  var getLtlogn = (cabBookingController
                                      .mapListDtt.value[opt]);
                                  cabBookingController.selectedLtlongPickup.value =
                                      getLtlogn
                                          .toString()
                                          .replaceAll('[', '')
                                          .toString()
                                          .replaceAll(']', '');
                                  print(
                                      'opt: ${cabBookingController.selectedLtlongPickup.value}');
                                  if(cabBookingController.isRoundedSelected.value){
                                    cabBookingController.selectedLtlongDrop.value =getLtlogn
                                        .toString()
                                        .replaceAll('[', '')
                                        .toString()
                                        .replaceAll(']', '');
                                    cabBookingController.getEstimatFare(context);
                                    cabBookingController.pickupEditingTextController.text = opt;
                                    cabBookingController.dropEditingTextController.text = opt;
                                    print('cabBookingController: ${cabBookingController.pickupEditingTextController.text}');
                                  }else if (cabBookingController.selectedLtlongDrop.isNotEmpty) {
                                    cabBookingController.dropEditingTextController.text = opt;
                                    cabBookingController.getEstimatFare(context);
                                  }

                                  onSelected(opt);
                                },
                                child: Container(
                                    padding: EdgeInsets.only(right: 18),
                                    child: Card(
                                        child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(10),
                                      child: Text(opt),
                                    ))));
                          }).toList(),
                        ))));
              },
            )
        ),
        Obx(
          () => Visibility(
            visible: cabBookingController.isOneWaySelected.value,
            child: Container(
                margin: const EdgeInsets.only(right: 10, left: 10, bottom: 15),
                height: 43,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10)),
                child: RawAutocomplete(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text == '') {
                      return const Iterable<String>.empty();
                    } else {
                      cabBookingController.getPlaces(textEditingValue.text);
                      List<String> matches = <String>[];
                      matches.addAll(cabBookingController.suggestons);
                      matches.retainWhere((s) {
                        return s
                            .toLowerCase()
                            .contains(textEditingValue.text.toLowerCase());
                      });
                      return matches;
                    }
                  },
                  onSelected: (String selection) {
                    print('You just selected $selection');
                  },
                  fieldViewBuilder: (BuildContext context,
                      TextEditingController textEditingController,
                      FocusNode focusNode,
                      VoidCallback onFieldSubmitted) {
                    return TextField(
                      decoration: const InputDecoration(
                          isDense: true,
                          hintText: 'Enter Your Drop location',
                          border: InputBorder.none,
                          icon: Padding(
                            padding: EdgeInsets.only(left: 8.0, top: 10),
                            child: Icon(
                              Icons.search,
                             color: Color(0xffFF7373),
                              size: 25,
                            ),
                          )),
                      onChanged: (vale) {
                        if (vale.isEmpty) {
                          cabBookingController.selectedLtlongDrop.value = '';
                        }
                        print("valdld: $vale");
                      },
                      controller: textEditingController,
                      focusNode: focusNode,
                      onSubmitted: (String value) {},
                    );
                  },
                  optionsViewBuilder: (BuildContext context1,
                      void Function(String) onSelected,
                      Iterable<String> options) {
                    return Material(
                        child: SizedBox(
                            height: 100,
                            child: SingleChildScrollView(
                                child: Column(
                              children: options.map((opt) {
                                return InkWell(
                                    onTap: () {
                                      var getLtlogn = (cabBookingController
                                          .mapListDtt.value[opt]);
                                      cabBookingController
                                              .selectedLtlongDrop.value =
                                          getLtlogn
                                              .toString()
                                              .replaceAll('[', '')
                                              .toString()
                                              .replaceAll(']', '');
                                      if (cabBookingController
                                          .selectedLtlongPickup.isNotEmpty) {
                                        cabBookingController
                                            .getEstimatFare(context);
                                        cabBookingController.dropEditingTextController.text = opt;
                                      }

                                      // cabBookingController.getEstimatFare(context);
                                      onSelected(opt);
                                    },
                                    child: Container(
                                        padding: EdgeInsets.only(right: 18),
                                        child: Card(
                                            child: Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.all(10),
                                          child: Text(opt),
                                        ))));
                              }).toList(),
                            ))));
                  },
                )),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * .95,
          height: 45,
          child: DecoratedBox(
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10)),
            child: TextField(
              controller: cabBookingController.dateInput,
              decoration: InputDecoration(
                  hintText: '  Select Date',
                  hintStyle: Tstyles.greycolor16,
                  border: InputBorder.none,
                  suffixIcon: const Icon(Icons.calendar_month, color: Color(0xffFF7373),
                      )),
              readOnly: true,
              onTap: () {
                cabBookingController.selectDate(context);
              },
            ),
          ),
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        Container(
          margin: const EdgeInsets.only(left: 10,right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: const Text('Select Estimated usage ( in Hrs )'),
              ),
              InkWell(
                onTap: (){
                  cabBookingController.showAlertDialog(context);

                },
                child: Obx(() => Container(
                    width: MediaQuery.of(context).size.width /3,
                    height: 45,
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text("${cabBookingController.estimateHrsSlider.value.toStringAsFixed(0)} hrs"),
                        )))),
              ),
            ],
          ),
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Radio(
                  value: 1,
                  groupValue: cabBookingController.radioSelected.value,
                  activeColor: const Color(0xffFF7373),
                  onChanged: (value) {
                    setState(() {
                      cabBookingController.radioSelected.value = value!;
                    });
                  },
                ),
                const Text("MANUAL",
                    style: TextStyle(color: Colors.black, fontSize: 15)),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: 2,
                  groupValue: cabBookingController.radioSelected.value,
                  activeColor: const Color(0xffFF7373),
                  onChanged: (value) {
                    setState(() {
                      cabBookingController.radioSelected.value = value!;
                    });
                  },
                ),
                const Text("AUTOMATIC",
                    style: TextStyle(color: Colors.black, fontSize: 15)),
              ],
            ),
          ],
        ),
        SizedBox(
          height: Get.height * 0.01,
        ),
        Container(
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10)),
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton(
                  borderRadius: BorderRadius.circular(10),
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  dropdownColor: Colors.grey.shade300,
                  value: cabBookingController.dropDownValue,
                  hint: cabBookingController.dropDownValue == null
                      ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Select Your car'),
                  )
                      : Text(
                    cabBookingController.dropDownValue!,
                    style: Tstyles.greycolor16,
                  ),
                  iconSize: 30.0,
                  items: jsona.map(
                        (value) {
                      return DropdownMenuItem<String?>(
                        value: value.toString(),
                        child: Row(
                          children: [
                            Image(
                              image: AssetImage('${value['image']}'),
                              height: 50,
                              width: 50,
                              fit: BoxFit.contain,
                              color: Colors.red,
                            ),
                            Ksize.kWsize20,
                            Text(
                              '${value['name']}',
                            ),
                          ],
                        ),
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                    setState(
                          () {
                            var splitedData = val.toString().split(',');
                            cabBookingController.dropDownValue = val;
                            cabBookingController.dropDownValue1 = splitedData[2];
                      },
                    );
                    print('dropdonvalue: ${cabBookingController.dropDownValue1}');

                  }),
            ),
          ),
        ),
        Obx(() => Container(
          margin: EdgeInsets.only(left: 15,right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    "Show Price Breakup"
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: (){
                      if(cabBookingController.viewBreakUpPriceInCity.value.isNotEmpty)
                        cabBookingController.showPriceBreakupInCity(context);
                    },
                    child: const Icon(
                        Icons.remove_red_eye_outlined,
                        color: Color(0xffFF7373)
                    ),
                  )
                ],
              ),
              Text(
                "₹ ${cabBookingController.estimatedFareForInCity.value}",
                style:
                const TextStyle(fontSize: 20, color: Color(0xffFF7373),
                ),
              ),
            ],
          ),
        )),
        SizedBox(
          height: Get.height * 0.02,
        ),
        Obx(() => Container(
              margin: const EdgeInsets.only(left: 12, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 45,
                    width: Get.width / 2.40,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    side: const BorderSide(
                                        color: Color(0xffFF7373)))),
                        backgroundColor: cabBookingController
                                .isOneWaySelected.value
                            ? MaterialStateProperty.all(const Color(0xffFF7373))
                            : MaterialStateProperty.all(Colors.white),
                        foregroundColor:
                            MaterialStateProperty.all(const Color(0xffFF7373)),
                      ),
                      child: Text(
                        'ONE WAY',
                        style: TextStyle(
                          color: cabBookingController.isOneWaySelected.value
                              ? Colors.white
                              : const Color(0xffFF7373),
                          fontSize: 15,
                        ),
                      ),
                      onPressed: () {
                        cabBookingController.selectTab(true);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 45,
                    width: Get.width / 2.40,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    side: const BorderSide(
                                        color: Color(0xffFF7373)))),
                        backgroundColor:
                            cabBookingController.isRoundedSelected.value
                                ? MaterialStateProperty.all(Color(0xffFF7373))
                                : MaterialStateProperty.all(Colors.white),
                        foregroundColor:
                            MaterialStateProperty.all(Color(0xffFF7373)),
                      ),
                      child: Text(
                        'ROUND TRIP',
                        style: TextStyle(
                            color: cabBookingController.isRoundedSelected.value
                                ? Colors.white
                                : const Color(0xffFF7373),
                            fontSize: 15),
                      ),
                      onPressed: () {
                        cabBookingController.selectTab(false);
                      },
                    ),
                  ),
                ],
              ),
            )
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        Container(
          margin: const EdgeInsets.only(left: 12, right: 12, bottom: 15),
          child: SizedBox(
            height: 45,
            width: Get.width,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(color: Color(0xffFF7373)))),
                backgroundColor: MaterialStateProperty.all(Colors.white),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              child: SignInSignUpController().isLoading.value
                  ? Container(child: Center(child: CircularProgressIndicator()))
                  : Text(
                      'BOOK DRIVER',
                      style: TextStyle(
                        color: Color(0xffFF7373),
                        fontSize: 15,
                      ),
                    ),
              onPressed: () async {
                print('selectltlog: ${cabBookingController.selectedLtlongPickup.value} ${cabBookingController.selectedLtlongDrop} ${cabBookingController.estimatedFareForInCity}');
                var prefs = await SharedPreferences.getInstance();
                   if (prefs.getString(SPKeys.USERTOKEN).toString() != "null"){
                     if(cabBookingController.selectedLtlongPickup.value.isNotEmpty && cabBookingController.selectedLtlongDrop.isNotEmpty) {
                     cabBookingController.addListForBookDriver(context);
                   } else {
                       Fluttertoast.showToast(msg: "All fields are Mandatory !!!");
                     }
                }else{
                     SignInPage().bottomSheet(context);
                   }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget outstationView() {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(right: 10, left: 10, bottom: 15),
            height: 43,
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10)),
            child: RawAutocomplete(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  return const Iterable<String>.empty();
                } else {
                  cabBookingController.getPlaces(textEditingValue.text);
                  List<String> matches = <String>[];
                  matches.addAll(cabBookingController.suggestons);
                  matches.retainWhere((s) {
                    return s
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase());
                  });
                  return matches;
                }
              },
              onSelected: (String selection) {
                print('You just selected $selection');
              },
              fieldViewBuilder: (BuildContext context,
                  TextEditingController textEditingController,
                  FocusNode focusNode,
                  VoidCallback onFieldSubmitted) {
                return TextField(
                  decoration: const InputDecoration(
                      isDense: true,
                      hintText: 'Enter Your Pickup location',
                      border: InputBorder.none,
                      icon: Padding(
                        padding: EdgeInsets.only(left: 8.0, top: 10),
                        child: Icon(
                          Icons.search,
                          color: Color(0xffFF7373),
                          size: 25,
                        ),
                      )),
                  controller: textEditingController,
                  focusNode: focusNode,
                  onSubmitted: (String value) {},
                  onChanged: (vale) {
                    if (vale.isEmpty) {
                      cabBookingController.selectedLtlongPickup.value = '';
                    }
                  },
                );
              },
              optionsViewBuilder: (BuildContext context1,
                  void Function(String) onSelected, Iterable<String> options) {
                return Material(
                    child: SizedBox(
                        height: 100,
                        child: SingleChildScrollView(
                            child: Column(
                              children: options.map((opt) {
                                return InkWell(
                                    onTap: () {
                                      var getLtlogn = (cabBookingController
                                          .mapListDtt.value[opt]);
                                      cabBookingController.selectedLtlongPickup.value =
                                          getLtlogn
                                              .toString()
                                              .replaceAll('[', '')
                                              .toString()
                                              .replaceAll(']', '');
                                      print('opt: ${cabBookingController.selectedLtlongPickup.value}');
                                      if(cabBookingController.isRoundedSelected.value){
                                        cabBookingController.selectedLtlongDrop.value =getLtlogn
                                            .toString()
                                            .replaceAll('[', '')
                                            .toString()
                                            .replaceAll(']', '');
                                        cabBookingController.getEstimatFare(context);
                                      }else if (cabBookingController.selectedLtlongDrop.isNotEmpty) {
                                        cabBookingController.getEstimatFare(context);
                                      }

                                      onSelected(opt);
                                    },
                                    child: Container(
                                        padding: EdgeInsets.only(right: 18),
                                        child: Card(
                                            child: Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.all(10),
                                              child: Text(opt),
                                            ))));
                              }).toList(),
                            ))));
              },
            )
        ),
        Obx(
              () => Visibility(
            visible: cabBookingController.isOneWaySelected.value,
            child: Container(
                margin: const EdgeInsets.only(right: 10, left: 10, bottom: 15),
                height: 43,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10)),
                child: RawAutocomplete(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text == '') {
                      return const Iterable<String>.empty();
                    } else {
                      cabBookingController.getPlaces(textEditingValue.text);
                      List<String> matches = <String>[];
                      matches.addAll(cabBookingController.suggestons);
                      matches.retainWhere((s) {
                        return s
                            .toLowerCase()
                            .contains(textEditingValue.text.toLowerCase());
                      });
                      return matches;
                    }
                  },
                  onSelected: (String selection) {
                    print('You just selected $selection');
                  },
                  fieldViewBuilder: (BuildContext context,
                      TextEditingController textEditingController,
                      FocusNode focusNode,
                      VoidCallback onFieldSubmitted) {
                    return TextField(
                      decoration: const InputDecoration(
                          isDense: true,
                          hintText: 'Enter Your Drop location',
                          border: InputBorder.none,
                          icon: Padding(
                            padding: EdgeInsets.only(left: 8.0, top: 10),
                            child: Icon(
                              Icons.search,
                              color: Color(0xffFF7373),
                              size: 25,
                            ),
                          )),
                      onChanged: (vale) {
                        if (vale.isEmpty) {
                          cabBookingController.selectedLtlongDrop.value = '';
                        }
                        print("valdld: $vale");
                      },
                      controller: textEditingController,
                      focusNode: focusNode,
                      onSubmitted: (String value) {},
                    );
                  },
                  optionsViewBuilder: (BuildContext context1,
                      void Function(String) onSelected,
                      Iterable<String> options) {
                    return Material(
                        child: SizedBox(
                            height: 100,
                            child: SingleChildScrollView(
                                child: Column(
                                  children: options.map((opt) {
                                    return InkWell(
                                        onTap: () {
                                          var getLtlogn = (cabBookingController
                                              .mapListDtt.value[opt]);
                                          cabBookingController
                                              .selectedLtlongDrop.value =
                                              getLtlogn
                                                  .toString()
                                                  .replaceAll('[', '')
                                                  .toString()
                                                  .replaceAll(']', '');
                                          if (cabBookingController
                                              .selectedLtlongPickup.isNotEmpty) {
                                            cabBookingController
                                                .getEstimatFare(context);
                                          }
                                          // cabBookingController.getEstimatFare(context);
                                          onSelected(opt);
                                        },
                                        child: Container(
                                            padding: EdgeInsets.only(right: 18),
                                            child: Card(
                                                child: Container(
                                                  width: double.infinity,
                                                  padding: EdgeInsets.all(10),
                                                  child: Text(opt),
                                                ))));
                                  }).toList(),
                                ))));
                  },
                )),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * .95,
          height: 45,
          child: DecoratedBox(
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10)),
            child: TextField(
              controller: cabBookingController.dateInput,
              decoration: InputDecoration(
                  hintText: '  Select Date',
                  hintStyle: Tstyles.greycolor16,
                  border: InputBorder.none,
                  suffixIcon: const Icon(Icons.calendar_month,color: Color(0xffFF7373),)),
              readOnly: true,
              onTap: () {
                cabBookingController.selectDate(context);
              },
            ),
          ),
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        Container(
          margin: const EdgeInsets.only(left: 10,right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: const Text('Select Estimated usage ( in Day )'),
              ),
              InkWell(
                onTap: (){
                  cabBookingController.showDayOutStationAlertDialog(context);

                },
                child: Obx(() => Container(
                    width: MediaQuery.of(context).size.width /3,
                    height: 45,
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text("${cabBookingController.estimateDaySlider.value.toStringAsFixed(0)} day"),
                        )))),
              ),
            ],
          ),
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Radio(
                  value: 1,
                  groupValue: cabBookingController.radioSelected.value,
                  activeColor: const Color(0xffFF7373),
                  onChanged: (value) {
                    setState(() {
                      cabBookingController.radioSelected.value = value!;
                    });
                  },
                ),
                const Text("MANUAL",
                    style: TextStyle(color: Colors.black, fontSize: 15)),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: 2,
                  groupValue: cabBookingController.radioSelected.value,
                  activeColor: const Color(0xffFF7373),
                  onChanged: (value) {
                    setState(() {
                      cabBookingController.radioSelected.value = value!;
                    });
                  },
                ),
                const Text("AUTOMATIC",
                    style: TextStyle(color: Colors.black, fontSize: 15)),
              ],
            ),
          ],
        ),
        SizedBox(
          height: Get.height * 0.01,
        ),
         DropDown(),
        Obx(() => Container(
          margin: EdgeInsets.only(left: 15,right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    "Show Price Breakup",
                  ),
                  SizedBox(width: 8),
                  InkWell(
                    onTap: (){
                      if(cabBookingController.viewBreakUpPriceInCity.value.isNotEmpty)
                      cabBookingController.showPriceBreakupInCity(context);
                    },
                    child: const Icon(
                        Icons.remove_red_eye_outlined,
                        color: Color(0xffFF7373)
                    ),
                  )
                ],
              ),
              Text(
                "₹ ${cabBookingController.estimatedFareForOutStation.value}",
                style:
                const TextStyle(fontSize: 20, color: Color(0xffFF7373),
                ),
              ),
            ],
          ),
        )),
        SizedBox(
          height: Get.height * 0.02,
        ),
        Obx(() => Container(
              margin: const EdgeInsets.only(left: 12, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 45,
                    width: Get.width / 2.40,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    side: const BorderSide(
                                        color: Color(0xffFF7373)))),
                        backgroundColor: cabBookingController
                                .isOneWaySelected.value
                            ? MaterialStateProperty.all(const Color(0xffFF7373))
                            : MaterialStateProperty.all(Colors.white),
                        foregroundColor:
                            MaterialStateProperty.all(const Color(0xffFF7373)),
                      ),
                      child: Text(
                        'ONE WAY',
                        style: TextStyle(
                          color: cabBookingController.isOneWaySelected.value
                              ? Colors.white
                              : const Color(0xffFF7373),
                          fontSize: 15,
                        ),
                      ),
                      onPressed: () {
                        cabBookingController.selectTab(true);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 45,
                    width: Get.width / 2.40,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    side: const BorderSide(
                                        color: Color(0xffFF7373)))),
                        backgroundColor:
                            cabBookingController.isRoundedSelected.value
                                ? MaterialStateProperty.all(Color(0xffFF7373))
                                : MaterialStateProperty.all(Colors.white),
                        foregroundColor:
                            MaterialStateProperty.all(Color(0xffFF7373)),
                      ),
                      child: Text(
                        'ROUND TRIP',
                        style: TextStyle(
                            color: cabBookingController.isRoundedSelected.value
                                ? Colors.white
                                : const Color(0xffFF7373),
                            fontSize: 15),
                      ),
                      onPressed: () {
                        cabBookingController.selectTab(false);
                      },
                    ),
                  ),
                ],
              ),
            )),
        SizedBox(
          height: Get.height * 0.02,
        ),
        Container(
          margin: const EdgeInsets.only(left: 12, right: 12, bottom: 15),
          child: SizedBox(
            height: 45,
            width: Get.width,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: const BorderSide(color: Color(0xffFF7373)))),
                backgroundColor: MaterialStateProperty.all(Colors.white),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              child: const Text(
                'BOOK DRIVER',
                style: TextStyle(
                  color: Color(0xffFF7373),
                  fontSize: 15,
                ),
              ),
              onPressed: () async {
                var prefs = await SharedPreferences.getInstance();
                if (prefs.getString(SPKeys.USERTOKEN) != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  DriverBookingFinalPage()),
                  );
                } else {
                  SignInPage().bottomSheet(context);
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget monthlyView() {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(right: 10, left: 10, bottom: 15),
            height: 43,
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10)),
            child: RawAutocomplete(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  return const Iterable<String>.empty();
                } else {
                  cabBookingController.getPlaces(textEditingValue.text);
                  List<String> matches = <String>[];
                  matches.addAll(cabBookingController.suggestons);
                  matches.retainWhere((s) {
                    return s
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase());
                  });
                  return matches;
                }
              },
              onSelected: (String selection) {
              },
              fieldViewBuilder: (BuildContext context,
                  TextEditingController textEditingController,
                  FocusNode focusNode,
                  VoidCallback onFieldSubmitted) {
                return TextField(
                  decoration: const InputDecoration(
                      isDense: true,
                      hintText: 'Enter Your Pickup location',
                      border: InputBorder.none,
                      icon: Padding(
                        padding: EdgeInsets.only(left: 8.0, top: 10),
                        child: Icon(
                          Icons.search,
                          color: Color(0xffFF7373),
                          size: 25,
                        ),
                      )),
                  controller: textEditingController,
                  focusNode: focusNode,
                  onSubmitted: (String value) {},
                  onChanged: (vale) {
                    if (vale.isEmpty) {
                      cabBookingController.selectedLtlongMonthlyPickup.value = '';
                    }
                  },
                );
              },
              optionsViewBuilder: (BuildContext context1,
                  void Function(String) onSelected, Iterable<String> options) {
                return Material(
                    child: SizedBox(
                        height: 100,
                        child: SingleChildScrollView(
                            child: Column(
                              children: options.map((opt) {
                                return InkWell(
                                    onTap: () {
                                      var getLtlogn = cabBookingController.mapListDtt.value[opt];
                                       cabBookingController.selectedLtlongMonthlyPickup.value = getLtlogn.toString().replaceAll('[', '').toString().replaceAll(']', '');
                                        cabBookingController.getEstimatFareForMonthly(context);
                                      onSelected(opt);
                                    },
                                    child: Container(
                                        padding: EdgeInsets.only(right: 18),
                                        child: Card(
                                            child: Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.all(10),
                                              child: Text(opt),
                                            ))));
                              }).toList(),
                            ))));
              },
            )),
        SizedBox(
          width: MediaQuery.of(context).size.width * .95,
          height: 45,
          child: DecoratedBox(
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10)),
            child: TextField(
              controller:
                  cabBookingController.dateInput,
              decoration: InputDecoration(
                  hintText: '  Select Date',
                  hintStyle: Tstyles.greycolor16,
                  border: InputBorder.none,
                  suffixIcon: const Icon(Icons.calendar_month,
                  color: Color(0xffFF7373),
                  )),
              readOnly: true,
              onTap: () {
                cabBookingController.selectDate(context);
              },
            ),
          ),
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: (){
                cabBookingController.showHoursDialogForMonthly(context);
              },
              child: Obx(() => Container(
                margin: EdgeInsets.only(left: 15,right: 15),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: const Text('Select Hours'),),
                    Container(
                        width: MediaQuery.of(context).size.width /3,
                        height: 45,
                        child: DecoratedBox(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text("${cabBookingController.selectHours.value.toStringAsFixed(0)} hrs"),
                            ))),
                  ],
                ),
              )),
            ),
            InkWell(
              onTap: (){cabBookingController.showDayDialogForMonthly(context);},
              child: Obx(() => Container(
                margin: EdgeInsets.only(left: 15,right: 15),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: const Text('Select Days'),),
                    Container(
                        width: MediaQuery.of(context).size.width /3,
                        height: 45,
                        child: DecoratedBox(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text("${cabBookingController.selectDays.value.toStringAsFixed(0)} days"),
                            ))),
                  ],
                ),
              )),
            ),
          ],
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        Container(
          margin: const EdgeInsets.only(right: 10),
          width: Get.width,
          child: CustomTextFormField(
            isReadOnly: false,
            textEditingController:
                cabBookingController.monthlyPackageNoteController,
            hint: 'Enter Note',
          ),
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          width: Get.width,
          child: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey.shade200),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                    isDense: true,
                    value: cabBookingController.selectedMonthlyPackage,
                    onChanged: (newValue) {
                      setState(() {
                        cabBookingController.selectedMonthlyPackage = newValue!;
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
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Radio(
                  value: 1,
                  groupValue: cabBookingController.radioSelected.value,
                  activeColor: const Color(0xffFF7373),
                  onChanged: (value) {
                    setState(() {
                      cabBookingController.radioSelected.value = value!;
                    });
                  },
                ),
                const Text("MANUAL",
                    style: TextStyle(color: Colors.black, fontSize: 15)),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: 2,
                  groupValue: cabBookingController.radioSelected.value,
                  activeColor: const Color(0xffFF7373),
                  onChanged: (value) {
                    setState(() {
                      cabBookingController.radioSelected.value = value!;
                    });
                  },
                ),
                const Text("AUTOMATIC",
                    style: TextStyle(color: Colors.black, fontSize: 15)),
              ],
            ),
          ],
        ),
        SizedBox(
          height: Get.height * 0.01,
        ),
         DropDown(),
        Obx(() => Container(
          margin: EdgeInsets.only(left: 15,right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    "Show Price Breakup",
                  ),
                  SizedBox(width: 8),
                  InkWell(
                    onTap: (){
                      if(cabBookingController.viewBreakUpPriceMonthly.value.isNotEmpty)
                        cabBookingController.showPriceBreakupMonthly(context);
                    },
                    child: const Icon(
                      Icons.remove_red_eye_outlined,
                        color: Color(0xffFF7373)
                    ),
                  )
                ],
              ),
              Text(
                "₹ ${cabBookingController.estimatedFareForMonthly.value}",
                style: const TextStyle(fontSize: 20, color: Color(0xffFF7373),
                ),
              ),
            ],
          ),
        )),
        SizedBox(
          height: Get.height * 0.02,
        ),
        Obx(() => Container(
              margin: const EdgeInsets.only(left: 12, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 45,
                    width: Get.width / 2.40,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    side: const BorderSide(
                                        color: Color(0xffFF7373)))),
                        backgroundColor: cabBookingController
                                .isPrivateSelected.value
                            ? MaterialStateProperty.all(const Color(0xffFF7373))
                            : MaterialStateProperty.all(Colors.white),
                        foregroundColor:
                            MaterialStateProperty.all(const Color(0xffFF7373)),
                      ),
                      child: Text(
                        'PRIVATE',
                        style: TextStyle(
                          color: cabBookingController.isPrivateSelected.value
                              ? Colors.white
                              : const Color(0xffFF7373),
                          fontSize: 15,
                        ),
                      ),
                      onPressed: () {
                        cabBookingController.selectMonthlyPrivate(true);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 45,
                    width: Get.width / 2.40,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    side: const BorderSide(
                                        color: Color(0xffFF7373)))),
                        backgroundColor: cabBookingController
                                .isCormmercialSelected.value
                            ? MaterialStateProperty.all(const Color(0xffFF7373))
                            : MaterialStateProperty.all(Colors.white),
                        foregroundColor:
                            MaterialStateProperty.all(const Color(0xffFF7373)),
                      ),
                      child: Text(
                        'COMMERCIAL',
                        style: TextStyle(
                            color: cabBookingController.isCormmercialSelected.value
                                ? Colors.white
                                : const Color(0xffFF7373),
                            fontSize: 15),
                      ),
                      onPressed: () {
                        cabBookingController.selectMonthlyPrivate(false);
                      },
                    ),
                  ),
                ],
              ),
            )),
        SizedBox(
          height: Get.height * 0.02,
        ),
        Container(
          margin: const EdgeInsets.only(left: 12, right: 12, bottom: 15),
          child: SizedBox(
            height: 45,
            width: Get.width,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: const BorderSide(color: Color(0xffFF7373)))),
                backgroundColor: MaterialStateProperty.all(Colors.white),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              child: const Text(
                'BOOK DRIVER',
                style: TextStyle(
                  color: Color(0xffFF7373),
                  fontSize: 15,
                ),
              ),
              onPressed: () async {
                var prefs = await SharedPreferences.getInstance();
                if (prefs.getString(SPKeys.USERTOKEN) != null) {
                } else {
                  SignInPage().bottomSheet(context);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
