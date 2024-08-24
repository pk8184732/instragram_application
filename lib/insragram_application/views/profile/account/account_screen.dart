//
//
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart'; // Assuming you're using Firebase for authentication
//
//
// class AccountSettingsController extends GetxController {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   Future<void> signOut() async {
//     try {
//       await _auth.signOut(); // Sign out from Firebase
//       Get.offAllNamed('/login'); // Navigate to login screen and remove all previous routes
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to sign out: $e',
//           snackPosition: SnackPosition.BOTTOM);
//     }
//   }
// }
//
//
// class AccountScreen extends  StatelessWidget {
// final AccountSettingsController controller = Get.put(AccountSettingsController());
//
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: Text('Account Settings'),
//     ),
//     body: Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Divider(color: Colors.grey),
//           ListTile(
//             title: Text('Logout'),
//             leading: Icon(Icons.logout),
//             onTap: controller.signOut,
//           ),
//           Divider(color: Colors.grey),
//         ],
//       ),
//     ),
//   );
// }
// }





import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/instra_controller/instra_class/auth_servies.dart';
import '../../login/instra_login/login_screen.dart';



class LogoutScreen extends StatelessWidget {
  final AuthService _authService = Get.find();

  Future<void> _showLogoutConfirmation(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: Text('Logout'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );
    if (result == true) {
      await _authService.logout();
      Get.offAll(InstaCloneLogin());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: TextButton(onPressed: () {
            Navigator.pop(context);
          }, child: Text("cancel", style: TextStyle(color: Colors.white,fontSize: 20,),)),
          backgroundColor:
          Color(0xFF19317E),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.logout,
                    size: 60,
                    color: Color(0xFF19317E),
                  ),
                  SizedBox(height: 20),
                  const Text(
                    'You are about to logout..',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color:Color(0xFF19317E),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _showLogoutConfirmation(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF19317E),
                      padding: EdgeInsets.symmetric(horizontal: 74, vertical: 12),
                      textStyle: TextStyle(fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    child: Text('Logout', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
            ),
        );
    }
}

