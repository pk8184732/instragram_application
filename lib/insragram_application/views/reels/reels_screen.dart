// //
// //
// //
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:video_player/video_player.dart';
// // import 'package:visibility_detector/visibility_detector.dart';
// //
// // import '../../controllers/video_upload_controller.dart';
// //
// // class ReelsScreen extends StatefulWidget {
// //   @override
// //   _ReelsScreenState createState() => _ReelsScreenState();
// // }
// // class _ReelsScreenState extends State<ReelsScreen> {
// //   final VideoUploadController _videoController = Get.put(VideoUploadController());
// //   // final VideoUploadController _videoUploadController = Get.put(VideoUploadController());
// //
// //   late List<VideoPlayerController> _controllers;
// //   late List<bool> _initialized;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _controllers = []; // Initialize with an empty list
// //     _initialized = []; // Initialize with an empty list
// //     _initializeVideos();
// //   }
// //
// //   Future<void> _initializeVideos() async {
// //     try {
// //       await _videoController.fetchVideoUrls(); // Fetch video URLs and metadata
// //       setState(() {
// //         _controllers = _videoController.videoUrls
// //             .map((url) => VideoPlayerController.network(url))
// //             .toList();
// //         _initialized = List.filled(_controllers.length, false);
// //       });
// //       await _initializeVideoPlayers();
// //     } catch (error) {
// //       Get.snackbar('Initialization Error', 'Error fetching video URLs: $error');
// //     }
// //   }
// //
// //   Future<void> _initializeVideoPlayers() async {
// //     for (int i = 0; i < _controllers.length; i++) {
// //       try {
// //         await _controllers[i].initialize();
// //         setState(() {
// //           _initialized[i] = true;
// //         });
// //         _controllers[i].play(); // Auto-play the video after initialization
// //       } catch (error) {
// //         Get.snackbar('Error', 'Failed to initialize video player at index $i: $error');
// //       }
// //     }
// //   }
// //
// //   @override
// //   void dispose() {
// //     for (var controller in _controllers) {
// //       controller.dispose();
// //     }
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //         appBar: AppBar(
// //           title: Text('Reels'),
// //         ),
// //         body: Obx(() {
// //           if (_videoController.isLoading.value) {
// //             return const Center(child: CircularProgressIndicator());
// //           } else if (_videoController.videoUrls.isNotEmpty) {
// //             return ListView.builder(
// //               itemCount: _videoController.videoUrls.length,
// //               itemBuilder: (context, index) {
// //                 if (index >= _controllers.length || index >= _initialized.length) {
// //                   return const Center(child: Text('Error: Index out of bounds'));
// //                 }
// //
// //                 return VisibilityDetector(
// //                   key: Key('video_$index'),
// //                   onVisibilityChanged: (visibilityInfo) {
// //                     final visiblePercentage = visibilityInfo.visibleFraction * 100;
// //                     if (visiblePercentage > 50) {
// //                       if (!_controllers[index].value.isPlaying) {
// //                         _controllers[index].play();
// //                       }
// //                     } else {
// //                       if (_controllers[index].value.isPlaying) {
// //                         _controllers[index].pause();
// //                       }
// //                     }
// //                   },
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Stack(
// //                         alignment: Alignment.center,
// //                         children: [
// //                           _initialized[index]
// //                               ? AspectRatio(
// //                             aspectRatio: _controllers[index].value.aspectRatio,
// //                             child: VideoPlayer(_controllers[index]),
// //                           )
// //                               : Center(child: CircularProgressIndicator()),
// //                           if (_controllers[index].value.isPlaying)
// //                             Container() // Empty container when playing
// //                           else
// //                             GestureDetector(
// //                               onTap: () {
// //                                 setState(() {
// //                                   _controllers[index].play();
// //                                 });
// //                               },
// //                               child: Icon(
// //                                 Icons.play_arrow,
// //                                 size: 60,
// //                                 color: Colors.white.withOpacity(0.8),
// //                               ),
// //
// //                             ),
// //                           Stack(
// //                             children: [
// //                               Padding(padding: EdgeInsets.only(top: 580),
// //                                 child:   ListTile(
// //                                   leading: CircleAvatar(
// //                                     backgroundImage: _videoController.videoProfileImages.length > index
// //                                         ? NetworkImage(_videoController.videoProfileImages[index])
// //                                         : NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8NYnGDqrQm-gbf4fbXkaMBzmVLlf2rZdOLA&s"),
// //                                     backgroundColor: Colors.grey,
// //                                   ),
// //                                   title: Text(
// //                                     _videoController.videoUsernames.length > index
// //                                         ? _videoController.videoUsernames[index]
// //                                         : 'Unknown',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
// //                                   ),
// //                                   trailing: SizedBox(
// //                                     width: 100, // Set the width to your desired value
// //                                     child: Obx(() => OutlinedButton(
// //                                       onPressed: () {
// //                                         _videoController.toggleFollow();
// //                                       },
// //                                       child: Text(
// //                                         _videoController.isFollowing.value ? "Following" : "Follow",
// //                                         style: TextStyle(fontSize: 12),
// //                                       ),
// //                                       style: OutlinedButton.styleFrom(
// //                                         padding: EdgeInsets.symmetric(vertical: 5),
// //                                         side: BorderSide(color: Colors.blue), // Border color
// //                                         foregroundColor: Colors.white, // Text color
// //                                       ),
// //                                     )),
// //                                   ),
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ],
// //                       ),
// //
// //
// //                       SizedBox(height: 16),
// //
// //                     ],
// //                   ),
// //                 );
// //               },
// //             );
// //           } else {
// //             return Center(child: Text('No videos available'));
// //           }
// //         }),
// //     );
// //   }
// // }
// //
// //
// //
// //
//
//
//
//
//
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:video_player/video_player.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../../controllers/video_upload_controller.dart';
// import '../../models/post_model.dart';
//
// class ReelsScreen extends StatefulWidget {
//   @override
//   _ReelsScreenState createState() => _ReelsScreenState();
// }
//
// class _ReelsScreenState extends State<ReelsScreen> {
//   final VideoUploadController _videoController = Get.put(VideoUploadController());
//
//   late List<VideoPlayerController> _controllers;
//   late List<bool> _initialized;
//   late List<PostModel> _posts;
//   late PageController _pageController;
//
//   @override
//   void initState() {
//     super.initState();
//     _controllers = [];
//     _initialized = [];
//     _posts = [];
//     _pageController = PageController();
//     _initializeVideos();
//   }
//
//   Future<void> _initializeVideos() async {
//     try {
//       await _fetchPosts();
//       _controllers = _posts.map((post) => VideoPlayerController.network(post.mediaUrl)).toList();
//       _initialized = List.filled(_controllers.length, false);
//       await _initializeVideoPlayers();
//     } catch (error) {
//       Get.snackbar('Initialization Error', 'Error fetching videos: $error');
//     }
//   }
//
//   Future<void> _fetchPosts() async {
//     try {
//       QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('posts').get();
//       _posts = querySnapshot.docs.map((doc) => PostModel.fromFirestore(doc)).toList();
//       setState(() {});
//     } catch (error) {
//       Get.snackbar('Error', 'Failed to fetch posts: $error');
//     }
//   }
//
//   Future<void> _initializeVideoPlayers() async {
//     for (int i = 0; i < _controllers.length; i++) {
//       try {
//         await _controllers[i].initialize();
//         setState(() {
//           _initialized[i] = true;
//         });
//         if (i == 0) _controllers[i].play(); // Play the first video initially
//       } catch (error) {
//         Get.snackbar('Error', 'Failed to initialize video player at index $i: $error');
//       }
//     }
//   }
//
//   @override
//   void dispose() {
//     for (var controller in _controllers) {
//       controller.dispose();
//     }
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   void _likeVideo(int index) {
//     // Handle liking the video
//     // Update Firestore or your backend with the new like count
//     print('Liked video at index $index');
//   }
//
//   void _showCommentSheet(int index) {
//     TextEditingController commentController = TextEditingController();
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: commentController,
//                 decoration: InputDecoration(
//                   labelText: 'Add a comment...',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: () {
//                   final comment = commentController.text.trim();
//                   if (comment.isNotEmpty) {
//                     // Save the comment to Firestore or your backend
//                     print('Commented on video at index $index: $comment');
//                     _posts[index].caption += '\n${_posts[index].userName}: $comment';
//                     setState(() {});
//                     Navigator.pop(context);
//                   }
//                 },
//                 child: Text('Post Comment'),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _posts.isEmpty
//           ? Center(child: CircularProgressIndicator())
//           : PageView.builder(
//         controller: _pageController,
//         scrollDirection: Axis.vertical,
//         itemCount: _posts.length,
//         onPageChanged: (index) {
//           // Stop playing the previous video and start the new one
//           for (var controller in _controllers) {
//             controller.pause();
//           }
//           if (_initialized[index]) {
//             _controllers[index].play();
//           }
//         },
//         itemBuilder: (context, index) {
//           final post = _posts[index];
//
//           return Stack(
//             children: [
//               // Video Player
//               if (_initialized[index])
//                 GestureDetector(
//                   onTap: () {
//                     if (_controllers[index].value.isPlaying) {
//                       _controllers[index].pause();
//                     } else {
//                       _controllers[index].play();
//                     }
//                     setState(() {});
//                   },
//                   child: AspectRatio(
//                     aspectRatio: _controllers[index].value.aspectRatio,
//                     child: VideoPlayer(_controllers[index]),
//                   ),
//                 )
//               else
//                 Center(child: CircularProgressIndicator()),
//
//               // Video Info and Actions
//               Positioned(
//                 bottom: 20,
//                 left: 20,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // User info
//                     Row(
//                       children: [
//                         CircleAvatar(
//                           backgroundImage: NetworkImage(post.userImage),
//                         ),
//                         SizedBox(width: 10),
//                         Text(
//                           post.userName,
//                           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 10),
//
//                     // Caption
//                     Text(
//                       post.caption,
//                       style: TextStyle(color: Colors.black),
//                     ),
//                   ],
//                 ),
//               ),
//
//               // Like and Comment Actions
//               Positioned(
//                 right: 20,
//                 bottom: 80,
//                 child: Column(
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.favorite_border, color: Colors.white),
//                       onPressed: () => _likeVideo(index),
//                     ),
//                     SizedBox(height: 5),
//                     Text(
//                       '0', // Replace with the like count
//                       style: TextStyle(color: Colors.black),
//                     ),
//                     SizedBox(height: 20),
//                     IconButton(
//                       icon: Icon(Icons.comment, color: Colors.white),
//                       onPressed: () => _showCommentSheet(index),
//                     ),
//                     SizedBox(height: 5),
//                     Text(
//                       '0', // Replace with the comment count
//                       style: TextStyle(color: Colors.black),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
//










// import 'dart:convert';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:video_player/video_player.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../../controllers/useservices/userservices.dart';
//
// import '../video/video_screen.dart';
//
//
// class ReelsScreen extends StatefulWidget {
//
//   @override
//   _ReelsScreenState createState() => _ReelsScreenState();
// }
//
// @override
// _ReelsScreenState createState() => _ReelsScreenState();
//
//
// class _ReelsScreenState extends State<ReelsScreen> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final VideoUploadController _videoController = Get.find<VideoUploadController>();
//
//   late List<VideoPlayerController> _controllers;
//   late List<bool> _initialized;
//   late List<bool> _likedVideos;
//   late List<int> _likeCounts;
//   late List<int> _commentCounts;
//   late List<bool> _followedUsers;
//   late List<int> _followingCounts;
//   late List<int> _followerCounts;
//   late List<int> _followCounts;
//   late List<List<Map<String, String>>> _videoComments;
//
//   @override
//   void initState() {
//     super.initState();
//     _controllers = [];
//     _initialized = [];
//     _likedVideos = [];
//     _likeCounts = [];
//     _commentCounts = [];
//     _videoComments = [];
//     _followerCounts = [];
//     _followedUsers = [];
//     _followingCounts = [];
//     _followCounts = [];
//
//     _initializeVideos();
//   }
//
//   Future<void> _toggleFollow(int index) async {
//     setState(() {
//       _followedUsers[index] = !_followedUsers[index];
//       _followCounts[index] += _followedUsers[index] ? 1 : -1;
//       _followingCounts[index] += _followedUsers[index] ? 1 : -1;
//     });
//
//     final currentUserId = _auth.currentUser?.uid ?? 'default_user_id'; // Replace with actual current user ID
//     final followedUserId = 'user_$index'; // Replace with actual followed user ID
//
//     final usersCollection = _firestore.collection('users');
//     await usersCollection.doc(currentUserId).update({
//       'following_count': FieldValue.increment(_followedUsers[index] ? 1 : -1),
//     });
//
//     await usersCollection.doc(followedUserId).update({
//       'followers_count': FieldValue.increment(_followedUsers[index] ? 1 : -1),
//     });
//   }
//
//   Future<void> _initializeVideos() async {
//     try {
//       await _videoController.fetchVideoUrls();
//       setState(() {
//         _controllers = _videoController.videoUrls
//             .map((url) => VideoPlayerController.network(url))
//             .toList();
//         _initialized = List.filled(_controllers.length, false);
//
//         _likedVideos = List.filled(_controllers.length, false);
//         _likeCounts = List.filled(_controllers.length, 0);
//         _commentCounts = List.filled(_controllers.length, 0);
//         _followCounts = List.filled(_controllers.length, 0);
//         _followedUsers = List.filled(_controllers.length, false);
//         _followingCounts = List.filled(_controllers.length, 0);
//         _followerCounts = List.filled(_controllers.length, 0);
//         videoComments = List.generate(_controllers.length, () => []);
//       });
//
//       await _loadLikeData();
//       await _loadCommentData();
//
//       await _initializeVideoPlayers();
//     } catch (error) {
//       Get.snackbar('Initialization Error', 'Error fetching video URLs: $error');
//     }
//   }
//
//   Future<void> _initializeVideoPlayers() async {
//     for (int i = 0; i < _controllers.length; i++) {
//       try {
//         await _controllers[i].initialize();
//         setState(() {
//           _initialized[i] = true;
//         });
//         _controllers[i].play();
//       } catch (error) {
//         Get.snackbar('Error', 'Failed to initialize video player at index $i: $error');
//       }
//     }
//   }
//   void _shareVideo(String url) {
//     Share.share(url);
//   }
//
//   Future<void> _loadLikeData() async {
//     final prefs = await SharedPreferences.getInstance();
//     for (int i = 0; i < _controllers.length; i++) {
//       _likedVideos[i] = prefs.getBool('liked_video$i') ?? false;
//       _likeCounts[i] = prefs.getInt('like_count$i') ?? 0;
//       _commentCounts[i] = prefs.getInt('comment_count$i') ?? 0;
//     }
//   }
//
//   Future<void> _saveLikeData() async {
//     final prefs = await SharedPreferences.getInstance();
//     for (int i = 0; i < _controllers.length; i++) {
//       await prefs.setBool('liked_video_$i', _likedVideos[i]);
//       await prefs.setInt('like_count_$i', _likeCounts[i]);
//       await prefs.setInt('comment_count_$i', _commentCounts[i]);
//     }
//   }
//
//   Future<void> _loadCommentData() async {
//     final prefs = await SharedPreferences.getInstance();
//     for (int i = 0; i < _controllers.length; i++) {
//       final commentsJson = prefs.getString('comments_video_$i') ?? '[]';
//       final commentsList = json.decode(commentsJson) as List;
//       _videoComments[i] = commentsList.map((comment) => Map<String, String>.from(comment)).toList();
//       _commentCounts[i] = _videoComments[i].length;
//     }
//   }
//
//   Future<void> _saveCommentData() async {
//     final prefs = await SharedPreferences.getInstance();
//     for (int i = 0; i < _controllers.length; i++) {
//       final commentsJson = json.encode(_videoComments[i]);
//       await prefs.setString('comments_video_$i', commentsJson);
//       _commentCounts[i] = _videoComments[i].length;
//     }
//     await _saveLikeData();
//   }
//
//   void _showCommentSheet(int index) {
//     final TextEditingController commentController = TextEditingController();
//
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (context) {
//         return Padding(
//           padding: EdgeInsets.only(
//             bottom: MediaQuery.of(context).viewInsets.bottom,
//           ),
//           child: Container(
//             padding: EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Text(
//                   'Add Comment',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 10),
//                 TextField(
//                   controller: commentController,
//                   decoration: InputDecoration(hintText: 'Enter your comment'),
//                 ),
//                 SizedBox(height: 10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     TextButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: Text('Cancel'),
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         if (commentController.text.isNotEmpty) {
//                           setState(() {
//                             _videoComments[index].add({
//                               'comment': commentController.text,
//                               'userName': _videoController.videoUsernames[index] ?? 'Unknown User',
//                               'profileImageUrl': _videoController.videoProfileImages[index] ?? '',
//                             });
//                             _saveCommentData();
//                           });
//                           Navigator.of(context).pop();
//                         }
//                       },
//                       child: Text('Submit'),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 const Text(
//                   'Comments',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 10),
//                 Expanded(
//                   child: ListView(
//                     children: _videoComments[index].map((comment) {
//                       final profileImageUrl = comment['profileImageUrl'] as String? ?? '';
//                       final userName = comment['userName'] as String? ?? 'Anonymous';
//                       final commentText = comment['comment'] as String? ?? '';
//
//                       return ListTile(
//                         leading: CircleAvatar(
//                           backgroundImage: profileImageUrl.isNotEmpty
//                               ? NetworkImage(profileImageUrl)
//                               : null,
//                           child: profileImageUrl.isEmpty
//                               ? Icon(Icons.person) // Placeholder if no image
//                               : null,
//                         ),
//                         title: Text(
//                           userName,
//                           style: const TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         subtitle: Text(
//                           commentText,
//                           style: const TextStyle(
//                             color: Colors.black,
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     for (var controller in _controllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }
//
//   @override
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Reels'),
//         ),
//         body: Obx(() {
//           if (_videoController.isLoading.value) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (_videoController.videoUrls.isNotEmpty) {
//             return ListView.builder(
//               itemCount: _controllers.length,
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: () {
//                     // Navigate to full-screen video player on tap
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => FullScreenVideoPlayer(controller: _controllers[index]),
//                       ),
//                     );
//                   },
//                   child: Column(
//                     children: [
//                       if (_initialized[index])
//                         Stack(
//                           children: [
//                             // Video Player (centered)
//                             AspectRatio(
//                               aspectRatio: _controllers[index].value.aspectRatio,
//                               child: VideoPlayer(_controllers[index]),
//                             ),
//
//                             // Play Circle Icon (shown when the video is not playing)
//                             if (!_controllers[index].value.isPlaying)
//                               Padding(padding: EdgeInsets.only(top: 300),// Only show icon if the video is not playing
//                                 child:  Center(
//                                   child: Icon(
//                                     Icons.play_circle_fill, // Use play_circle_fill for a filled play icon
//                                     color: Colors.white,
//                                     size: 50.0,
//                                   ),
//                                 ),
//                               ),
//
//                             // Right side Column for likes, comments, and follow button
//                             Positioned(
//                               right: 10, // Position it a bit away from the right edge
//                               bottom: 20, // Position it a bit above the bottom edge
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   IconButton(
//                                     icon: Icon(
//                                       _likedVideos[index]
//                                           ? Icons.favorite
//                                           : Icons.favorite_border,
//                                       color: _likedVideos[index]
//                                           ? Colors.red
//                                           : Colors.grey,
//                                     ),
//                                     onPressed: () async {
//                                       setState(() {
//                                         _likedVideos[index] = !_likedVideos[index];
//                                         _likeCounts[index] += _likedVideos[index] ? 1 : -1;
//                                       });
//                                       await _saveLikeData();
//                                     },
//                                   ),
//                                   Text(
//                                     '${_likeCounts[index]} ',
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                   SizedBox(height: 10), // Add some spacing between buttons
//                                   IconButton(
//                                     icon: Icon(
//                                       Icons.comment,
//                                       color: Colors.white,
//                                     ),
//                                     onPressed: () {
//                                       _showCommentSheet(index);
//                                     },
//                                   ),
//                                   Text(
//                                     '${_commentCounts[index]} ',
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                   SizedBox(height: 10),
//                                   OutlinedButton(
//                                     style: OutlinedButton.styleFrom(
//                                       side: BorderSide(
//                                         color: _followedUsers[index]
//                                             ? Colors.blue
//                                             : Colors.white,
//                                       ),
//                                     ),
//                                     onPressed: () {
//                                       _toggleFollow(index);
//                                     },
//                                     child: Text(
//                                       _followedUsers[index]
//                                           ? 'Following'
//                                           : 'Follow',
//                                       style: TextStyle(
//                                         color: _followedUsers[index]
//                                             ? Colors.blue
//                                             : Colors.white,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             PopupMenuButton(itemBuilder: (context) {
//                               _deleteVideo();
//                             },),
//                             IconButton(
//                               icon: Icon(Icons.share),
//                               onPressed: () => _shareVideo(_videoController.videoUrls[index]),
//                             ),
//                             // User Profile Info
//                             Positioned(
//                               top: 600,
//                               left: 20,
//                               child: Row(
//                                 children: [
//                                   Container(
//                                     padding: EdgeInsets.all(2.0), // Padding to create space between the image and the border
//                                     decoration: BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       border: Border.all(
//                                         color: Colors.white, // Border color
//                                         width: 3.0, // Border width
//                                       ),
//                                     ),
//                                     child: CircleAvatar(
//                                       backgroundImage: NetworkImage(
//                                         _videoController.videoProfileImages[index] ?? '',
//                                       ),
//                                       maxRadius: 30,
//                                     ),
//                                   ),
//                                   SizedBox(width: 10),
//                                   Text(
//                                     _videoController.videoUsernames[index] ?? 'Unknown User',
//                                     style: const TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         )
//                     ],
//                   ),
//                 );
//               },
//             );
//           } else {
//             return const Center(child: Text('No videos available.'));
//           }
//         }),
//         );
//     }
//   Future<void> _deleteVideo(int index) async {
//     try {
//       final videoUrl = _videoController.videoUrls[index];
//       // Delete the video from Firebase Storage
//       final storageRef = FirebaseStorage.instance.refFromURL(videoUrl);
//       await storageRef.delete();
//
//       // Remove the video URL from Firestore
//       final userId = _auth.currentUser?.uid ?? 'default_user_id'; // Replace with actual current user ID
//       await _firestore.collection('users').doc(userId).collection('videos').doc(videoUrl).delete();
//
//       // Remove the video from the list
//       setState(() {
//         _controllers.removeAt(index);
//         _initialized.removeAt(index);
//         _likedVideos.removeAt(index);
//         _likeCounts.removeAt(index);
//         _commentCounts.removeAt(index);
//         _followCounts.removeAt(index);
//         _followedUsers.removeAt(index);
//         _followingCounts.removeAt(index);
//         _followerCounts.removeAt(index);
//         _videoComments.removeAt(index);
//       });
//     } catch (error) {
//       Get.snackbar('Error', 'Failed to delete video: $error');
//     }
//   }
//
// }



import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/instra_controller/video_upload_controller.dart';
import '../full_screen_video_player.dart';

class ReelsScreen extends StatefulWidget {
  @override
  _ReelsScreenState createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final VideoUploadController _videoController = Get.find<VideoUploadController>();

  late List<VideoPlayerController> _controllers;
  late List<bool> _initialized;
  late List<bool> _likedVideos;
  late List<int> _likeCounts;
  late List<int> _commentCounts;
  late List<bool> _followedUsers;
  late List<int> _followingCounts;
  late List<int> _followerCounts;
  late List<int> _followCounts;
  late List<List<Map<String, String>>> _videoComments;

  @override
  void initState() {
    super.initState();
    _controllers = [];
    _initialized = [];
    _likedVideos = [];
    _likeCounts = [];
    _commentCounts = [];
    _videoComments = [];
    _followerCounts = [];
    _followedUsers = [];
    _followingCounts = [];
    _followCounts = [];

    _initializeVideos();
  }

  Future<void> _toggleFollow(int index) async {
    setState(() {
      _followedUsers[index] = !_followedUsers[index];
      _followCounts[index] += _followedUsers[index] ? 1 : -1;
      _followingCounts[index] += _followedUsers[index] ? 1 : -1;
    });

    final currentUserId = _auth.currentUser?.uid ?? 'default_user_id';
    final followedUserId = 'user_$index';

    final usersCollection = _firestore.collection('users');
    await usersCollection.doc(currentUserId).update({
      'following_count': FieldValue.increment(_followedUsers[index] ? 1 : -1),
    });

    await usersCollection.doc(followedUserId).update({
      'followers_count': FieldValue.increment(_followedUsers[index] ? 1 : -1),
    });
  }

  Future<void> _initializeVideos() async {
    try {
      await _videoController.fetchVideoUrls();
      setState(() {
        _controllers = _videoController.videoUrls
            .map((url) => VideoPlayerController.network(url))
            .toList();
        _initialized = List.filled(_controllers.length, false);
        _likedVideos = List.filled(_controllers.length, false);
        _likeCounts = List.filled(_controllers.length, 0);
        _commentCounts = List.filled(_controllers.length, 0);
        _followCounts = List.filled(_controllers.length, 0);
        _followedUsers = List.filled(_controllers.length, false);
        _followingCounts = List.filled(_controllers.length, 0);
        _followerCounts = List.filled(_controllers.length, 0);
        _videoComments = List.generate(_controllers.length, (_) => []);
      });

      await _loadLikeData();
      await _loadCommentData();

      await _initializeVideoPlayers();
    } catch (error) {
      Get.snackbar('Initialization Error', 'Error fetching video URLs: $error');
    }
  }

  Future<void> _initializeVideoPlayers() async {
    for (int i = 0; i < _controllers.length; i++) {
      try {
        await _controllers[i].initialize();
        setState(() {
          _initialized[i] = true;
        });
        _controllers[i].play();
      } catch (error) {
        Get.snackbar('Error', 'Failed to initialize video player at index $i: $error');
      }
    }
  }

  void _shareVideo(String url) {
    Share.share(url);
  }

  Future<void> _loadLikeData() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < _controllers.length; i++) {
      _likedVideos[i] = prefs.getBool('liked_video$i') ?? false;
      _likeCounts[i] = prefs.getInt('like_count$i') ?? 0;
      _commentCounts[i] = prefs.getInt('comment_count$i') ?? 0;
    }
  }

  Future<void> _saveLikeData() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < _controllers.length; i++) {
      await prefs.setBool('liked_video_$i', _likedVideos[i]);
      await prefs.setInt('like_count_$i', _likeCounts[i]);
      await prefs.setInt('comment_count_$i', _commentCounts[i]);
    }
  }

  Future<void> _loadCommentData() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 1; i < _controllers.length; i++) {
      final commentsJson = prefs.getString('comments_video_$i') ?? '[]';
      final commentsList = json.decode(commentsJson) as List;
      _videoComments[i] = commentsList.map((comment) => Map<String, String>.from(comment)).toList();
      _commentCounts[i] = _videoComments[i].length;
    }
  }

  Future<void> _saveCommentData() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 1; i < _controllers.length; i++) {
      final commentsJson = json.encode(_videoComments[i]);
      await prefs.setString('comments_video_$i', commentsJson);
      _commentCounts[i] = _videoComments[i].length;
    }
    await _saveLikeData();
  }

  void _showCommentSheet(int index) {
    final TextEditingController commentController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Add Comment',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: commentController,
                  decoration: InputDecoration(hintText: 'Enter your comment'),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (commentController.text.isNotEmpty) {
                          setState(() {
                            _videoComments[index].add({
                              'comment': commentController.text,
                              'userName': _videoController.videoUsernames[index] ?? 'Unknown User',
                              'profileImageUrl': _videoController.videoProfileImages[index] ?? '',
                            });
                            _saveCommentData();
                          });
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                const Text(
                  'Comments',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView(
                    children: _videoComments[index].map((comment) {
                      final profileImageUrl = comment['profileImageUrl'] as String? ?? '';
                      final userName = comment['userName'] as String? ?? 'Anonymous';
                      final commentText = comment['comment'] as String? ?? '';

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: profileImageUrl.isNotEmpty
                              ? NetworkImage(profileImageUrl)
                              : null,
                          child: profileImageUrl.isEmpty
                              ? Icon(Icons.person)
                              : null,
                        ),
                        title: Text(
                          userName,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          commentText,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _deleteVideo(int index) async {
    try {
      final videoUrl = _videoController.videoUrls[index];

      // Extract videoId correctly from the URL
      final videoId = videoUrl.split('/').last.split('?').first;

      final storageRef = FirebaseStorage.instance.refFromURL(videoUrl);
      await storageRef.delete();

      final userId = _auth.currentUser?.uid ?? 'default_user_id';
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('videos')
          .doc(videoId)
          .delete();

      setState(() {
        _videoController.videoUrls.removeAt(index);
        _controllers.removeAt(index);
        _initialized.removeAt(index);
        _likedVideos.removeAt(index);
        _likeCounts.removeAt(index);
        _commentCounts.removeAt(index);
        _followCounts.removeAt(index);
        _followedUsers.removeAt(index);
        _followingCounts.removeAt(index);
        _followerCounts.removeAt(index);
        _videoComments.removeAt(index);
      });
    } catch (error) {
      Get.snackbar('Error', 'Failed to delete video: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reels'),
      ),
      body: Obx(() {
        if (_videoController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (_videoController.videoUrls.isNotEmpty) {
          return ListView.builder(
            itemCount: _controllers.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => FullScreenVideoPlayer(controller: _controllers[index]),
                    ),
                  );
                },
                child: Column(
                  children: [
                    if (_initialized[index])
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          AspectRatio(
                            aspectRatio: _controllers[index].value.aspectRatio,
                            child: VideoPlayer(_controllers[index]),
                          ),
                          if (!_controllers[index].value.isPlaying) // Show play button if video is not playing
                            IconButton(
                              icon: Icon(
                                Icons.play_circle_fill,
                                color: Colors.white,
                                size: 50.0,
                              ),
                              onPressed: () {
                                _controllers[index].play();
                                setState(() {}); // Update the UI to reflect the change
                              },
                            ),
                          Positioned(
                            right: 10,
                            bottom: 20,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    _likedVideos[index]
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: _likedVideos[index]
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                  onPressed: () async {
                                    setState(() {
                                      _likedVideos[index] = !_likedVideos[index];
                                      _likeCounts[index] += _likedVideos[index] ? 1 : -1;
                                    });
                                    await _saveLikeData();
                                  },
                                ),
                                Text(
                                  '${_likeCounts[index]}',
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 10),
                                IconButton(
                                  icon: Icon(
                                    Icons.comment,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    _showCommentSheet(index);
                                  },
                                ),
                                Text(
                                  '${_commentCounts[index]}',
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 10),

                                PopupMenuButton<String>(
                                  onSelected: (String result) {
                                    if (result == 'delete') {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text('Delete Video'),
                                            content: Text('Are you sure you want to delete this video?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  _deleteVideo(index);
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('Delete'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  },
                                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                    const PopupMenuItem<String>(
                                      value: 'delete',
                                      child: Text('Delete'),
                                    ),
                                    // Add other menu items here if needed
                                  ],
                                  icon: Icon(Icons.more_vert,color: Colors.white,),
                                ),

                                IconButton(
                                  icon: Icon(Icons.share,color: Colors.white,),
                                  onPressed: () => _shareVideo(_videoController.videoUrls[index]),
                                ),
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                      color: _followedUsers[index]
                                          ? Colors.blue
                                          : Colors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    _toggleFollow(index);
                                  },
                                  child: Text(
                                    _followedUsers[index]
                                        ? 'Following'
                                        : 'Follow',
                                    style: TextStyle(
                                      color: _followedUsers[index]
                                          ? Colors.blue
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 550,
                            left: 20,
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(2.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 3.0,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      _videoController.videoProfileImages[index] ?? '',
                                    ),
                                    maxRadius: 30,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  _videoController.videoUsernames[index] ?? 'Unknown User',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                  ],
                ),
              );
            },
          );
        } else {
          return const Center(child: Text('No videos available.'));
        }
      }),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
    }
}
