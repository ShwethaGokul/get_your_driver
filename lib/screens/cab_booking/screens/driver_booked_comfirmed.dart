import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_your_driver/screens/cab_booking/screens/cab_booking_screen.dart';
import 'package:http/http.dart' as http;

import '../../../helper/constansts.dart';
import '../controller/driver_final_booking_controller.dart';
import '../controller/driver_search_controller.dart';


class DriverBookedConfirmed extends StatefulWidget {
   DriverBookedConfirmed({Key? key,this.bookedData}) : super(key: key);
   var bookedData;

  @override
  State<DriverBookedConfirmed> createState() => _DriverBookedConfirmedState();
}

class _DriverBookedConfirmedState extends State<DriverBookedConfirmed> {
   var listData = {}.obs;
   Duration duration = Duration();

   Timer? timer;
   var start = 30.obs;
 @override
  void initState() {
    // TODO: implement initState
   // DriverSearchController().startTimer();
   startTimer();
   // DriverFinalBookingController().searchDriver(widget.bookedData['booking_id']).
   // then((stat) {
   //   listData.value = json.decode(stat);
   //   print("statdd: ${listData.value}");
   // });
    super.initState();
  }

   void startTimer() {
     const oneSec = const Duration(seconds: 1);
     print('onesec $oneSec');
     timer = new Timer.periodic(
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

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(onPressed: (){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => CabBookingScreen()),
            );
          }, icon: Icon(Icons.clear,color: Color(0xffFF7373),size: 28,))
        ],
      ),
       body: Obx(() =>  Column(
      children:[
        DriverFinalBookingController().isSearching.value ? Container(child: const Center(child: CircularProgressIndicator())): Center(
          child: Container(
            margin: const EdgeInsets.only(top: 30),
          child: Image.asset(
            "assets/images/driver_booked_successfull.png",
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/3,
          ),
      )),
        // listData.value['message'].toString() != 'null' ?  Expanded(child: Container(
        //     margin: EdgeInsets.only(left: 10,right: 10,top: 20),
        //     child: Text(listData.value['message'].toString(),style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w600),)))
        // :
         Text('Please wait we are searching driver....',style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w600),),
        Container(
            width: MediaQuery.of(context).size.width / 4,
            height: 40,
            margin: EdgeInsets.only(top: 10),
            child: DecoratedBox(
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child:
                  Text("${start}",style: TextStyle(fontSize: 22),),
                ))) ,       const Text('Your Booking ID',style: TextStyle(fontSize: 26,color:  Color(0xffFF7373),fontWeight: FontWeight.w600,letterSpacing: 0.6),),
        // Text('${widget.bookedData['booking_id']}',style: TextStyle(fontSize: 22, color: Color(0xffFF7373),fontWeight: FontWeight.w600,letterSpacing: 0.6),),
        const Spacer(),
        SizedBox(
          height: 45,
          width: Get.width / 1.06,
          child: ElevatedButton(
            style: ButtonStyle(
              shape:
              MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: const BorderSide(
                          color: Color(0xffFF7373)))),
              backgroundColor:
               MaterialStateProperty.all(Color(0xffFF7373)),
              foregroundColor:
              MaterialStateProperty.all(Color(0xffFF7373)),
            ),
            child:  const Text(
              'Done',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => CabBookingScreen()),
              );
            },
          ),
        ),
        SizedBox(height: 30,)

      ]),
       ));
  }
}
