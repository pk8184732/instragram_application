import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Assuming LoginControllerScreen is already implemented and used for state management
class LoginControllerScreen extends GetxController {
  var name = ''.obs;
  var email = ''.obs;
  var profileImageUrl = ''.obs; // Observable to hold the user's profile image URL

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  // Fetch the user's data from Firestore
  Future<void> loadUserData() async {
    try {
      String userId = _auth.currentUser?.uid ?? '';
      if (userId.isNotEmpty) {
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(userId).get();
        name.value = userDoc['name'];
        email.value = userDoc['email'];
        profileImageUrl.value = userDoc['profileImageUrl'] ?? ''; // Ensure there's a default value
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load user data: ${e.toString()}');
    }
  }

  // Logout function
  Future<void> logout() async {
    await _auth.signOut();
    Get.offAll(() => LoginScreen()); // Navigate to login screen after logging out
  }
}

// ProfileScreen widget
class ProfileScreen extends StatelessWidget {
  final LoginControllerScreen controller = Get.find<LoginControllerScreen>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: controller.logout, // Logout action
          ),
        ],
      ),
      body: Obx(() {
        if (controller.name.value.isEmpty) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: controller.profileImageUrl.value.isNotEmpty
                      ? NetworkImage(controller.profileImageUrl.value)
                      : AssetImage('assets/default_profile.png') as ImageProvider, // Default profile image
                ),
                SizedBox(height: 16),
                Text(
                  controller.name.value,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  controller.email.value,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Add any additional actions, such as editing profile
                  },
                  child: Text('Edit Profile'),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}

// LoginScreen (a placeholder for the screen you navigate to after logout)
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: Text('Login Screen Placeholder'),
      ),
    );
  }
}
