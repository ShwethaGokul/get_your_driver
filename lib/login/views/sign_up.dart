import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../controllers/sign_up_controller.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  SignUpController _signUpController = Get.put(SignUpController());
  final _formKeyUsername = GlobalKey<FormState>();
  final _formKeyMobileNumber = GlobalKey<FormState>();
  final _formKeyEmail = GlobalKey<FormState>();
  final _formKeyPassword = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.grey[200],
            child: Image.asset(
              "assets/images/png/backgroun_image.png",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),),
            Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Card(
                      semanticContainer: false,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      elevation: 20,
                      color: Colors.white,
                      child: Container(
                          padding: EdgeInsets.all(20.0),
                          color: Colors.transparent,
                          child: SingleChildScrollView(
                            reverse: true,
                            child:   Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Sign Up",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      ?.copyWith(
                                      fontSize: 25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Text("Sign Up into your account",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      ?.copyWith(
                                      fontSize: 16,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Form(
                                      key: _formKeyUsername,
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value!.isNotEmpty) {
                                            return null;
                                          } else {
                                            return 'Enter Username';
                                          }
                                        },
                                        decoration: InputDecoration(
                                          isDense: true,
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                            suffixIcon: Icon(Icons.person,color: Color.fromRGBO(125,1,120,1),),
                                            label: const Text('Username'),
                                            focusColor: Color.fromRGBO(125,1,120,1)
                                        ),
                                        controller: _signUpController.usernameTextEditingController,
                                      ),
                                    ),

                                    SizedBox(height: 18,),
                                    Form(
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
                                        controller: _signUpController.phoneTextEditingController,
                                      ),
                                    ),

                                    SizedBox(height: 18,),
                                    Form(
                                      key: _formKeyEmail,
                                      child: TextFormField(

                                        validator: (value) {
                                          if (value!.isNotEmpty) {
                                            return null;
                                          } else {
                                            return 'Enter Email Address';
                                          }
                                        },
                                        decoration: InputDecoration(
                                            isDense: true,
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                            suffixIcon: Icon(Icons.email,color: Color.fromRGBO(125,1,120,1),),
                                            label: const Text('Email'),
                                            focusColor: Color.fromRGBO(125,1,120,1)
                                        ),
                                        controller: _signUpController.emailTextEditingController,
                                      ),
                                    ),
                                    SizedBox(height: 18,),

                                    Form(
                                      key: _formKeyPassword,
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value!.isNotEmpty) {
                                            return null;
                                          } else {
                                            return 'Enter Password';
                                          }
                                        },
                                        decoration: InputDecoration(
                                            isDense: true,
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                            suffixIcon: IconButton(
                                                onPressed: (){
                                                  setState(() {
                                                    _signUpController.viewPassword = !_signUpController.viewPassword;
                                                  });
                                                },
                                                icon: Icon(_signUpController.viewPassword ? Icons.visibility : Icons.visibility_off,color: Color.fromRGBO(125,1,120,1),)),
                                            label: const Text('Password'),
                                            focusColor: Color.fromRGBO(125,1,120,1)
                                        ),
                                        controller: _signUpController.passwordTextEditingController,
                                        // fieldLabel: 'Password',
                                        // padding: EdgeInsets.only(left: 8.0, right: 8.0),
                                        obscureText: _signUpController.viewPassword,
                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                   Obx(()=> SizedBox(
                                      width: double.infinity,
                                      height: 50.0,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(5.0),
                                                  side: BorderSide(color: Color.fromRGBO(125,1,120,1))
                                              )
                                          ),
                                          elevation: MaterialStateProperty.all(3.0),
                                          backgroundColor:
                                          MaterialStateProperty.all(Color.fromRGBO(125,1,120,1)),
                                          foregroundColor: MaterialStateProperty.all(Colors.white),
                                        ),
                                        child:  _signUpController.isLoading.value
                                            ? Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        )
                                            :  Text(
                                          'Sign Up',
                                          style: TextStyle(color: Colors.white,fontSize: 18,letterSpacing: 0.6),
                                        ),
                                        onPressed: () {
                                        },
                                      ),
                                    )),
                                    SizedBox(height: 20,),
                                    Center(
                                      child: Text(
                                        "Or login with social media",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            ?.copyWith(
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap:(){
                                            // signInWithGoogle();
                                          },
                                          child: Image.asset('assets/images/png/google.png',width: 30),
                                        ),
                                        SizedBox(width: 30),
                                        InkWell(
                                            onTap:(){
                                              // signInWithFacebook();
                                            },
                                            child: Image.asset('assets/images/png/facebook.png',width: 37)),
                                        // SizedBox(width: 30),
                                        // InkWell(
                                        //     onTap:(){
                                        //
                                        //     },
                                        //     child: Image.asset('assets/twitter.png',width: 42)),
                                      ],),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Already have an Account ?",
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          ?.copyWith(
                                        color: Colors.black,
                                      ),
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
                                          "Sign In",
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
                          )),
                    ),
                  ),
                )
      ],
    );
  }
}
