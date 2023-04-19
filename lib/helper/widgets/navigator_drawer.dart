import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../local/shared_preference_keys.dart';

class NavDrawer extends StatefulWidget {

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  var profile=''.obs;
  @override
  void initState() {
    // getProfile();
    // TODO: implement initState
    super.initState();
  }
  // getProfile()async {
  //   var prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     profile.value = prefs.getString(SPKeys.USERPROFILE)!;
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded,
              color: Colors.black),
          onPressed: () {
           Navigator.of(context).pop();
          },
        ),
        title: const Text('My Customers'),
        backgroundColor: Colors.transparent,
        toolbarHeight: Get.height * 0.07,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              color: Colors.transparent),
        ),
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              child: Image.network(profile.value),
            ),
            // DrawerHeader(
            //   child: Text(
            //     'Side menu',
            //     style: TextStyle(color: Colors.black, fontSize: 25),
            //   ),
            // ),
            ListTile(
              leading: Icon(Icons.input),
              title: Text('Welcome'),
              onTap: () => {},
            ),
            ListTile(
              leading: Icon(Icons.verified_user),
              title: Text('Profile'),
              onTap: () => {Navigator.of(context).pop()},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () => {Navigator.of(context).pop()},
            ),
            ListTile(
              leading: Icon(Icons.border_color),
              title: Text('Feedback'),
              onTap: () => {Navigator.of(context).pop()},
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () => {Navigator.of(context).pop()},
            ),
          ],
        ),
      ),
    );
  }
}