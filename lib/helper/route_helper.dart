
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_your_driver/screens/cab_booking/screens/cab_booking_screen.dart';

class MRouter {
  static const String splashRoute = 'SplashWidget';

  static const String homeScreen = 'HomeWidget';
  static const String userLogin = 'UserLogin';
  static const String introScreen = 'IntroductionScreens';
  static const String login = '/login';

  static const String web = '/web';
  static const String no_routes = '';
  static const String news_section = "NewsSection";
  static const String events_section = "EventsSection";
  static const String chooseGender = "chooseGender";
  static const String forgetPassword = 'ForgetPassword';
  static const String otpVerify = 'OTPVerify';
  static const String signUpPage = 'SignUpPage';
  static const String signUpVerifyPage = 'SignUpVerifyPage';
  static const String sellAndEarn = 'SellAndEarn';
  static const String sellAndEarnDetails = 'SellAndEarnDetails';
  static const String addCreditCardDetails = 'addCreditCardDetails';
  static const String notificationPage = 'notificationPage';
  static const String homeMangerPage = 'homeMangerPage';
  static const String shareCustomerDetailsPage = 'shareCustomerDetailsPage';
  static const String customersScreen = 'customersScreen';
  static const String cabBookingScreen = 'cabBookingScreen';



  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case splashRoute:
        // return CupertinoPageRoute(builder: (_) => SplashScreen());
      // case homeScreen:
      //   return CupertinoPageRoute(builder: (_) => HomeScreen());
      //
      // case sellAndEarn:
      //   return CupertinoPageRoute(builder: (_) => SellAndEarn());
      //
      // case signUpVerifyPage:
      //   return CupertinoPageRoute(builder: (_) => SignUpVerifyPage());
      //
      // case sellAndEarnDetails:
      //   return CupertinoPageRoute(builder: (_) => SellAndEarnDetails());
      // case addCreditCardDetails:
      //   return CupertinoPageRoute(builder: (_) => AddCreditCardDetails());
      // case userLogin:
      //   return CupertinoPageRoute(builder: (_) => LoginPage());
      // case forgetPassword:
      //   return CupertinoPageRoute(builder: (_) => ForgetPassword());
      // case otpVerify:
      //   return CupertinoPageRoute(builder: (_) => OTPVerify());
      // case signUpPage:
      //   return CupertinoPageRoute(builder: (_) => SignUpPage());
      // case signUpVerifyPage:
      //   return CupertinoPageRoute(builder: (_) => SignUpVerifyPage());
      // case notificationPage:
      //   return CupertinoPageRoute(builder: (_) => NotificationPage());
      // case homeMangerPage:
      //   return CupertinoPageRoute(builder: (_) => HomeManager());
      // case sideDrawer:
      //   return CupertinoPageRoute(builder: (_) => NavDrawer());
      case cabBookingScreen:
        return CupertinoPageRoute(builder: (_) => CabBookingScreen());

      default:
        return CupertinoPageRoute(builder: (_) => NoRouteScreen(settings.name));
    }
  }

  static Future<dynamic> pushNamedAndRemoveUntil(
      BuildContext context, String named) {
    return Navigator.of(context)
        .pushNamedAndRemoveUntil(named, (Route<dynamic> route) => false);
  }

  static Future<dynamic> pushReplacementNamed(
      BuildContext context, String route) {
    return Navigator.of(context).pushReplacementNamed(route);
  }

  static pop(BuildContext context) {
    return Navigator.pop(context);
  }
}

class NoRouteScreen extends StatelessWidget {
  final String? screenName;

  NoRouteScreen(this.screenName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(child: Text('${'no_route_defined'} "$screenName"')),
    );
  }
}
