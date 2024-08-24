
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class VideoUploadController extends GetxController {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updatePostCount(String userId) async {
    try {
      final userDoc = await _firestore.collection('users').doc(userId).get();
      final currentCount = userDoc.data()?['postCount'] ?? 0;
      await _firestore.collection('users').doc(userId).update({
        'postCount': currentCount + 1,
      });
    } catch (error) {
      Get.snackbar('Update Failed', 'Failed to update post count: $error');
    }
  }

  Future<void> fetchUserPosts() async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      final userProfile = userDoc.data();
      if (userProfile != null) {
        final postIds = List<String>.from(userProfile['posts'] ?? []);
        userPosts.assignAll(postIds);
      }
    } catch (error) {
      Get.snackbar('Fetch Failed', 'Failed to fetch user posts: $error');
    }
  }

  var followersCount = 0.obs;
  var isFollowing = false.obs;
  var userPosts = <String>[].obs;


  void toggleFollow() {
    if (isFollowing.value) {
      followersCount.value--;
      isFollowing.value = false;
    } else {
      followersCount.value++;
      isFollowing.value = true;
    }
  }

  var isLoading = false.obs;
  var videoFilePath = ''.obs;
  var videoUrl = ''.obs;
  var videoUrls = <String>[].obs;
  var videoUsernames = <String>[].obs;
  var videoProfileImages = <String>[].obs;
  final ImagePicker _picker = ImagePicker();
  late VideoPlayerController _videoPlayerController;

  Future<Map<String, String>> getUserData(String userId) async {
    try {
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if (userDoc.exists) {
        final userData = userDoc.data()!;
        return {
          'name': userData['name'] ?? 'Unknown',
          'profileImageUrl': userData['profileImageUrl'] ?? '',
        };
      }
      return {'name': 'Unknown', 'profileImageUrl': ''};
    } catch (error) {
      Get.snackbar(
        'User Data Fetch Failed',
        'Failed to fetch user data: $error',
        snackPosition: SnackPosition.BOTTOM,
      );
      return {'name': 'Unknown', 'profileImageUrl': '',};
    }
  }

  Future<File?> pickVideo() async {
    try {
      final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
      if (pickedFile != null) {
        videoFilePath.value = pickedFile.path;
        return File(pickedFile.path);
      }
      return null;
    } catch (error) {
      Get.snackbar(
        'Video Selection Failed',
        'Failed to pick video: $error',
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
  }

  Future<void> uploadVideo(File videoFile, String userId) async {
    try {
      isLoading.value = true;
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.mp4';
      final storageRef = FirebaseStorage.instance.ref().child('videos').child(fileName);

      final uploadTask = storageRef.putFile(videoFile);
      await uploadTask;

      final downloadUrl = await storageRef.getDownloadURL();
      videoUrl.value = downloadUrl;

      final userData = await getUserData(userId);
      final username = userData['name'];
      final profileImageUrl = userData['profileImageUrl'];

      await FirebaseFirestore.instance.collection('videos').doc(fileName).set({
        'url': downloadUrl,
        'name': username,
        'profileImageUrl': profileImageUrl,
      });

      videoUrls.add(downloadUrl);
      videoUsernames.add(username ??"");
      videoProfileImages.add(profileImageUrl ??"");

      Get.snackbar(
        'Upload Success',
        'Video uploaded successfully!',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (error) {
      Get.snackbar(
        'Upload Failed',
        'Failed to upload video: $error',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchVideoUrls() async {
    try {
      isLoading.value = true;
      final storageRef = FirebaseStorage.instance.ref().child('videos');
      final result = await storageRef.listAll();
      videoUrls.clear();
      videoUsernames.clear();
      videoProfileImages.clear();

      for (var item in result.items) {
        final url = await item.getDownloadURL();
        videoUrls.add(url);
        final videoDoc = await FirebaseFirestore.instance.collection('videos').doc(item.name).get();
        if (videoDoc.exists) {
          final videoData = videoDoc.data()!;
          final username = videoData['name'] ?? 'Unknown';
          final profileImageUrl = videoData['profileImageUrl'] ?? '';
          videoUsernames.add(username);
          videoProfileImages.add(profileImageUrl);
        } else {
          videoUsernames.add('Unknown');
          videoProfileImages.add('');
        }
      }
    } catch (error) {
      Get.snackbar(
        'Fetch Failed',
        'Failed to fetch video URLs: $error',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> initializeVideoPlayer(String filePath) async {
    try {
      _videoPlayerController = VideoPlayerController.file(File(filePath));
      await _videoPlayerController.initialize();
      _videoPlayerController.play();
    } catch (error) {
      Get.snackbar(
        'Player Initialization Failed',
        'Failed to initialize video player: $error',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onClose() {
    _videoPlayerController.dispose();
    super.onClose();
  }
}