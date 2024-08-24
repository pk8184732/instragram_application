import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:instragram_application/insragram_application/views/post_view.dart';
import 'package:instragram_application/insragram_application/views/profile/account/account_screen.dart';
import 'package:instragram_application/insragram_application/views/profile/profile_edit/edit_screen.dart';
import '../reels/reels_screen.dart';
import 'package:video_player/video_player.dart';
import '../search/search_screen.dart';


//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 0;
//   List<String> videoUrls = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _loadVideoUrls();
//   }
//
//   Future<void> _loadVideoUrls() async {
//     List<String> fetchedVideoUrls = await fetchVideoUrls();
//     setState(() {
//       videoUrls = fetchedVideoUrls;
//     });
//   }
//
//   Future<List<String>> fetchVideoUrls() async {
//     List<String> videoUrls = [];
//     final storageRef = FirebaseStorage.instance.ref();
//     final videoRef = storageRef.child('videos');
//     final videoList = await videoRef.listAll();
//     for (var item in videoList.items) {
//       final videoUrl = await item.getDownloadURL();
//       videoUrls.add(videoUrl);
//     }
//
//     return videoUrls;
//   }
//
//   List<Widget> _buildPages() {
//     return [
//       ProfileScreen(),
//       SearchScreenes(),
//       ReelsScreen(),
//     ];
//   }
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _buildPages()[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search),
//             label: 'Search',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.video_collection),
//             label: 'Reels',
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
//
// class ProfileVideoController extends GetxController {
//   // Profile and Posts
//   var isLoading = true.obs;
//   var posts = <Map<String, dynamic>>[].obs;
//   var userProfile = {}.obs;
//
//   // Video Player
//   var isPlaying = true.obs;
//   var isLiked = false.obs;
//   var likeCount = 0.obs;
//   var comments = <Map<String, String>>[].obs;
//
//   late String videoUrl;
//   late String videoId;
//   late String caption;
//
//   @override
//   void onInit() {
//     fetchUserProfile();
//     fetchPosts();
//     super.onInit();
//   }
//
//   Future<void> fetchUserProfile() async {
//     try {
//       // Replace with actual Firestore logic
//       userProfile.value = {}; // Replace with actual fetching logic
//     } catch (e) {
//       print("Failed to fetch user profile: $e");
//     }
//   }
//
//   Future<void> fetchPosts() async {
//     try {
//       QuerySnapshot snapshot = await FirebaseFirestore.instance
//           .collection('posts')
//           .orderBy('timestamp', descending: true)
//           .get();
//       posts.value = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
//       isLoading.value = false;
//     } catch (e) {
//       print("Failed to fetch posts: $e");
//       isLoading.value = false;
//     }
//   }
//
//   void fetchVideoData() async {
//     try {
//       final doc = await FirebaseFirestore.instance.collection('videos').doc(videoId).get();
//       if (doc.exists) {
//         final data = doc.data() as Map<String, dynamic>;
//         isLiked.value = data['isLiked'] ?? false;
//         likeCount.value = data['likeCount'] ?? 0;
//         comments.assignAll(List<Map<String, String>>.from(data['comments'] ?? []));
//       }
//     } catch (e) {
//       print("Failed to fetch video data: $e");
//     }
//   }
//
//   void togglePlayPause() {
//     isPlaying.value = !isPlaying.value;
//   }
//
//   void toggleLike() {
//     isLiked.value = !isLiked.value;
//     likeCount.value += isLiked.value ? 1 : -1;
//     // Update Firestore logic here
//   }
//
//   void addComment(String comment) {
//     comments.add({
//       'name': 'User',
//       'image': 'https://example.com/user_image.png',
//       'comment': comment,
//     });
//     // Update Firestore logic here
//   }
// }
//
//
// class ProfileScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final ProfileVideoController controller = Get.put(ProfileVideoController());
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return Center(
//             child: SpinKitFadingCircle(
//               color: Colors.white,
//               size: 50.0,
//             ),
//           );
//         }
//
//         return Column(
//           children: [
//             // User Profile Section
//             Row(
//               children: [
//
//                 CircleAvatar(
//                   radius: 55,
//                   backgroundImage: NetworkImage(controller.userProfile['profileImage'] ?? ''),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(18.0),
//                   child: Column(
//                     children: [
//                       Text(
//                         '${controller.posts.length}',
//                         style: TextStyle(fontSize: 18),
//                       ),
//                       Text("Posts", style: TextStyle(fontWeight: FontWeight.w500)),
//                     ],
//                   ),
//                 ),
//                 // Add followers and following count
//               ],
//             ),
//             Expanded(
//               child: GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   crossAxisSpacing: 4.0,
//                   mainAxisSpacing: 4.0,
//                 ),
//                 itemCount: controller.posts.length,
//                 itemBuilder: (context, index) {
//                   final post = controller.posts[index];
//                   return GestureDetector(
//                     onTap: () {
//                       controller.videoUrl = post['mediaUrl'] ?? '';
//                       controller.videoId = 'unique_video_id'; // Replace with actual ID
//                       controller.caption = 'Sample caption';
//                       controller.fetchVideoData();
//                       Get.to(() => FullscreenVideoPlayer(controller: controller));
//                     },
//                     child: Image.network(post['mediaUrl'] ?? ''),
//                   );
//                 },
//               ),
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }
//
//
// class FullscreenVideoPlayer extends StatefulWidget {
//   final ProfileVideoController controller;
//
//   FullscreenVideoPlayer({required this.controller});
//
//   @override
//   _FullscreenVideoPlayerState createState() => _FullscreenVideoPlayerState();
// }
//
// class _FullscreenVideoPlayerState extends State<FullscreenVideoPlayer> {
//   late VideoPlayerController _videoPlayerController;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeVideo();
//   }
//
//   Future<void> _initializeVideo() async {
//     _videoPlayerController = VideoPlayerController.network(widget.controller.videoUrl)
//       ..initialize().then((_) {
//         setState(() {}); // Update state when the video is initialized
//         if (widget.controller.isPlaying.value) {
//           _videoPlayerController.play();
//         }
//       });
//     _videoPlayerController.addListener(() {
//       setState(() {
//         widget.controller.isPlaying.value = _videoPlayerController.value.isPlaying;
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     _videoPlayerController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           Center(
//             child: GestureDetector(
//               onTap: () => widget.controller.togglePlayPause(),
//               child: _videoPlayerController.value.isInitialized
//                   ? AspectRatio(
//                 aspectRatio: _videoPlayerController.value.aspectRatio,
//                 child: VideoPlayer(_videoPlayerController),
//               )
//                   : Center(
//                 child: SpinKitFadingCircle(
//                   color: Colors.grey,
//                   size: 30.0,
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             top: 40,
//             left: 10,
//             child: IconButton(
//               icon: Icon(Icons.arrow_back, color: Colors.white),
//               onPressed: () => Get.back(),
//             ),
//           ),
//           Positioned(
//             bottom: 20,
//             left: 10,
//             right: 10,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(widget.controller.caption, style: TextStyle(color: Colors.white)),
//                 Obx(() {
//                   return Column(
//                     children: [
//                       Row(
//                         children: [
//                           IconButton(
//                             icon: Icon(
//                               widget.controller.isLiked.value ? Icons.favorite : Icons.favorite_border,
//                               color: widget.controller.isLiked.value ? Colors.red : Colors.white,
//                             ),
//                             onPressed: () => widget.controller.toggleLike(),
//                           ),
//                           Text('${widget.controller.likeCount.value}', style: TextStyle(color: Colors.white)),
//                           IconButton(
//                             icon: Icon(Icons.comment, color: Colors.white),
//                             onPressed: () {
//                               // Show comments dialog
//                             },
//                           ),
//                           Text('${widget.controller.comments.length}', style: TextStyle(color: Colors.white)),
//                         ],
//                       ),
//                       // Display comments list
//                     ],
//                   );
//                 }),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }







// import 'package:chewie/chewie.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import '../reels/reels_screen.dart';
// import 'package:video_player/video_player.dart';
// import '../search/search_screen.dart';
//
//
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 0;
//   List<String> videoUrls = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _loadVideoUrls();
//   }
//
//   Future<void> _loadVideoUrls() async {
//     List<String> fetchedVideoUrls = await fetchVideoUrls();
//     setState(() {
//       videoUrls = fetchedVideoUrls;
//     });
//   }
//
//   Future<List<String>> fetchVideoUrls() async {
//     List<String> videoUrls = [];
//     final storageRef = FirebaseStorage.instance.ref();
//     final videoRef = storageRef.child('videos');
//     final videoList = await videoRef.listAll();
//     for (var item in videoList.items) {
//       final videoUrl = await item.getDownloadURL();
//       videoUrls.add(videoUrl);
//     }
//
//     return videoUrls;
//   }
//
//   List<Widget> _buildPages() {
//     return [
//       ProfileScreen(),
//       SearchScreenes(),
//       ReelsScreen(),
//     ];
//   }
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _buildPages()[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search),
//             label: 'Search',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.video_collection),
//             label: 'Reels',
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
//
// class ProfileVideoController extends GetxController {
//   // Profile and Posts
//   var isLoading = true.obs;
//   var posts = <Map<String, dynamic>>[].obs;
//   var userProfile = {}.obs;
//
//   // Video Player
//   var isPlaying = true.obs;
//   var isLiked = false.obs;
//   var likeCount = 0.obs;
//   var comments = <Map<String, String>>[].obs;
//
//   late String videoUrl;
//   late String videoId;
//   late String caption;
//
//   @override
//   void onInit() {
//     fetchUserProfile();
//     fetchPosts();
//     super.onInit();
//   }
//
//   Future<void> fetchUserProfile() async {
//     try {
//       // Replace with actual Firestore logic
//       userProfile.value = {}; // Replace with actual fetching logic
//     } catch (e) {
//       print("Failed to fetch user profile: $e");
//     }
//   }
//
//   Future<void> fetchPosts() async {
//     try {
//       QuerySnapshot snapshot = await FirebaseFirestore.instance
//           .collection('posts')
//           .orderBy('timestamp', descending: true)
//           .get();
//       posts.value = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
//       isLoading.value = false;
//     } catch (e) {
//       print("Failed to fetch posts: $e");
//       isLoading.value = false;
//     }
//   }
//
//   void fetchVideoData() async {
//     try {
//       final doc = await FirebaseFirestore.instance.collection('videos').doc(videoId).get();
//       if (doc.exists) {
//         final data = doc.data() as Map<String, dynamic>;
//         isLiked.value = data['isLiked'] ?? false;
//         likeCount.value = data['likeCount'] ?? 0;
//         comments.assignAll(List<Map<String, String>>.from(data['comments'] ?? []));
//       }
//     } catch (e) {
//       print("Failed to fetch video data: $e");
//     }
//   }
//
//   void togglePlayPause() {
//     isPlaying.value = !isPlaying.value;
//   }
//
//   void toggleLike() {
//     isLiked.value = !isLiked.value;
//     likeCount.value += isLiked.value ? 1 : -1;
//     // Update Firestore logic here
//   }
//
//   void addComment(String comment) {
//     comments.add({
//       'name': 'User',
//       'image': 'https://example.com/user_image.png',
//       'comment': comment,
//     });
//     // Update Firestore logic here
//   }
// }
//
//
// class ProfileScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final ProfileVideoController controller = Get.put(ProfileVideoController());
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return Center(
//             child: SpinKitFadingCircle(
//               color: Colors.white,
//               size: 50.0,
//             ),
//           );
//         }
//
//         return Column(
//           children: [
//             // User Profile Section
//             Row(
//               children: [
//                 CircleAvatar(
//                   radius: 55,
//                   backgroundImage: NetworkImage(controller.userProfile['profileImage'] ?? ''),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(18.0),
//                   child: Column(
//                     children: [
//                       Text(
//                         '${controller.posts.length}',
//                         style: TextStyle(fontSize: 18),
//                       ),
//                       Text("Posts", style: TextStyle(fontWeight: FontWeight.w500)),
//                     ],
//                   ),
//                 ),
//                 // Add followers and following count
//               ],
//             ),
//             Expanded(
//               child: GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   crossAxisSpacing: 4.0,
//                   mainAxisSpacing: 4.0,
//                 ),
//                 itemCount: controller.posts.length,
//                 itemBuilder: (context, index) {
//                   final post = controller.posts[index];
//                   return GestureDetector(
//                     onTap: () {
//                       controller.videoUrl = post['mediaUrl'] ?? '';
//                       controller.videoId = 'unique_video_id'; // Replace with actual ID
//                       controller.caption = 'Sample caption';
//                       controller.fetchVideoData();
//                       Get.to(() => FullscreenVideoPlayer(controller: controller));
//                     },
//                     child: Image.network(post['mediaUrl'] ?? ''),
//                   );
//                 },
//               ),
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }
//
//
// class FullscreenVideoPlayer extends StatefulWidget {
//   final ProfileVideoController controller;
//
//   FullscreenVideoPlayer({required this.controller});
//
//   @override
//   _FullscreenVideoPlayerState createState() => _FullscreenVideoPlayerState();
// }
//
// class _FullscreenVideoPlayerState extends State<FullscreenVideoPlayer> {
//   late VideoPlayerController _videoPlayerController;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeVideo();
//   }
//
//   Future<void> _initializeVideo() async {
//     _videoPlayerController = VideoPlayerController.network(widget.controller.videoUrl)
//       ..initialize().then((_) {
//         setState(() {}); // Update state when the video is initialized
//         if (widget.controller.isPlaying.value) {
//           _videoPlayerController.play();
//         }
//       });
//     _videoPlayerController.addListener(() {
//       setState(() {
//         widget.controller.isPlaying.value = _videoPlayerController.value.isPlaying;
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     _videoPlayerController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           Center(
//             child: GestureDetector(
//               onTap: () => widget.controller.togglePlayPause(),
//               child: _videoPlayerController.value.isInitialized
//                   ? AspectRatio(
//                 aspectRatio: _videoPlayerController.value.aspectRatio,
//                 child: VideoPlayer(_videoPlayerController),
//               )
//                   : Center(
//                 child: SpinKitFadingCircle(
//                   color: Colors.grey,
//                   size: 30.0,
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             top: 40,
//             left: 10,
//             child: IconButton(
//               icon: Icon(Icons.arrow_back, color: Colors.white),
//               onPressed: () => Get.back(),
//             ),
//           ),
//           Positioned(
//             bottom: 20,
//             left: 10,
//             right: 10,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(widget.controller.caption, style: TextStyle(color: Colors.white)),
//                 Obx(() {
//                   return Column(
//                     children: [
//                       Row(
//                         children: [
//                           IconButton(
//                             icon: Icon(
//                               widget.controller.isLiked.value ? Icons.favorite : Icons.favorite_border,
//                               color: widget.controller.isLiked.value ? Colors.red : Colors.white,
//                             ),
//                             onPressed: () => widget.controller.toggleLike(),
//                           ),
//                           Text('${widget.controller.likeCount.value}', style: TextStyle(color: Colors.white)),
//                           IconButton(
//                             icon: Icon(Icons.comment, color: Colors.white),
//                             onPressed: () {
//                               // Show comments dialog
//                             },
//                           ),
//                           Text('${widget.controller.comments.length}', style: TextStyle(color: Colors.white)),
//                         ],
//                       ),
//                       // Display comments list
//                     ],
//                   );
//                 }),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
//




// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:instragram_application/insragram_application/views/post_view.dart';
// import 'package:video_player/video_player.dart';
// import '../search/search_screen.dart';
// import '../reels/reels_screen.dart';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:video_player/video_player.dart';
//
//
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _buildPages()[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search),
//             label: 'Search',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.video_collection),
//             label: 'Reels',
//           ),
//         ],
//       ),
//     );
//   }
//
//   List<Widget> _buildPages() {
//     return [
//       ProfileScreen(),
//       // Add SearchScreen and ReelsScreen as needed
//     ];
//   }
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
// }
//
// class ProfileVideoController extends GetxController {
//   var isLoading = true.obs;
//   var posts = <Map<String, dynamic>>[].obs;
//   var userProfile = {}.obs;
//
//   @override
//   void onInit() {
//     fetchUserProfile();
//     fetchPosts();
//     super.onInit();
//   }
//
//   Future<void> fetchUserProfile() async {
//     try {
//       // Replace with actual Firestore logic
//       userProfile.value = {
//         'username': 'User Name',
//         'profileImage': 'https://example.com/user_image.png',
//         'bio': 'This is a sample bio',
//         'posts': 10,
//         'followers': 150,
//         'following': 120,
//       };
//       isLoading.value = false;
//     } catch (e) {
//       print("Failed to fetch user profile: $e");
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> fetchPosts() async {
//     try {
//       QuerySnapshot snapshot = await FirebaseFirestore.instance
//           .collection('posts')
//           .orderBy('timestamp', descending: true)
//           .get();
//       posts.value = snapshot.docs
//           .map((doc) => doc.data() as Map<String, dynamic>)
//           .toList();
//     } catch (e) {
//       print("Failed to fetch posts: $e");
//     }
//   }
// }
//
// class ProfileScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final ProfileVideoController controller = Get.put(ProfileVideoController());
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Obx(() {
//           return Text(
//             controller.isLoading.value
//                 ? 'Loading...'
//                 : controller.userProfile['username'] ?? '',
//             style: TextStyle(
//                 color: Colors.black, fontWeight: FontWeight.bold),
//           );
//         }),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.add_box_outlined, color: Colors.black),
//             onPressed: () {
//               // Add new post action
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.menu, color: Colors.black),
//             onPressed: () {
//               // Show settings menu
//             },
//           ),
//         ],
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return Center(
//             child: SpinKitFadingCircle(
//               color: Colors.black,
//               size: 50.0,
//             ),
//           );
//         }
//
//         return SingleChildScrollView(
//           child: Column(
//             children: [
//               // User Profile Section
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Row(
//                   children: [
//                     controller.userProfile['profileImage'] != null
//                         ? CircleAvatar(
//                       radius: 55,
//                       backgroundImage: NetworkImage(
//                           controller.userProfile['profileImage'] ?? ''),
//                     )
//                         : SpinKitFadingCircle(
//                       color: Colors.black,
//                       size: 55.0,
//                     ),
//                     SizedBox(width: 20),
//                     Expanded(
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               Column(
//                                 children: [
//                                   Text(
//                                     '${controller.userProfile['posts']}',
//                                     style: TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                   Text("Posts",
//                                       style: TextStyle(color: Colors.grey)),
//                                 ],
//                               ),
//                               Column(
//                                 children: [
//                                   Text(
//                                     '${controller.userProfile['followers']}',
//                                     style: TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                   Text("Followers",
//                                       style: TextStyle(color: Colors.grey)),
//                                 ],
//                               ),
//                               Column(
//                                 children: [
//                                   Text(
//                                     '${controller.userProfile['following']}',
//                                     style: TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                   Text("Following",
//                                       style: TextStyle(color: Colors.grey)),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 10),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: ElevatedButton(
//                                   onPressed: () {
//                                     // Edit profile action
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     foregroundColor: Colors.black, backgroundColor: Colors.white,
//                                     side: BorderSide(color: Colors.grey),
//                                   ),
//                                   child: Text("Edit Profile"),
//                                 ),
//                               ),
//                               SizedBox(width: 5),
//                               Container(
//                                 decoration: BoxDecoration(
//                                   border: Border.all(color: Colors.grey),
//                                   borderRadius: BorderRadius.circular(5),
//                                   color: Colors.white,
//                                 ),
//                                 child: IconButton(
//                                   icon: Icon(Icons.person_add,
//                                       color: Colors.black),
//                                   onPressed: () {
//                                     // Add friend or follow action
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               // Bio Section
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     controller.userProfile['bio'] ?? '',
//                     style: TextStyle(color: Colors.black),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//               // Posts Grid
//               Divider(),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: GridView.builder(
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 3,
//                     crossAxisSpacing: 4.0,
//                     mainAxisSpacing: 4.0,
//                   ),
//                   itemCount: controller.posts.length,
//                   itemBuilder: (context, index) {
//                     final post = controller.posts[index];
//                     return GestureDetector(
//                       onTap: () {
//                         Get.to(() => FullscreenVideoPlayer(videoUrl: post['mediaUrl'] ?? ''));
//                       },
//                       child: Image.network(
//                         post['mediaUrl'] ?? '',
//                         fit: BoxFit.cover,
//                         loadingBuilder: (context, child, loadingProgress) {
//                           if (loadingProgress == null) return child;
//                           return Center(
//                             child: SpinKitFadingCircle(
//                               color: Colors.black,
//                               size: 50.0,
//                             ),
//                           );
//                         },
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }
//
// class FullscreenVideoPlayer extends StatefulWidget {
//   final String videoUrl;
//
//   FullscreenVideoPlayer({required this.videoUrl});
//
//   @override
//   _FullscreenVideoPlayerState createState() => _FullscreenVideoPlayerState();
// }
//
// class _FullscreenVideoPlayerState extends State<FullscreenVideoPlayer> {
//   late VideoPlayerController _videoPlayerController;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeVideo();
//   }
//
//   Future<void> _initializeVideo() async {
//     _videoPlayerController = VideoPlayerController.network(widget.videoUrl)
//       ..initialize().then((_) {
//         setState(() {}); // Update state when the video is initialized
//         _videoPlayerController.play();
//       });
//   }
//
//   @override
//   void dispose() {
//     _videoPlayerController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           Center(
//             child: GestureDetector(
//               onTap: () {
//                 setState(() {
//                   if (_videoPlayerController.value.isPlaying) {
//                     _videoPlayerController.pause();
//                   } else {
//                     _videoPlayerController.play();
//                   }
//                 });
//               },
//               child: _videoPlayerController.value.isInitialized
//                   ? AspectRatio(
//                 aspectRatio: _videoPlayerController.value.aspectRatio,
//                 child: VideoPlayer(_videoPlayerController),
//               )
//                   : Center(
//                 child: SpinKitFadingCircle(
//                   color: Colors.white,
//                   size: 50.0,
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             top: 40.0,
//             left: 10.0,
//             child: IconButton(
//               icon: Icon(Icons.close, color: Colors.white),
//               onPressed: () {
//                 Get.back();
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }





class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<String> videoUrls = [];

  @override
  void initState() {
    super.initState();
    _loadVideoUrls();
  }

  Future<void> _loadVideoUrls() async {
    List<String> fetchedVideoUrls = await fetchVideoUrls();
    setState(() {
      videoUrls = fetchedVideoUrls;
    });
  }

  Future<List<String>> fetchVideoUrls() async {
    List<String> videoUrls = [];
    final storageRef = FirebaseStorage.instance.ref();
    final videoRef = storageRef.child('videos');
    final videoList = await videoRef.listAll();
    for (var item in videoList.items) {
      final videoUrl = await item.getDownloadURL();
      videoUrls.add(videoUrl);
    }
    return videoUrls;
  }

  List<Widget> _buildPages() {
    return [
      ProfileScreen(),
      SearchScreen(),
      ReelsScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [IconButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => PostView(onPost: (p0) {

        },),));
      }, icon: Icon(Icons.add_box))],),
      body: _buildPages()[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_collection),
            label: 'Reels',
          ),
        ],
      ),
    );
  }
}

class ProfileVideoController extends GetxController {

  var isLoading = true.obs;
  var posts = <Map<String, dynamic>>[].obs;
  var userProfile = {}.obs;
  var isPlaying = true.obs;
  var isLiked = false.obs;
  var likeCount = 0.obs;
  var comments = <Map<String, String>>[].obs;
  late String videoUrl;
  late String videoId;
  late String caption;
  late String name;

  @override
  void onInit() {
    fetchUserProfile();
    fetchPosts();
    super.onInit();
  }

  Future<void> _fetchUserProfile() async {
    try {
      // Replace 'userId' with the actual user ID or fetch it dynamically
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc('userId').get();
      if (doc.exists) {
        userProfile.value = doc.data() as Map<String, dynamic>;
        print('User Profile Data: ${userProfile.value}');  // Debugging line
        _fetchPosts();
      } else {
        print('No such document exists');
      }
    } catch (error) {
      print('Error fetching user profile: $error');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _fetchPosts() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('posts').where('userId', isEqualTo: 'userId').get();
      posts.value = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      print('Posts Data: ${posts.value}');  // Debugging line
    } catch (error) {
      print('Error fetching posts: $error');
    }
  }
  Future<void> fetchUserProfile() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc('user_id').get(); // Replace 'user_id' with actual user ID
      userProfile.value = snapshot.data() as Map<String, dynamic>;
    } catch (e) {
      print("Failed to fetch user profile: $e");
    }
  }

  Future<void> fetchPosts() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('posts')
          .orderBy('timestamp', descending: true)
          .get();
      posts.value = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      isLoading.value = false;
    } catch (e) {
      print("Failed to fetch posts: $e");
      isLoading.value = false;
    }
  }

  void fetchVideoData() async {
    try {
      final doc = await FirebaseFirestore.instance.collection('videos').doc(videoId).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        isLiked.value = data['isLiked'] ?? false;
        likeCount.value = data['likeCount'] ?? 0;
        comments.assignAll(List<Map<String, String>>.from(data['comments'] ?? []));
      }
    } catch (e) {
      print("Failed to fetch video data: $e");
    }
  }

  void togglePlayPause() {
    isPlaying.value = !isPlaying.value;
  }

  void toggleLike() {
    isLiked.value = !isLiked.value;
    likeCount.value += isLiked.value ? 1 : -1;
    // Update Firestore logic here
  }

  void addComment(String comment) {
    comments.add({
      'name': 'User',
      'image': 'https://example.com/user_image.png',
      'comment': comment,
    });
    // Update Firestore logic here
  }
}

// class ProfileScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final ProfileVideoController controller = Get.put(ProfileVideoController());
//
//     return Scaffold(
//       appBar: AppBar(
//         title:  Text(
//           controller.userProfile['name'] ?? 'Name',
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return Center(
//             child: SpinKitFadingCircle(
//               color: Colors.white,
//               size: 50.0,
//             ),
//           );
//         }
//
//         return Column(
//           children: [
//             // User Profile Section
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CircleAvatar(
//                     radius: 55,
//                     backgroundImage: NetworkImage(controller.userProfile['profileImage'] ?? ''),
//                   ),
//                   SizedBox(width: 16),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//
//                         SizedBox(height: 8),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             _buildProfileStat('Posts', controller.posts.length),
//                             _buildProfileStat('Followers', controller.userProfile['followers'] ?? 0),
//                             _buildProfileStat('Following', controller.userProfile['following'] ?? 0),
//                           ],
//                         ),
//                         SizedBox(height: 16),
//
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//
//
//                 Container(decoration: BoxDecoration(border: Border.all(color: Colors.black),borderRadius: BorderRadius.circular(20)),
//                   child: TextButton(onPressed: () {
//                     Navigator.push(context, MaterialPageRoute(builder: (context) => AccountScreen(),));
//                   }, child: Text("Account Setting",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),)),
//                 ),
//
//
//                 Container(decoration: BoxDecoration(border: Border.all(color: Colors.black),borderRadius: BorderRadius.circular(20)),
//                   child: TextButton(onPressed: () {
//                     Navigator.push(context, MaterialPageRoute(builder: (context) => PostViews(onPost: (p0) {
//
//                     },),));
//                   }, child: Text("Edit profile",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),)),
//                 ),
//               ],
//             ),
//
//             Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: Divider(color: Colors.grey,),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(right: 300),
//               child: Text("POST",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w500),),
//             ),
//             Expanded(
//               child: GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   crossAxisSpacing: 4.0,
//                   mainAxisSpacing: 4.0,
//                 ),
//                 itemCount: controller.posts.length,
//                 itemBuilder: (context, index) {
//                   final post = controller.posts[index];
//                   return GestureDetector(
//                     onTap: () {
//                       controller.videoUrl = post['mediaUrl'] ?? '';
//                       controller.videoId = post['videoId'] ?? ''; // Replace with actual ID
//                       controller.caption = post['caption'] ?? 'Sample caption';
//                       controller.fetchVideoData();
//                       Get.to(() => FullscreenVideoPlayer(controller: controller));
//                     },
//                     child: Image.network(
//                       post['mediaUrl'] ?? '',
//                       fit: BoxFit.cover,
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         );
//       }),
//     );
//   }
//
//   Widget _buildProfileStat(String label, int count) {
//     return Column(
//       children: [
//         Text(
//           '$count',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         Text(
//           label,
//           style: TextStyle(fontWeight: FontWeight.w500),
//         ),
//       ],
//     );
//   }
// }





class ProfileVideoControllers extends GetxController {
  var isLoading = true.obs;
  var userProfile = {}.obs;
  var posts = [].obs;

  @override
  void onInit() {
    super.onInit();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc('userId').get();
      if (doc.exists) {
        userProfile.value = doc.data() as Map<String, dynamic>;
        print('User Profile Data: ${userProfile.value}'); // Debug print
        _fetchPosts();  // Optionally fetch posts
      } else {
        print('User document does not exist');
      }
    } catch (error) {
      print('Error fetching user profile: $error');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _fetchPosts() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('posts').where('userId', isEqualTo: 'userId').get();
      posts.value = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      print('Posts Data: ${posts.value}');  // Debug print
    } catch (error) {
      print('Error fetching posts: $error');
    }
  }
}


class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProfileVideoController controller = Get.put(ProfileVideoController());

    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          final name = controller.userProfile['name'] as String?;
          return Text(
            name ?? 'Name',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          );
        }),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: SpinKitFadingCircle(
              color: Colors.white,
              size: 50.0,
            ),
          );
        }

        final profileImage = controller.userProfile['profileImage'] as String?;
        final userName = controller.userProfile['name'] as String?;
        final followers = controller.userProfile['followers'] as int? ?? 0;
        final following = controller.userProfile['following'] as int? ?? 0;

        return Column(
          children: [
            // User Profile Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundImage: profileImage != null && profileImage.isNotEmpty
                        ? NetworkImage(profileImage)
                        : AssetImage('assets/default_profile_image.png') as ImageProvider, // Default image
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName ?? 'Name',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildProfileStat('Posts', controller.posts.length),
                            _buildProfileStat('Followers', followers),
                            _buildProfileStat('Following', following),
                          ],
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LogoutScreen()),
                      );
                    },
                    child: Text(
                      "Account Setting",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfileScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Edit profile",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Divider(color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                "POST",
                style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemCount: controller.posts.length,
                itemBuilder: (context, index) {
                  final post = controller.posts[index];
                  return GestureDetector(
                    onTap: () {
                      controller.videoUrl = post['mediaUrl'] ?? '';
                      controller.videoId = post['videoId'] ?? ''; // Replace with actual ID
                      controller.caption = post['caption'] ?? 'Sample caption';
                      controller.fetchVideoData();
                      Get.to(() => FullscreenVideoPlayer(controller: controller));
                    },
                    child: Image.network(
                      post['mediaUrl'] ?? '',
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildProfileStat(String label, int count) {
    return Column(
      children: [
        Text(
          '$count',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}



class FullscreenVideoPlayer extends StatefulWidget {
  final ProfileVideoController controller;

  FullscreenVideoPlayer({required this.controller});

  @override
  _FullscreenVideoPlayerState createState() => _FullscreenVideoPlayerState();
}

class _FullscreenVideoPlayerState extends State<FullscreenVideoPlayer> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    _videoPlayerController = VideoPlayerController.network(widget.controller.videoUrl)
      ..initialize().then((_) {
        setState(() {}); // Update state when the video is initialized
        if (widget.controller.isPlaying.value) {
          _videoPlayerController.play();
        }
      });
    _videoPlayerController.addListener(() {
      setState(() {
        widget.controller.isPlaying.value = _videoPlayerController.value.isPlaying;
      });
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: GestureDetector(
              onTap: () => widget.controller.togglePlayPause(),
              child: _videoPlayerController.value.isInitialized
                  ? AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController),
              )
                  : Center(
                child: SpinKitFadingCircle(
                  color: Colors.grey,
                  size: 30.0,
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Get.back(),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 10,
            right: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.controller.caption, style: TextStyle(color: Colors.white, fontSize: 18)),
                Obx(() {
                  return Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              widget.controller.isLiked.value ? Icons.favorite : Icons.favorite_border,
                              color: widget.controller.isLiked.value ? Colors.red : Colors.white,
                            ),
                            onPressed: () => widget.controller.toggleLike(),
                          ),
                          Text('${widget.controller.likeCount.value}', style: TextStyle(color: Colors.black)),
                          IconButton(
                            icon: Icon(Icons.comment, color: Colors.white),
                            onPressed: () {
                              // Show comments dialog
                            },
                          ),
                          Text('${widget.controller.comments.length}', style: TextStyle(color: Colors.black)),
                        ],
                      ),
                      // Display comments list
                    ],
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
