// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// import '../../controllers/login_controller_screen.dart';
// import '../login/instra_login/login_screen.dart';
// import '../profile/profile_screen.dart';
//
// class SplashScreenInstra extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Initialize the controller only once
//     final AuthControllerScreen controller = Get.put(AuthControllerScreen());
//
//     // Check authentication status and navigate accordingly
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _checkAuthenticationStatus();
//     });
//
//     return Scaffold(
//       body: Center(
//         child: Text(
//           'KrisCent',
//           style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.red),
//         ),
//       ),
//     );
//   }
//
//   void _checkAuthenticationStatus() async {
//     // Check if the user is logged in
//     User? user = FirebaseAuth.instance.currentUser;
//
//     if (user != null) {
//       // User is logged in, navigate to InstraScreen
//       Get.offAll(() => HomeScreen());
//     } else {
//       // User is not logged in, navigate to LoginScreen
//       Get.offAll(() => LoginScreen());
//     }
//   }
// }






import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../login/instra/instra_screen.dart';
import '../login/instra_login/login_screen.dart';





class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      Duration(seconds: 2),
          () {
        checkUser();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CupertinoActivityIndicator(),
    );
  }

  void checkUser() async {
    bool isLogin = FirebaseAuth.instance.currentUser?.uid != null;
    if (isLogin) {
      Get.offAll(() => InstaHomeScreen());
    } else {
      Get.offAll(() => InstaCloneLogin());
    }
    }
}
