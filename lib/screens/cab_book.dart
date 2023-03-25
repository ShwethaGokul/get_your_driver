import 'package:flutter/material.dart';

class CabBookingScreen extends StatefulWidget {
  const CabBookingScreen({Key? key}) : super(key: key);

  @override
  _CabBookingScreenState createState() => _CabBookingScreenState();
}

class _CabBookingScreenState extends State<CabBookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
         mainAxisAlignment: MainAxisAlignment.center,
         children:[
           Card(
             child: Container(
               color: Colors.redAccent,
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                  Column(
                    children: [
                      Text("Ready? Then let's roll.")
                    ],
                  ),
                   Column(
                    children: [
                      Image.asset('assets/images/driver.jpg',
                      height: 130,
                        width: 160,
                        fit: BoxFit.fill,
                      )
                    ],
                  ),

                 ],
               ),
             ),
           ),
            ]
        ),
      ),
    );
  }
}
