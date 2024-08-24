// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:video_player/video_player.dart';
// import '../../controllers/instra_controller/instra_controller_screen.dart';
//
// class SearchScreenes extends StatefulWidget {
//   @override
//   _SearchScreenesState createState() => _SearchScreenesState();
// }
//
// class _SearchScreenesState extends State<SearchScreenes> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final TextEditingController _searchController = TextEditingController();
//   final InstraControllerScreen _videoController = Get.put(InstraControllerScreen());
//   RxList<Map<String, dynamic>> _posts = <Map<String, dynamic>>[].obs;
//   RxList<Map<String, dynamic>> _filteredPosts = <Map<String, dynamic>>[].obs;
//   var isLoading = true.obs;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchPosts();
//   }
//
//   Future<void> _fetchPosts() async {
//     try {
//       QuerySnapshot snapshot = await _firestore.collection('posts').orderBy('timestamp', descending: true).get();
//       List<Map<String, dynamic>> posts = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
//       _posts.assignAll(posts);
//       _filteredPosts.assignAll(posts);
//       isLoading.value = false;
//     } catch (e) {
//       print("Failed to fetch posts: $e");
//       isLoading.value = false;
//     }
//   }
//
//   void _filterPosts(String query) {
//     List<Map<String, dynamic>> filtered = _posts.where((post) {
//       String title = post['title']?.toLowerCase() ?? '';
//       return title.contains(query.toLowerCase());
//     }).toList();
//
//     _filteredPosts.assignAll(filtered);
//   }
//
//   void _openFullscreenVideo(String videoUrl, String videoId, String caption) {
//     Get.to(() => FullscreenVideoPlayer(
//       videoUrl: videoUrl,
//       videoId: videoId,
//       caption: caption,
//     ));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           SizedBox(height: 40),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 18),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: 'Search...',
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20.0),
//                 ),
//               ),
//               onChanged: _filterPosts,
//             ),
//           ),
//           Obx(() => isLoading.value
//               ? Center(
//             child: SpinKitFadingCircle(
//               color: Colors.grey,
//               size: 30.0,
//             ),
//           )
//               : Expanded(
//             child: GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3,
//                 crossAxisSpacing: 4.0,
//                 mainAxisSpacing: 4.0,
//                 childAspectRatio: 0.7,
//               ),
//               itemCount: _filteredPosts.length,
//               itemBuilder: (context, index) {
//                 final post = _filteredPosts[index];
//                 return GestureDetector(
//                   onTap: () => _openFullscreenVideo(
//                     post['mediaUrl'] ?? '',
//                     post['videoId'] ?? '',
//                     post['caption'] ?? '',
//                   ),
//                   child: VideoThumbnailes(
//                     videoUrl: post['mediaUrl'] ?? '',
//                     height: 222,
//                   ),
//                 );
//               },
//             ),
//           ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
// class VideoThumbnailes extends StatefulWidget {
//   final String videoUrl;
//   final double height;
//
//   VideoThumbnailes({required this.videoUrl, required this.height});
//
//   @override
//   _VideoThumbnailesState createState() => _VideoThumbnailesState();
// }
//
// class _VideoThumbnailesState extends State<VideoThumbnailes> {
//   late VideoPlayerController _controller;
//   bool _isPlaying = false;
//   bool _isInitialized = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(widget.videoUrl)
//       ..initialize().then((_) {
//         setState(() {
//           _isInitialized = true;
//         });
//       });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   void _togglePlayPause() {
//     setState(() {
//       if (_controller.value.isPlaying) {
//         _controller.pause();
//         _isPlaying = false;
//       } else {
//         _controller.play();
//         _isPlaying = true;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         _isInitialized
//             ? VideoPlayer(_controller)
//             : Center(
//           child: SpinKitFadingCircle(
//             color: Colors.grey,
//             size: 30.0,
//           ),
//         ),
//         if (!_isPlaying && _isInitialized) // Only show the play button if not playing
//           Positioned(
//             right: 10,
//             top: 10,
//             child: Icon(
//               Icons.play_arrow,
//               color: Colors.white,
//               size: 50,
//             ),
//           ),
//       ],
//     );
//   }
// }
//
//
// class FullscreenVideoPlayer extends StatefulWidget {
//   final String videoUrl;
//   final String videoId;
//   final String caption;
//
//   FullscreenVideoPlayer({
//     required this.videoUrl,
//     required this.videoId,
//     required this.caption,
//   });
//
//   @override
//   _FullscreenVideoPlayerState createState() => _FullscreenVideoPlayerState();
// }
//
// class _FullscreenVideoPlayerState extends State<FullscreenVideoPlayer> {
//   late VideoPlayerController _controller;
//   bool _isPlaying = false;
//   bool _isInitialized = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(widget.videoUrl)
//       ..initialize().then((_) {
//         setState(() {
//           _isInitialized = true;
//         });
//       });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   void _togglePlayPause() {
//     setState(() {
//       if (_controller.value.isPlaying) {
//         _controller.pause();
//         _isPlaying = false;
//       } else {
//         _controller.play();
//         _isPlaying = true;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: _isInitialized
//             ? Stack(
//           alignment: Alignment.center,
//           children: [
//             VideoPlayer(_controller),
//             _isPlaying
//                 ? SizedBox.shrink() // Hide play button when video is playing
//                 : IconButton(
//               icon: Icon(
//                 Icons.play_arrow,
//                 color: Colors.white,
//                 size: 50,
//               ),
//               onPressed: _togglePlayPause,
//             ),
//           ],
//         )
//             : Center(
//           child: SpinKitFadingCircle(
//             color: Colors.white,
//             size: 50.0,
//           ),
//         ),
//       ),
//       bottomNavigationBar: _isInitialized
//           ? BottomAppBar(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Text(
//                   widget.caption,
//                   style: TextStyle(color: Colors.white),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//               IconButton(
//                 icon: Icon(Icons.fullscreen_exit, color: Colors.white),
//                 onPressed: () => Navigator.of(context).pop(), // Close full screen
//               ),
//             ],
//           ),
//         ),
//       )
//           : null,
//     );
//   }
// }



//
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:video_player/video_player.dart';
// import '../../controllers/instra_controller/instra_controller_screen.dart';
//
// class SearchScreenes extends StatefulWidget {
//   @override
//   _SearchScreenesState createState() => _SearchScreenesState();
// }
//
// class _SearchScreenesState extends State<SearchScreenes> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final TextEditingController _searchController = TextEditingController();
//   RxList<Map<String, dynamic>> _posts = <Map<String, dynamic>>[].obs;
//   RxList<Map<String, dynamic>> _filteredPosts = <Map<String, dynamic>>[].obs;
//   var isLoading = true.obs;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchPosts();
//   }
//
//   Future<void> _fetchPosts() async {
//     try {
//       QuerySnapshot snapshot = await _firestore.collection('posts').orderBy('timestamp', descending: true).get();
//       List<Map<String, dynamic>> posts = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
//       _posts.assignAll(posts);
//       _filteredPosts.assignAll(posts);
//       isLoading.value = false;
//     } catch (e) {
//       print("Failed to fetch posts: $e");
//       isLoading.value = false;
//     }
//   }
//
//   void _filterPosts(String query) {
//     List<Map<String, dynamic>> filtered = _posts.where((post) {
//       String title = post['title']?.toLowerCase() ?? '';
//       return title.contains(query.toLowerCase());
//     }).toList();
//
//     _filteredPosts.assignAll(filtered);
//   }
//
//   void _openFullscreenVideo(String videoUrl, String videoId, String caption) {
//     Get.to(() => FullscreenVideoPlayer(
//       videoUrl: videoUrl,
//       videoId: videoId,
//       caption: caption,
//     ));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           SizedBox(height: 40),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 18),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: 'Search...',
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20.0),
//                 ),
//               ),
//               onChanged: _filterPosts,
//             ),
//           ),
//           Obx(() => isLoading.value
//               ? Center(
//             child: SpinKitFadingCircle(
//               color: Colors.grey,
//               size: 30.0,
//             ),
//           )
//               : Expanded(
//             child: GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3,
//                 crossAxisSpacing: 4.0,
//                 mainAxisSpacing: 4.0,
//                 childAspectRatio: 0.7,
//               ),
//               itemCount: _filteredPosts.length,
//               itemBuilder: (context, index) {
//                 final post = _filteredPosts[index];
//                 return GestureDetector(
//                   onTap: () => _openFullscreenVideo(
//                     post['mediaUrl'] ?? '',
//                     post['videoId'] ?? '',
//                     post['caption'] ?? '',
//                   ),
//                   child: VideoThumbnailes(
//                     videoUrl: post['mediaUrl'] ?? '',
//                     height: 222,
//                   ),
//                 );
//               },
//             ),
//           ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class VideoThumbnailes extends StatefulWidget {
//   final String videoUrl;
//   final double height;
//
//   VideoThumbnailes({required this.videoUrl, required this.height});
//
//   @override
//   _VideoThumbnailesState createState() => _VideoThumbnailesState();
// }
//
// class _VideoThumbnailesState extends State<VideoThumbnailes> {
//   late VideoPlayerController _controller;
//   bool _isPlaying = false;
//   bool _isInitialized = false;
//   bool _hasError = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(widget.videoUrl)
//       ..initialize().then((_) {
//         setState(() {
//           _isInitialized = true;
//           _hasError = false;
//         });
//       }).catchError((error) {
//         print("Error initializing video player: $error");
//         setState(() {
//           _isInitialized = true;
//           _hasError = true;
//         });
//       });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   void _togglePlayPause() {
//     setState(() {
//       if (_controller.value.isPlaying) {
//         _controller.pause();
//         _isPlaying = false;
//       } else {
//         _controller.play();
//         _isPlaying = true;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (_hasError) {
//       return Center(child: Text("Error loading video", style: TextStyle(color: Colors.red)));
//     }
//
//     return Stack(
//       children: [
//         _isInitialized
//             ? VideoPlayer(_controller)
//             : Center(
//           child: SpinKitFadingCircle(
//             color: Colors.grey,
//             size: 30.0,
//           ),
//         ),
//         if (!_isPlaying && _isInitialized) // Only show the play button if not playing
//           Positioned(
//             right: 10,
//             top: 10,
//             child: Icon(
//               Icons.play_arrow,
//               color: Colors.white,
//               size: 50,
//             ),
//           ),
//       ],
//     );
//   }
// }
//
// class FullscreenVideoPlayer extends StatefulWidget {
//   final String videoUrl;
//   final String videoId;
//   final String caption;
//
//   FullscreenVideoPlayer({
//     required this.videoUrl,
//     required this.videoId,
//     required this.caption,
//   });
//
//   @override
//   _FullscreenVideoPlayerState createState() => _FullscreenVideoPlayerState();
// }
//
// class _FullscreenVideoPlayerState extends State<FullscreenVideoPlayer> {
//   late VideoPlayerController _controller;
//   bool _isPlaying = false;
//   bool _isInitialized = false;
//   bool _hasError = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(widget.videoUrl)
//       ..initialize().then((_) {
//         setState(() {
//           _isInitialized = true;
//           _hasError = false;
//         });
//       }).catchError((error) {
//         print("Error initializing video player: $error");
//         setState(() {
//           _isInitialized = true;
//           _hasError = true;
//         });
//       });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   void _togglePlayPause() {
//     setState(() {
//       if (_controller.value.isPlaying) {
//         _controller.pause();
//         _isPlaying = false;
//       } else {
//         _controller.play();
//         _isPlaying = true;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (_hasError) {
//       return Scaffold(
//         backgroundColor: Colors.black,
//         body: Center(child: Text("Error loading video", style: TextStyle(color: Colors.red))),
//       );
//     }
//
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: _isInitialized
//             ? Stack(
//           alignment: Alignment.center,
//           children: [
//             VideoPlayer(_controller),
//             _isPlaying
//                 ? SizedBox.shrink() // Hide play button when video is playing
//                 : IconButton(
//               icon: Icon(
//                 Icons.play_arrow,
//                 color: Colors.white,
//                 size: 50,
//               ),
//               onPressed: _togglePlayPause,
//             ),
//           ],
//         )
//             : Center(
//           child: SpinKitFadingCircle(
//             color: Colors.black,
//             size: 50.0,
//           ),
//         ),
//       ),
//       bottomNavigationBar: _isInitialized
//           ? BottomAppBar(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Text(
//                   widget.caption,
//                   style: TextStyle(color: Colors.black),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//               IconButton(
//                 icon: Icon(Icons.fullscreen_exit, color: Colors.black),
//                 onPressed: () => Navigator.of(context).pop(), // Close full screen
//               ),
//             ],
//           ),
//         ),
//       )
//           : null,
//     );
//   }
// }







import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instragram_application/insragram_application/views/search/search_screen_id_show.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../controllers/instra_controller/instra_class/auth_servies.dart';
import '../../controllers/instra_controller/video_upload_controller.dart';




class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final AuthService _authService = Get.put(AuthService());

  final VideoUploadController _videoController =
  Get.find<VideoUploadController>();
  late List<VideoPlayerController> _controllers;
  late List<bool> _initialized;
  int _currentlyPlayingIndex = -1;

  @override
  void initState() {
    super.initState();
    _initializeVideos();
  }

  Future<void> _initializeVideos() async {
    try {
      await _videoController.fetchVideoUrls();
      setState(() {
        _controllers = _videoController.videoUrls
            .map((url) => VideoPlayerController.network(url))
            .toList();
        _initialized = List.filled(_controllers.length, false);
      });
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
      } catch (error) {
        Get.snackbar(
            'Error', 'Failed to initialize video player at index $i: $error');
      }
    }
  }

  void _playVideo(int index) {
    setState(() {
      if (_currentlyPlayingIndex != -1 && _currentlyPlayingIndex != index) {
        _controllers[_currentlyPlayingIndex].pause();
      }
      _currentlyPlayingIndex = index;
      _controllers[index].play();
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Column(
            children: [
              SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  color: Colors.white30,
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(1))),
                      labelText: 'Search Id',
                      labelStyle: TextStyle(color: Colors.black54),
                      hintStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                    onChanged: (value) {
                      _authService.searchUsers(value);
                      Get.to(SearchScreenIdShow());
                    },
                  ),
                ),
              ),
              Expanded(
                child: Obx(() {
                  if (_videoController.isLoading.value) {
                    return const Center(
                        child: CupertinoActivityIndicator()
                    );
                  } else if (_videoController.videoUrls.isNotEmpty) {
                    return Expanded(
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio:
                            2 / 3.5, // Adjusted aspect ratio to make video larger
                          ),
                          itemCount: _videoController.videoUrls.length,
                          itemBuilder: (context, index) {
                            if (index >= _controllers.length ||
                                index >= _initialized.length) {
                              return const Center(
                                  child: Text('Error: Index out of bounds'));
                            }
                            return VisibilityDetector(
                              key: Key('video_$index'),
                              onVisibilityChanged: (visibilityInfo) {
                                final visiblePercentage =
                                    visibilityInfo.visibleFraction * 100;
                                if (visiblePercentage > 50) {
                                  if (_currentlyPlayingIndex == index &&
                                      !_controllers[index].value.isPlaying) {
                                    _controllers[index].play();
                                  }
                                } else {
                                  if (_currentlyPlayingIndex == index &&
                                      _controllers[index].value.isPlaying) {
                                    _controllers[index].pause();
                                  }
                                }
                              },
                              child: GestureDetector(
                                onTap: () => _playVideo(index),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(
                                    alignment: Alignment.bottomLeft,
                                    children: [
                                      _initialized[index]
                                          ? AspectRatio(
                                        aspectRatio:
                                        _controllers[index].value.aspectRatio,
                                        child: VideoPlayer(_controllers[index]),
                                      )
                                          : Center(
                                          child: CupertinoActivityIndicator()
                                      ),
                                      Positioned(
                                        bottom: 8.0,
                                        left: 8.0,
                                        child: Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 5.0,
                                                ),
                                              ),
                                              child: CircleAvatar(
                                                backgroundImage: _videoController
                                                    .videoProfileImages.length >
                                                    index
                                                    ? NetworkImage(_videoController
                                                    .videoProfileImages[index])
                                                    : NetworkImage(
                                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8NYnGDqrQm-gbf4fbXkaMBzmVLlf2rZdOLA&s"),
                                                backgroundColor: Colors.grey,
                                              ),
                                            ),
                                            SizedBox(width: 8.0),
                                            Text(
                                              _videoController.videoUsernames.length >
                                                  index
                                                  ? _videoController
                                                  .videoUsernames[index]
                                                  : 'Unknown',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (_currentlyPlayingIndex != index &&
                                          !_controllers[index].value.isPlaying)
                                        Positioned.fill(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Icon(
                                              Icons.play_circle,
                                              size: 60,
                                              color: Colors.white.withOpacity(0.8),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ));
                  } else {
                    return Center(child: Text('No videos available'));
                  }
                }),
              ),
            ],
            ),
        );
    }
}
