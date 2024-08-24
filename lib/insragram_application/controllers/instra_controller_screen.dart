// import 'dart:io';
// import 'package:get/get.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class InstraControllerScreen extends GetxController {
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   Rxn<User?> currentUser = Rxn<User?>(); // Updated to Rxn<User?>
//   Rx<Map<String, dynamic>?> userProfile = Rx<Map<String, dynamic>?>(null);
//   RxList<Map<String, dynamic>> userPosts = <Map<String, dynamic>>[].obs;
//   RxList<String> followingUsers = <String>[].obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     currentUser.bindStream(_firebaseAuth.authStateChanges());
//     ever(currentUser, (_) {
//       _loadUserProfile();
//       fetchUserPosts();
//       fetchFollowingUsers();
//     });
//   }
//
//   Future<void> signup(String email, String password) async {
//     try {
//       UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       User? user = userCredential.user;
//
//       if (user != null) {
//         await _firestore.collection('users').doc(user.uid).set({
//           'email': email,
//           'name': '',
//           'profileImage': '',
//           'postsCount': 0,
//           'followersCount': 0,
//           'followingCount': 0,
//         });
//
//         await _updateAuthState(true);
//         await _loadUserProfile();
//       }
//     } catch (e) {
//       throw Exception('Failed to sign up: $e');
//     }
//   }
//
//   Future<bool> login(String email, String password) async {
//     try {
//       await _firebaseAuth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       await _updateAuthState(true);
//       await _loadUserProfile();
//       return true;
//     } catch (e) {
//       throw Exception('Failed to log in: $e');
//     }
//   }
//
//   Future<void> signOut() async {
//     await _firebaseAuth.signOut();
//     await _updateAuthState(false);
//     userProfile.value = null;
//     userPosts.clear();
//     followingUsers.clear();
//   }
//
//   Future<void> _updateAuthState(bool isAuthenticated) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isAuthenticated', isAuthenticated);
//   }
//
//   Future<void> _loadUserProfile() async {
//     if (currentUser.value != null) {
//       userProfile.value = await getUserProfile(currentUser.value!.uid);
//     }
//   }
//
//   Future<Map<String, dynamic>> getUserProfile(String uid) async {
//     try {
//       DocumentSnapshot userDoc = await _firestore.collection('users').doc(uid).get();
//       if (userDoc.exists) {
//         return userDoc.data() as Map<String, dynamic>;
//       } else {
//         throw Exception('User profile not found');
//       }
//     } catch (e) {
//       throw Exception('Failed to fetch user profile: $e');
//     }
//   }
//
//   Future<void> fetchUserPosts() async {
//     if (currentUser.value != null) {
//       try {
//         final postsSnapshot = await _firestore
//             .collection('posts')
//             .where('userId', isEqualTo: currentUser.value!.uid)
//             .orderBy('timestamp', descending: true)
//             .get();
//
//         userPosts.assignAll(postsSnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList());
//       } catch (e) {
//         print('Failed to fetch user posts: $e');
//       }
//     }
//   }
//
//   Future<void> updateUserProfile(String name, String phoneNumber, File? selectedImage) async {
//     if (currentUser.value != null) {
//       Map<String, dynamic> updates = {
//         'name': name,
//         'phoneNumber': phoneNumber,
//       };
//
//       if (selectedImage != null) {
//         try {
//           String imageUrl = await _uploadImage(selectedImage);
//           updates['profileImage'] = imageUrl;
//         } catch (e) {
//           print('Error uploading image: $e');
//         }
//       }
//
//       await _firestore.collection('users').doc(currentUser.value!.uid).update(updates);
//       await _loadUserProfile();
//     }
//   }
//
//   Future<void> uploadVideo(File videoFile) async {
//     try {
//       final storageRef = FirebaseStorage.instance.ref().child('videos/${DateTime.now().millisecondsSinceEpoch}.mp4');
//       UploadTask uploadTask = storageRef.putFile(videoFile);
//
//       uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
//         print('Progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100}%');
//       });
//
//       await uploadTask.whenComplete(() {
//         print('Upload complete!');
//       });
//
//       String downloadURL = await storageRef.getDownloadURL();
//       print('Download URL: $downloadURL');
//     } catch (e) {
//       print('Error uploading video: $e');
//     }
//   }
//
//   Future<String> _uploadImage(File imageFile) async {
//     try {
//       final storageRef = FirebaseStorage.instance.ref().child('profile_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
//       UploadTask uploadTask = storageRef.putFile(imageFile);
//
//       await uploadTask.whenComplete(() {
//         print('Image upload complete!');
//       });
//
//       String downloadURL = await storageRef.getDownloadURL();
//       return downloadURL;
//     } catch (e) {
//       throw Exception('Error uploading image: $e');
//     }
//   }
//
//   Future<void> fetchFollowingUsers() async {
//     if (currentUser.value != null) {
//       try {
//         final followingSnapshot = await _firestore
//             .collection('users')
//             .doc(currentUser.value!.uid)
//             .collection('following')
//             .get();
//
//         followingUsers.assignAll(followingSnapshot.docs.map((doc) => doc.id).toList());
//       } catch (e) {
//         print('Failed to fetch following users: $e');
//       }
//     }
//   }
//
//   bool isFollowing(String userId) {
//     return followingUsers.contains(userId);
//   }
//
//   Future<void> toggleFollow(String userId, bool follow) async {
//     if (currentUser.value != null) {
//       try {
//         final currentUserDoc = _firestore.collection('users').doc(currentUser.value!.uid);
//         final targetUserDoc = _firestore.collection('users').doc(userId);
//
//         if (follow) {
//           await currentUserDoc.collection('following').doc(userId).set({});
//           await targetUserDoc.collection('followers').doc(currentUser.value!.uid).set({});
//           followingUsers.add(userId);
//         } else {
//           await currentUserDoc.collection('following').doc(userId).delete();
//           await targetUserDoc.collection('followers').doc(currentUser.value!.uid).delete();
//           followingUsers.remove(userId);
//         }
//       } catch (e) {
//         print('Failed to toggle follow: $e');
//       }
//     }
//   }
// }
