import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_your_driver/login/controllers/login_screen_controller.dart';
import 'package:get_your_driver/screens/cab_book.dart';
import 'package:get_your_driver/theme_manager.dart';

import 'login/views/login_ui.dart';
import 'package:http/http.dart' as http;

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
  LoginController _loginController = Get.put(LoginController());
  LoginPage loginPage = Get.put(LoginPage());
  final _formKeyMobileNumber = GlobalKey<FormState>();
 var phoneTextEditingController = new TextEditingController();
  var checkBoxValue = false.obs;


  final _radioSelected = 1.obs;



  var sellEarnList = [
    "In City",
    "Monthly Package",
    "Out Station",
  ];
  _buildPopupDialog() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15), topLeft: Radius.circular(15)),
        ),
        builder: (context) => Obx(()=>Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Container(
              child: Column(
                  children:[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                _loginController.isSignIn.value = true;
                                _loginController.isSignUp.value = false;
                              });
                            },
                            child: Container(
                              width: Get.width / 2.3,
                              margin: const EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
                                  border: Border.all(color: AppColors.redIconGradient1),
                                  color:
                                  _loginController.isSignIn.value
                                      ? AppColors.redIconGradient1
                                      :
                                  Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20, top: 10, bottom: 10),
                                child: Center(
                                  child: Text(
                                    "SIGN IN",
                                    style: TextStyle(
                                        color:
                                        _loginController.isSignIn.value
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _loginController.isSignIn.value = false;
                                _loginController.isSignUp.value = true;
                              });
                            },
                            child: Container(
                              width: Get.width / 2.4,
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(),
                                color: _loginController.isSignUp.value
                                    ? AppColors.redIconGradient1
                                    : Colors.white,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8, top: 10, bottom: 10),
                                child: Center(
                                  child: Text(
                                    "SIGN UP",
                                    style: TextStyle(
                                        color:
                                        _loginController.isSignUp.value
                                            ? Colors.white
                                            : Colors.black,

                                        fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _loginController.isSignIn.value == true ?  signInView()  : signUpView()
                  ])
          )
        ))
    );
  }
  signInView(){
    return Container(
      child: Column(
        children: [
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKeyMobileNumber,
              child: TextFormField(
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return null;
                  } else {
                    return 'Enter Mobile Number';
                  }
                },
                decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    suffixIcon: Icon(Icons.phone,color: Color.fromRGBO(125,1,120,1),),
                    label: const Text('Mobile Number'),
                    focusColor: Color.fromRGBO(125,1,120,1)
                ),
                controller: phoneTextEditingController,
              ),
            ),
          ),
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              height: 50.0,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(color:AppColors.redIconGradient1)
                      )
                  ),
                  elevation: MaterialStateProperty.all(3.0),
                  backgroundColor:
                  MaterialStateProperty.all(AppColors.redIconGradient1),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
                child: Text(
                  'SIGN IN',
                  style: TextStyle(color: Colors.white,fontSize: 18,letterSpacing: 0.6),
                ),
                onPressed: () {
                  if (!_formKeyMobileNumber.currentState!.validate()) {
                    return;
                  }
                  signInClick(phoneTextEditingController.text);
                },
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "New to GetYourDriver ?",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(
                    color: Colors.black,
                    decoration:
                    TextDecoration.underline),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ForgotPasswordScreen(),
                  //   ),
                  // );
                  // Navigator.pushReplacementNamed(
                  //     context, Routes.Signup);
                },
                child: Center(
                  child: Text(
                    "Sign up",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(
                        color: Colors.black,
                        decoration:
                        TextDecoration.underline),
                  ),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
  signUpView(){
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKeyMobileNumber,
              child: TextFormField(
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return null;
                  } else {
                    return 'Enter Full Name';
                  }
                },
                decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    // suffixIcon: Icon(Icons.phone,color: Color.fromRGBO(125,1,120,1),),
                    label: const Text('Full Name'),
                    focusColor: AppColors.redIconGradient1
                ),
                controller: phoneTextEditingController,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              // key: _formKeyMobileNumber,
              child: TextFormField(
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return null;
                  } else {
                    return 'Full Mobile Number';
                  }
                },
                decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    // suffixIcon: Icon(Icons.phone,color: Color.fromRGBO(125,1,120,1),),
                    label: const Text('Mobile Number'),
                    focusColor: Color.fromRGBO(125,1,120,1)
                ),
                controller: phoneTextEditingController,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              // key: _formKeyMobileNumber,
              child: TextFormField(
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return null;
                  } else {
                    return 'Email ID';
                  }
                },
                decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    // suffixIcon: Icon(Icons.phone,color: Color.fromRGBO(125,1,120,1),),
                    label: const Text('Email ID'),
                    focusColor: AppColors.redIconGradient1
                ),
                controller: phoneTextEditingController,
              ),
            ),
          ),
          Container(
            child: Row(
              children: [
                Checkbox(value: checkBoxValue.value,
                    activeColor: Colors.blue,
    onChanged:(newValue){
    setState(() {
    checkBoxValue.value = newValue!;
    });}),
                Text('I agree all statements in'),
                SizedBox(width: 10,),
                InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => ForgotPasswordScreen(),
                    //   ),
                    // );
                    // Navigator.pushReplacementNamed(
                    //     context, Routes.Signup);
                  },
                  child: Center(
                    child: Text(
                      "terms of service",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(
                          color: Colors.black,
                          decoration:
                          TextDecoration.underline),
                    ),
                  ),
                ),
              ],
            ),

          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              height: 50.0,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(color: AppColors.redIconGradient1)
                      )
                  ),
                  elevation: MaterialStateProperty.all(3.0),
                  backgroundColor:
                  MaterialStateProperty.all(AppColors.redIconGradient1),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
                child: Text(
                  'SIGN UP',
                  style: TextStyle(color: Colors.white,fontSize: 18,letterSpacing: 0.6),
                ),
                onPressed: () {
                  if (!_formKeyMobileNumber.currentState!.validate()) {
                    return;
                  }
                  signInClick(phoneTextEditingController.text);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  signUpClick(var mobNumber)async{
    var headers = {
      'Cookie': 'ci_session=5ac53b9fb5f52fecf4fa02849e196d74d3854cac'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://www.getyourdriver.com/user/signin'));
    request.fields.addAll({
      'mobile': '${mobNumber}'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var dd = json.decode(await response.stream.bytesToString());

      Fluttertoast.showToast(msg: dd['message']);

      print('response: ${dd['message']}');
    }
    else {
      print(response.reasonPhrase);
    }

  }
  signInClick(var mobNumber)async{
    var headers = {
      'Cookie': 'ci_session=5ac53b9fb5f52fecf4fa02849e196d74d3854cac'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://www.getyourdriver.com/user/signin'));
    request.fields.addAll({
      'mobile': '${mobNumber}'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var dd = json.decode(await response.stream.bytesToString());

      Fluttertoast.showToast(msg: dd['message']);

      print('response: ${dd['message']}');
    }
    else {
      print(response.reasonPhrase);
    }

  }
  @override
  Widget build(BuildContext context) {
       return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromRGBO(255, 153, 230, 1233),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Ready? Then\nlet's roll.",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Ride With Lorem -->",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: Get.height * 0.26,
                          width: Get.width * 0.44,
                          margin: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color.fromRGBO(255, 153, 230, 100),
                          ),
                          child: Image.asset(
                            'assets/images/driver.jpg',
                            fit: BoxFit.cover,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  height: 150,
                  child: ListView.builder(
                      itemCount: sellEarnList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        // String data = sellEarnList[index];
                        return InkWell(
                          onTap: () {
                            if (index == 0) {
                            } else {}
                            // Navigator.of(context)
                            // Get.toNamed(MRouter.sellAndEarn);
                          },
                          child: Column(
                            children: [
                              Card(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                          Radio(
                                            value: 2,
                                            groupValue: _radioSelected.value,
                                            activeColor: AppColors.redColor,
                                            onChanged: (value) {
                                              setState(() {
                                                _radioSelected.value = value!;
                                                // _radioVal = 'male';
                                                // _site = value;
                                              });
                                            },
                                          ),
                                    Image.asset("assets/images/car.jpg",
                                    height: 30,
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
              Row(
                children: [
                  InkWell(
                    onTap: () {
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2.2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          border: Border.all(color: AppColors.redIconGradient1),
                          color: AppColors.redIconGradient1),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8, top: 8, bottom: 8),
                        child: Center(
                            child: Text(
                          "One Way",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Card(
                      elevation: 7,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          border: Border.all(
                            color: Colors.white,
                          ),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 8, bottom: 8),
                          child: Center(
                            child: Text(
                              "Round Trip",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  border: Border.all(
                    color: Color.fromRGBO(219, 220,219,120),
                  ),
                  color: Color.fromRGBO(219, 220,219,120),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 8.0, top: 8, bottom: 8),
                  child: Row(
                    children: [
                      Icon(Icons.search),
                      Text(
                        "Enter your pickup location",
                        style:
                        TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  border: Border.all(
                    color: Color.fromRGBO(219, 220,219,120),
                  ),
                  color: Color.fromRGBO(219, 220,219,120),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 8.0, top: 8, bottom: 8),
                  child: Row(
                    children: [
                      Icon(Icons.search),
                      Text(
                        "Enter your destination location",
                        style:
                        TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  border: Border.all(
                    color: Color.fromRGBO(219, 220,219,120),
                  ),
                  color: Color.fromRGBO(219, 220,219,120),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 8.0, top: 8, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Select Date",
                        style:
                        TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      Icon(Icons.date_range_outlined),

                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text('Select Time'),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Container(
                            child: Text('From: '),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            border: Border.all(
                              color: Color.fromRGBO(219, 220,219,1),
                            ),
                            color: Color.fromRGBO(219, 220,219,1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, top: 8, bottom: 8),
                            child: Text(
                              "02:55AM",
                              style:
                              TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ),
                        ),   Center(
                          child: Container(
                            child: Text(' To: '),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            border: Border.all(
                              color: Color.fromRGBO(219, 220,219,1),
                            ),
                            color: Color.fromRGBO(219, 220,219,1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, top: 8, bottom: 8),
                            child: Text(
                              "04:55PM",
                              style:
                              TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            child: Text(' Total: 2hr '),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:  EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Radio(
                              value: 1,
                              groupValue: _radioSelected.value,
                              activeColor: AppColors.redColor,
                              onChanged: (value) {
                                setState(() {
                                  _radioSelected.value = value!;
                                });
                              },
                            ),
                            const Text("MANUAL",style: TextStyle(color: Colors.black54,fontSize: 15)),
                          ],
                        ),
                        SizedBox(width: 30),
                        Row(
                          children: [
                            Radio(
                              value: 2,
                              groupValue: _radioSelected.value,
                              activeColor: AppColors.redColor,
                              onChanged: (value) {
                                setState(() {
                                  _radioSelected.value = value!;
                                  // _radioVal = 'male';
                                  // _site = value;
                                });
                              },
                            ),
                            Text("AUTOMATIC",style: TextStyle(color: Colors.black54,fontSize: 15)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50.0,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: BorderSide(color: AppColors.redIconGradient1)
                              )
                          ),
                          // elevation: MaterialStateProperty.all(3.0),
                          backgroundColor:
                          MaterialStateProperty.all(Colors.white),
                          foregroundColor: MaterialStateProperty.all(Colors.white),
                        ),
                        child: Text(
                          'Book Driver',
                          style: TextStyle(color: AppColors.redIconGradient1,fontSize: 18,letterSpacing: 0.6),
                        ),
                        onPressed: () {
                          _buildPopupDialog();
                        },
                      ),
                    ),
                  )

                ],
              ),
            ]),
      ),
    );
  }

}

