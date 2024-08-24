import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String id;
  final String userId;
  final String mediaUrl;
  final String title;
  late final String caption;
  final Timestamp timestamp;
  final String userName;
  final String userImage;
  final List<String> likes;  // List of user IDs who liked the post
  final List<Map<String, dynamic>> comments;  // List of comments

  PostModel({
    required this.id,
    required this.userId,
    required this.mediaUrl,
    required this.title,
    required this.caption,
    required this.timestamp,
    required this.userName,
    required this.userImage,
    required this.likes,
    required this.comments,
  });

  // Factory method to create a PostModel from Firestore document snapshot
  factory PostModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PostModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      mediaUrl: data['mediaUrl'] ?? '',
      title: data['title'] ?? '',
      caption: data['caption'] ?? '',
      timestamp: data['timestamp'] as Timestamp,
      userName: data['userName'] ?? 'Unknown',
      userImage: data['userImage'] ?? 'https://example.com/default_user_image.png',
      likes: data['likes'] != null ? List<String>.from(data['likes']) : [],
      comments: data['comments'] != null ? List<Map<String, dynamic>>.from(data['comments']) : [],
    );
  }

  // Method to convert PostModel to a Map
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'mediaUrl': mediaUrl,
      'title': title,
      'caption': caption,
      'timestamp': timestamp,
      'userName': userName,
      'userImage': userImage,
      'likes': likes,
      'comments': comments,
    };
  }
}
