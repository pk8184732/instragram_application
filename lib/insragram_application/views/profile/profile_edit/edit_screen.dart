// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class ProfileController extends GetxController {
//   final name = ''.obs;
//   final phoneNumber = ''.obs;
//   var profileImage = Rxn<File>();
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchUserProfile();
//   }
//
//   Future<void> fetchUserProfile() async {
//     final user = _auth.currentUser;
//
//     if (user == null) {
//       Get.snackbar('Error', 'User is not signed in');
//       return;
//     }
//
//     try {
//       final userDoc = await _firestore.collection('users').doc(user.uid).get();
//
//       if (userDoc.exists) {
//         final data = userDoc.data()!;
//         name.value = data['name'] ?? '';
//         phoneNumber.value = data['phoneNumber'] ?? '';
//         // Implement logic to load profile image from URL if stored
//         // Example: profileImageUrl.value = data['profileImageUrl'];
//       } else {
//         Get.snackbar('Error', 'User profile not found');
//       }
//     } catch (e) {
//       print('Error fetching user profile: $e');
//       Get.snackbar('Error', 'Failed to fetch user profile');
//     }
//   }
//
//   Future<void> pickImage() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: ImageSource.gallery);
//
//     if (image != null) {
//       profileImage.value = File(image.path);
//     }
//   }
//
//   Future<void> saveProfile() async {
//     final user = _auth.currentUser;
//
//     if (user == null) {
//       Get.snackbar('Error', 'User is not signed in');
//       return;
//     }
//
//     try {
//       Map<String, dynamic> updateData = {
//         'name': name.value,
//         'phoneNumber': phoneNumber.value,
//       };
//
//       // Logic to upload profile image to Firebase Storage and get the URL
//       // Example: if (profileImage.value != null) { updateData['profileImageUrl'] = uploadedImageUrl; }
//
//       await _firestore.collection('users').doc(user.uid).update(updateData);
//
//       Get.snackbar('Success', 'Profile updated successfully!');
//       Get.back(); // Navigate back to the previous screen
//     } catch (e) {
//       print('Error updating user profile: $e');
//       Get.snackbar('Error', 'Failed to update user profile');
//     }
//   }
// }
//
// class EditScreen extends StatelessWidget {
//   final ProfileController _controller = Get.put(ProfileController());
//
//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController nameController = TextEditingController(text: _controller.name.value);
//     final TextEditingController phoneController = TextEditingController(text: _controller.phoneNumber.value);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Profile'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Obx(() {
//           final profileImageFile = _controller.profileImage.value;
//           final profileImageProvider = profileImageFile != null
//               ? FileImage(profileImageFile)
//               : AssetImage('assets/default_profile.png') as ImageProvider;
//
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: GestureDetector(
//                   onTap: () => _controller.pickImage(),
//                   child: Container(
//                     width: 100,
//                     height: 100,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(color: Colors.blue, width: 2.0),
//                     ),
//                     child: CircleAvatar(
//                       radius: 50,
//                       backgroundColor: Colors.transparent,
//                       backgroundImage: profileImageProvider,
//                       child: profileImageFile == null
//                           ? Icon(Icons.add_a_photo, size: 30, color: Colors.blue)
//                           : null,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               TextField(
//                 onChanged: (value) => _controller.name.value = value,
//                 decoration: InputDecoration(labelText: 'Name'),
//                 controller: nameController,
//               ),
//               SizedBox(height: 20),
//               TextField(
//                 onChanged: (value) => _controller.phoneNumber.value = value,
//                 decoration: InputDecoration(labelText: 'Phone Number'),
//                 keyboardType: TextInputType.phone,
//                 controller: phoneController,
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   _controller.saveProfile();
//                 },
//                 child: Text('Save'),
//               ),
//             ],
//           );
//         }),
//       ),
//     );
//   }
// }











import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controllers/instra_controller/instra_class/auth_servies.dart';
import '../../login/instra/instra_screen.dart';

class EditProfileScreen extends StatelessWidget {
  final AuthService profileController = Get.find<AuthService>();
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Profile'),
          actions: [
            Obx(() => IconButton(
              icon: Icon(Icons.save),
              onPressed: profileController.isLoading.value
                  ? null
                  : () async {
                // Update user profile and navigate back
                try {
                  await profileController.updateUserProfile(
                    name: nameController.text.isEmpty
                        ? profileController.name.value
                        : nameController.text,
                    profileImageUrl: profileController.profileImageUrl.value,
                  );
                  Get.back();
                } catch (e) {
                  Get.snackbar('Error', 'Failed to update profile');
                }
              },
            )),
          ],
        ),
        body: FutureBuilder<void>(
            future: profileController.loadUserProfile(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error loading profile data'));
              } else {
                nameController.text = profileController.name.value;

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: GestureDetector(
                          onTap: () async {
                            final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                            if (image != null) {
                              try {
                                String newImageUrl = await profileController.uploadProfileImage(image);

                                await profileController.updateUserProfile(
                                  name: nameController.text.isEmpty
                                      ? profileController.name.value
                                      : nameController.text,
                                  profileImageUrl: newImageUrl,
                                );
                                profileController.profileImageUrl.value = newImageUrl;
                              } catch (e) {
                                Get.snackbar('Error', 'Failed to update profile image');
                              }
                            }
                          },
                          child: Obx(() {
                            return Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage: profileController.profileImageUrl.value.isNotEmpty
                                      ? NetworkImage(profileController.profileImageUrl.value)
                                      : AssetImage('assets/default_profile.png') as ImageProvider,
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Colors.black54,
                                    child: Icon(Icons.edit, color: Colors.white, size: 16),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: nameController,
                        onChanged: (value) => profileController.name.value = value,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 20),
                      Obx(() => ElevatedButton(
                        onPressed: profileController.isLoading.value ? null : () async {
                          try {
                            await profileController.updateUserProfile(
                              name: nameController.text.isEmpty
                                  ? profileController.name.value
                                  : nameController.text,
                              profileImageUrl: profileController.profileImageUrl.value,
                            );
                            Get.back(result: ProfileScreen()); // Navigate back to the previous screen (ProfileScreen)
                          } catch (e) {
                            Get.snackbar('Error', 'Failed to update profile');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          textStyle: TextStyle(fontSize: 16),
                        ),
                        child: profileController.isLoading.value
                            ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(color: Colors.white),
                        )
                            : Text('Save Changes'),
                      )),
                    ],
                  ),
                );
              }
            },
            ),
        );
    }
}
