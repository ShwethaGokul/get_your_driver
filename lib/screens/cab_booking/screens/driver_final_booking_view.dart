import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_your_driver/screens/cab_booking/controller/driver_final_booking_controller.dart';
import 'package:intl/intl.dart';

import 'driver_booked_comfirmed.dart';

class DriverBookingFinalPage extends StatefulWidget {
   DriverBookingFinalPage({Key? key,this.listData}) : super(key: key);
  var listData;
  @override
  _DriverBookingFinalPageState createState() => _DriverBookingFinalPageState();
}

class _DriverBookingFinalPageState extends State<DriverBookingFinalPage> {

  DriverFinalBookingController driverFinalBookingController = Get.put(DriverFinalBookingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(''),
        leading: IconButton(icon: Icon(Icons.arrow_back_sharp,color: Colors.black,),onPressed: (){
          Navigator.of(context).pop();
        },),
        actions: [
          Container(
            margin: EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width / 4,
              height: 30,
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(4)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.help_center_outlined,color: Color(0xffFF7373),),
                      SizedBox(width: 5,),
                      Text("Help",style: TextStyle(color: Color(0xffFF7373),fontWeight: FontWeight.bold),),
                    ],
                  )))
        ],

      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 15,left: 10,right: 10),
              width: Get.width,
              height: Get.width *0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: Colors.grey,),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 10,top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Order date',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
                          Text(DateFormat('MMM dd, hh:mm a').format(DateTime.now()),style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600,letterSpacing: 0.6),),
                          const SizedBox(height: 10),
                          const Text('Order ID',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
                          const Text('RGF7658GF64',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600,letterSpacing: 0.6),),
                        ],
                      ))
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10,right: 10,top: 10),
              width: Get.width,
              height: Get.width *0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                border: Border.all(color: Colors.grey,),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(left: 10,top: 10),
                        child: Row(
                          children: [
                            Icon(Icons.album_rounded,size: 16,color: Colors.green,),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Pickup',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
                                  Expanded(child: Text('${widget.listData[0]['PickupLocation'] != null ?widget.listData[0]['PickupLocation'] : '-'}',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600),)),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(left: 10,top: 10),
                        child: Row(
                          children: [
                            Icon(Icons.album_rounded,size: 16,color: Colors.red,),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Dropoff',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
                                  Expanded(child: Text('${widget.listData[0]['DropLocation'] != null ? widget.listData[0]['DropLocation'] : '-'}',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600),)),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10,right: 10,top: 10),
              width: Get.width,
              height: Get.width *0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: Colors.grey,),
              ),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Date and Time',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
                          Text('${widget.listData[0]['DateTime'] != null ?widget.listData[0]['DateTime'].toString().trim() : '-'}',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600,letterSpacing: 0.6),),
                           ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Estimated ride',style: TextStyle(color: Colors.red,fontWeight: FontWeight.w600),),
                          Text('${widget.listData[0]['EstimatedTime'] != null ?widget.listData[0]['EstimatedTime'] : '-'} hrs',style: TextStyle(color: Colors.red,fontWeight: FontWeight.w600),),
                           ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10,right: 10,top: 10),
              width: Get.width,
              height: Get.width *0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.grey,),
              ),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Payment',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Full Payment',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600),),
                                Text('RS ${widget.listData[0]['EstimatedFare'] != null ?widget.listData[0]['EstimatedFare'] : '-'}',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600),),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Advance Payment',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600),),
                                Text('RS 0',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600),),
                              ],
                            ),
                            ],
                        )),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      height: 1,
                      width: Get.width,
                      color: Colors.grey,),
                    SizedBox(height: 10,),
                    Container(
                      margin: EdgeInsets.only(left: 10,right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Payment',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600),),
                          Text('RS ${widget.listData[0]['EstimatedFare'] != null ?widget.listData[0]['EstimatedFare'] : '-'}',style: TextStyle(color: Color(0xffFF7373),fontWeight: FontWeight.w600),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Obx(() => Container(
              margin: EdgeInsets.only(left: 10,right: 10,top: 50,bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // SizedBox(
                  //   height: 45,
                  //   width: Get.width / 2.40,
                  //   child: ElevatedButton(
                  //     style: ButtonStyle(
                  //       shape:
                  //       MaterialStateProperty.all<RoundedRectangleBorder>(
                  //           RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(5.0),
                  //               side: const BorderSide(
                  //                   color: Color(0xffFF7373)))),
                  //       backgroundColor: driverFinalBookingController
                  //           .isCancelSelected.value
                  //           ? MaterialStateProperty.all(const Color(0xffFF7373))
                  //           : MaterialStateProperty.all(Colors.white),
                  //       foregroundColor:
                  //       MaterialStateProperty.all(const Color(0xffFF7373)),
                  //     ),
                  //     child: Text(
                  //       'Cancel',
                  //       style: TextStyle(
                  //         color: driverFinalBookingController.isCancelSelected.value
                  //             ? Colors.white
                  //             : const Color(0xffFF7373),
                  //         fontSize: 15,
                  //       ),
                  //     ),
                  //     onPressed: () {
                  //       driverFinalBookingController.selectTab(true);
                  //     },
                  //   ),
                  // ),
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
                        driverFinalBookingController.isRescheduleSelected.value
                            ? MaterialStateProperty.all(Color(0xffFF7373))
                            : MaterialStateProperty.all(Colors.white),
                        foregroundColor:
                        MaterialStateProperty.all(Color(0xffFF7373)),
                      ),
                      child: driverFinalBookingController.isLoading.value
                          ? Container(child: Center(child: CircularProgressIndicator(color: Colors.white,)))
                          :  Text(
                        'Confirm',
                        style: TextStyle(
                            color: driverFinalBookingController.isRescheduleSelected.value
                                ? Colors.white
                                : const Color(0xffFF7373),
                            fontSize: 17),
                      ),
                      onPressed: () {
                        driverFinalBookingController.isLoading.value = true;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DriverBookedConfirmed()),
                        );
                        // driverFinalBookingController.isLoading.value = true;
                        // driverFinalBookingController.bookingDriver(context,widget.listData);
                      },
                    ),
                  ),
                ],
              ),
            )
            ),
          ],
        ),
      ),
    );
  }
}
