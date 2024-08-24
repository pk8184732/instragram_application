// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:get/get.dart';
// import 'insragram_application/controllers/instra_controller/instra_controller_screen.dart';
// import 'insragram_application/views/splash/splash_screen.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//
//   Get.put(InstraControllerScreen());
//
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Firebase Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: SplashScreenInstra(),
//     );
//   }
// }









import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'firebase_options.dart';
import 'insragram_application/controllers/instra_controller/instra_class/auth_servies.dart';
import 'insragram_application/controllers/instra_controller/video_upload_controller.dart';
import 'insragram_application/views/login/instra_login/login_screen.dart';
import 'insragram_application/views/register/instra_register/instra_register_screen.dart';
import 'insragram_application/views/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(AuthService());
  Get.lazyPut(()=>VideoUploadController());
  Get.put(()=>VideoUploadController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        getPages: [
        GetPage(name: '/InstaRegisterScreen', page: () => InstaRegisterScreen()),
    GetPage(name: '/InstaCloneLogin', page: () => InstaCloneLogin()),
    ],);
  }
}
