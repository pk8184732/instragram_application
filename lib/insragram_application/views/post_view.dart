import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instragram_application/insragram_application/views/reels/reels_screen.dart';
import 'package:video_player/video_player.dart';

import '../models/post_model.dart';

class PostControllerScreen extends GetxController {
  Rx<File?> video = Rx<File?>(null);

  Rxn<PostModel> currentUser = Rxn<PostModel>();

  final ImagePicker picker = ImagePicker();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController captionController = TextEditingController();

  Future<void> pickVideo() async {
    try {
      final pickedFile = await picker.pickVideo(source: ImageSource.gallery);

      if (pickedFile != null) {
        video.value = File(pickedFile.path);
      }

      else {
        Get.snackbar('No Video Selected', 'Please select a video.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick video: $e');
    }
  }

  Future<void> uploadPost(Function(File) onPost) async {
    if (video.value == null || titleController.text.isEmpty || captionController.text.isEmpty) {
      Get.snackbar('Incomplete Data', 'Please select a video and fill in title/caption.');
      return;
    }

    try {
      // Upload video to Firebase Storage
      String fileName = 'videos/${DateTime.now().millisecondsSinceEpoch}.mp4';
      Reference ref = FirebaseStorage.instance.ref().child(fileName);
      await ref.putFile(video.value!);

      // Get the download URL
      String videoUrl = await ref.getDownloadURL();

      // Save post metadata in Firestore
      await FirebaseFirestore.instance.collection('posts').add({
        'userId': 'currentUserId', // Replace with dynamic user ID
        'mediaUrl': videoUrl,
        'title': titleController.text,
        'caption': captionController.text,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Call the onPost function to update UI in ProfileScreen
      onPost(video.value!);

      // Clear the fields
      video.value = null;
      titleController.clear();
      captionController.clear();

      Get.snackbar('Success', 'Post uploaded successfully!');
      Get.back(); // Go back to ProfileScreen

    } catch (e) {
      Get.snackbar('Error', 'Failed to upload post: $e');
    }
  }
}



class PostView extends StatelessWidget {
  final Function(File) onPost;

  const PostView({required this.onPost, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PostControllerScreen()); // Initialize and bind the controller

    return Scaffold(
      appBar: AppBar(
        title: Text("New Post"),
        actions: [
          IconButton(
            icon: Icon(Icons.upload),
            onPressed: () => controller.uploadPost(onPost),
          ),
        ],
      ),
      body: ListView(
        children: [
          GestureDetector(
            onTap: controller.pickVideo,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(() => Container(
                height: 500,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: controller.video.value != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: VideoPlayerWidget(videoUrl: controller.video.value!.path), // Display video thumbnail
                  ),
                )
                    : Center(
                  child: Icon(
                    Icons.video_library,
                    color: Colors.grey[800],
                    size: 50,
                  ),
                ),
              )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextField(
              controller: controller.titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: "Title",
                prefixIcon: Icon(Icons.title),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextField(
              controller: controller.captionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: "Caption",
                prefixIcon: Icon(Icons.closed_caption),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  VideoPlayerWidget({required this.videoUrl});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isInitialized
        ? AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(_controller),
    )
        : Center(
      child: SpinKitFadingCircle(
        color: Colors.grey,
        size: 50.0,
      ),
    );
  }
}
