import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:histreet/utilities/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () async {
      String? userId =
          await getUserId(); // Replace 'userId' with your actual key

      if (userId != null) {
        Get.offAllNamed('/home'); // Replace with your home screen route
      } else {
        Get.offAllNamed('/login'); // Replace with your login screen route
      }
    });
    return const SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image(
          image: AssetImage('assets/images/splash.jpg'),
        ),
      ),
    ));
  }
}
