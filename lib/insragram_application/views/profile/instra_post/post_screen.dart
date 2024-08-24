// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../controllers/instra_controller/instra_controller_screen.dart';
// import '../../reels/reels_screen.dart';
// import 'package:video_player/video_player.dart'; // Ensure this is imported if using video_player
//
// class PostScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final InstraControllerScreen controller = Get.put(InstraControllerScreen());
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("New Post"),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.upload),
//             onPressed: controller.uploadPost,
//           ),
//         ],
//       ),
//       body: Obx(() {
//         return ListView(
//           children: [
//             GestureDetector(
//               onTap: controller.pickVideo,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   height: 500,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[300],
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(color: Colors.grey),
//                   ),
//                   child: controller.video.value != null
//                       ? ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: AspectRatio(
//                       aspectRatio: 16 / 9,
//                       child: VideoPlayerWidget(videoUrl: controller.video.value!.path),
//                     ),
//                   )
//                       : Center(
//                     child: Icon(
//                       Icons.video_library,
//                       color: Colors.grey[800],
//                       size: 50,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(18.0),
//               child: TextField(
//                 controller: controller.titleController,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   hintText: "Title",
//                   prefixIcon: Icon(Icons.title),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(18.0),
//               child: TextField(
//                 controller: controller.captionController,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   hintText: "Caption",
//                   prefixIcon: Icon(Icons.closed_caption),
//                 ),
//               ),
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }
//
// // VideoPlayerWidget must be defined properly elsewhere in your code.










import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/instra_controller/video_upload_controller.dart';
import '../../reels/reels_screen.dart';

class VideoUploadScreen extends StatelessWidget {
  late final String userId;
  VideoUploadScreen({required this.userId});
  final VideoUploadController _controller = Get.put(VideoUploadController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Upload and Play Video'),
          centerTitle: true,
        ),
        body: Obx(() {
          if (_controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _controller.videoFilePath.value.isNotEmpty
                      ? Column(
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                        ),
                        child: Center(
                          child: Text(
                            'Video Selected',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  )
                      : Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                    ),
                    child: Center(
                      child: Text(
                        'No Video Selected',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final videoFile = await _controller.pickVideo();
                      if (videoFile != null) {
                        _controller.videoFilePath.value = videoFile.path;
                        await _controller.initializeVideoPlayer(videoFile.path);
                        _controller.videoUrl.value = videoFile.path;
                      } else {
                        Get.snackbar(
                          'No Video Selected',
                          'Please select a video to play.',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                    },
                    icon: Icon(Icons.video_library),
                    label: Text('Pick Video'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () async {
                      if (_controller.videoFilePath.value.isNotEmpty) {
                        final videoFile = File(_controller.videoFilePath.value);
                        await _controller.uploadVideo(videoFile, userId);
                        if (_controller.videoUrls.isNotEmpty) {
                          Get.to(() => ReelsScreen());
                          Get.snackbar(
                            'Success',
                            'Video uploaded and ready to play!',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      } else {
                        Get.snackbar(
                          'No Video Selected',
                          'Please select a video to upload.',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                    },
                    icon: Icon(Icons.cloud_upload),
                    label: Text('Upload Video'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        }),
    );
  }
}
