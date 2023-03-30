import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_your_driver/screens/cab_booking/cab_booking_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKeyMobileNumber = GlobalKey<FormState>();
  final _formKeySingUpMobileNumber = GlobalKey<FormState>();
  final _formKeyUserName = GlobalKey<FormState>();
  final _formKeyEmail= GlobalKey<FormState>();
  var phoneTextEditingController = new TextEditingController();
  var phoneSignUpTextEditingController = new TextEditingController();
  var usernameTextEditingController = new TextEditingController();
  var emailTextEditingController = new TextEditingController();
  var checkBoxValue = false.obs;

  final _radioSelected = 1.obs;

  var sellEarnList = [
    "Cab Booking",
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              height: 180,
              child: ListView.builder(
                  itemCount: sellEarnList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CabBookingScreen()));
                        },
                      child: Column(
                        children: [
                          Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "assets/images/car.jpg",
                                  height: 80,
                                  width: 80,
                                )
                              ],
                            ),
                          ),
                          Text(sellEarnList[index])
                        ],
                      ),
                    );
                  })),
      ),
    );
  }
}
// signInView() {
//   return Container(
//     child: Column(
//       children: [
//         SizedBox(height: 30),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Form(
//             key: _formKeyMobileNumber,
//             child: TextFormField(
//               keyboardType: TextInputType.number,
//               validator: (value) {
//                 if (value!.isNotEmpty) {
//                   return null;
//                 } else {
//                   return 'Enter Mobile Number';
//                 }
//               },
//               decoration: InputDecoration(
//                   isDense: true,
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                   suffixIcon: Icon(
//                     Icons.phone,
//                     color: Color.fromRGBO(125, 1, 120, 1),
//                   ),
//                   label: const Text('Mobile Number'),
//                   focusColor: Color.fromRGBO(125, 1, 120, 1)),
//               controller: phoneTextEditingController,
//             ),
//           ),
//         ),
//         SizedBox(height: 40),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: SizedBox(
//             width: double.infinity,
//             height: 50.0,
//             child: ElevatedButton(
//               style: ButtonStyle(
//                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5.0),
//                         side: BorderSide(color: AppColors.redIconGradient1))),
//                 elevation: MaterialStateProperty.all(3.0),
//                 backgroundColor:
//                 MaterialStateProperty.all(AppColors.redIconGradient1),
//                 foregroundColor: MaterialStateProperty.all(Colors.white),
//               ),
//               child: Text(
//                 'SIGN IN',
//                 style: TextStyle(
//                     color: Colors.white, fontSize: 18, letterSpacing: 0.6),
//               ),
//               onPressed: () {
//                 if (!_formKeyMobileNumber.currentState!.validate()) {
//                   return;
//                 }
//                 signInClick(phoneTextEditingController.text);
//               },
//             ),
//           ),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "New to GetYourDriver ?",
//               style: Theme.of(context).textTheme.bodyText2?.copyWith(
//                   color: Colors.black, decoration: TextDecoration.underline),
//             ),
//             SizedBox(
//               width: 10,
//             ),
//             InkWell(
//               onTap: () {
//                 // Navigator.push(
//                 //   context,
//                 //   MaterialPageRoute(
//                 //     builder: (context) => ForgotPasswordScreen(),
//                 //   ),
//                 // );
//                 // Navigator.pushReplacementNamed(
//                 //     context, Routes.Signup);
//               },
//               child: Center(
//                 child: Text(
//                   "Sign up",
//                   style: Theme.of(context).textTheme.bodyText2?.copyWith(
//                       color: Colors.black,
//                       decoration: TextDecoration.underline),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }
//
// signUpView() {
//   return Container(
//     child: Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Form(
//             key: _formKeyUserName,
//             child: TextFormField(
//               keyboardType: TextInputType.text,
//               validator: (value) {
//                 if (value!.isNotEmpty) {
//                   return null;
//                 } else {
//                   return 'Enter Full Name';
//                 }
//               },
//               decoration: InputDecoration(
//                   isDense: true,
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                   // suffixIcon: Icon(Icons.phone,color: Color.fromRGBO(125,1,120,1),),
//                   label: const Text('Full Name'),
//                   focusColor: AppColors.redIconGradient1),
//               controller: usernameTextEditingController,
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Form(
//             key: _formKeySingUpMobileNumber,
//             child: TextFormField(
//               keyboardType: TextInputType.number,
//               validator: (value) {
//                 if (value!.isNotEmpty) {
//                   return null;
//                 } else {
//                   return 'Full Mobile Number';
//                 }
//               },
//               decoration: InputDecoration(
//                   isDense: true,
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                   // suffixIcon: Icon(Icons.phone,color: Color.fromRGBO(125,1,120,1),),
//                   label: const Text('Mobile Number'),
//                   focusColor: Color.fromRGBO(125, 1, 120, 1)),
//               controller: phoneSignUpTextEditingController,
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Form(
//             key: _formKeyEmail,
//             child: TextFormField(
//               keyboardType: TextInputType.emailAddress,
//               validator: (value) {
//                 if (value!.isNotEmpty) {
//                   return null;
//                 } else {
//                   return 'Email ID';
//                 }
//               },
//               decoration: InputDecoration(
//                   isDense: true,
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                   // suffixIcon: Icon(Icons.phone,color: Color.fromRGBO(125,1,120,1),),
//                   label: const Text('Email ID'),
//                   focusColor: AppColors.redIconGradient1),
//               controller: emailTextEditingController,
//             ),
//           ),
//         ),
//         Container(
//           child: Row(
//             children: [
//               Checkbox(
//                   value: checkBoxValue.value,
//                   activeColor: Colors.blue,
//                   onChanged: (newValue) {
//                     setState(() {
//                       checkBoxValue.value = newValue!;
//                     });
//                   }),
//               Text('I agree all statements in'),
//               SizedBox(
//                 width: 10,
//               ),
//               InkWell(
//                 onTap: () {
//                   // Navigator.push(
//                   //   context,
//                   //   MaterialPageRoute(
//                   //     builder: (context) => ForgotPasswordScreen(),
//                   //   ),
//                   // );
//                   // Navigator.pushReplacementNamed(
//                   //     context, Routes.Signup);
//                 },
//                 child: Center(
//                   child: Text(
//                     "terms of service",
//                     style: Theme.of(context).textTheme.bodyText2?.copyWith(
//                         color: Colors.black,
//                         decoration: TextDecoration.underline),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: SizedBox(
//             width: double.infinity,
//             height: 50.0,
//             child: ElevatedButton(
//               style: ButtonStyle(
//                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5.0),
//                         side: BorderSide(color: AppColors.redIconGradient1))),
//                 elevation: MaterialStateProperty.all(3.0),
//                 backgroundColor:
//                 MaterialStateProperty.all(AppColors.redIconGradient1),
//                 foregroundColor: MaterialStateProperty.all(Colors.white),
//               ),
//               child: Text(
//                 'SIGN UP',
//                 style: TextStyle(
//                     color: Colors.white, fontSize: 18, letterSpacing: 0.6),
//               ),
//               onPressed: () {
//                 if (!_formKeyUserName.currentState!.validate() || !_formKeySingUpMobileNumber.currentState!.validate() || !_formKeyEmail.currentState!.validate()) {
//                   return;
//                 }
//                 signUpClick(mobNumber: phoneSignUpTextEditingController.text,username: usernameTextEditingController.text,emailId: emailTextEditingController.text);
//               },
//             ),
//           ),
//         )
//       ],
//     ),
//   );
// }
//
// signUpClick({var username, var mobNumber, var emailId}) async {
//   var headers = {
//     'Cookie': 'ci_session=5ac53b9fb5f52fecf4fa02849e196d74d3854cac'
//   };
//   var request = http.MultipartRequest(
//       'POST', Uri.parse('https://www.getyourdriver.com/user/signup'));
//   request.fields.addAll({"name": username,
//     "mobile": mobNumber,
//     "email": emailId,
//     "src": "Mobile"});
//
//   request.headers.addAll(headers);
//
//   http.StreamedResponse response = await request.send();
//
//   if (response.statusCode == 200) {
//     var dd = json.decode(await response.stream.bytesToString());
//
//     Fluttertoast.showToast(msg: dd['message']);
//
//     print('response: ${dd['message']}');
//   } else {
//     print(response.reasonPhrase);
//   }
// }
//
// signInClick(var mobNumber) async {
//   var headers = {
//     'Cookie': 'ci_session=5ac53b9fb5f52fecf4fa02849e196d74d3854cac'
//   };
//   var request = http.MultipartRequest(
//       'POST', Uri.parse('https://www.getyourdriver.com/user/signin'));
//   request.fields.addAll({'mobile': '${mobNumber}'});
//
//   request.headers.addAll(headers);
//
//   http.StreamedResponse response = await request.send();
//
//   if (response.statusCode == 200) {
//     var dd = json.decode(await response.stream.bytesToString());
//
//     Fluttertoast.showToast(msg: dd['message']);
//
//     print('response: ${dd['message']}');
//   } else {
//     print(response.reasonPhrase);
//   }
// }