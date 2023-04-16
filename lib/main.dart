// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_your_driver/screens/cab_booking/controller/cab_booking_controller.dart';
import 'package:get_your_driver/screens/cab_booking/screens/cab_booking_screen.dart';
import 'package:get_your_driver/screens/splash_screen/splash_ui.dart';
import 'package:get_your_driver/services/location_service.dart';
import 'package:permission_handler/permission_handler.dart';

void main()async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // FirebaseMessaging messaging = FirebaseMessaging.instance;
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
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
   MyHomePage({super.key});
  final isSelected = false.obs;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // FirebaseMessaging _firebaseMessaging;

  var sellEarnList = [
    "Cab Booking",
  ];
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

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
                          widget.isSelected.value = true;
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CabBookingScreen()));
                        },
                      child: Column(
                        children: [
                       Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(.4),
                                borderRadius: BorderRadius.circular(10)),
                            height: 90,
                            width: 100,
                            child: Center(
                              child: SvgPicture.asset(
                                "assets/svg_images/driver.svg",
                                width: 50,
                                height: 50,
                                color: Colors.grey,
                              )
                            ),
                          ),
                        ],
                      ),
                    );
                  })),
      ),
    );
  }

  @override
  void initState() async{
    // var data = await readAndroidBuildData(await deviceInfo.deviceInfo);

    // print('call ini');
    // final androiiNfor = await DeviceInfoPlugin().androidInfo;
    // final androiVersion = androiiNfor.androidId;    // FirebaseMessaging.instance.getToken().then((newToken){
    //   print('FCM Token: ${androiVersion}');
    // // });
    // LocationServices().determinePosition();
    // getFcmToken();
    super.initState();
  }
  getFcmToken()async{
    // String? token = await FirebaseMessaging.instance.getToken();
    // print('fcm token: $token');
  }
  Map<String, dynamic> readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId,
      'systemFeatures': build.systemFeatures,
    };
  }
}
