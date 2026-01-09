import 'package:cloud_firestore/cloud_firestore.dart';

class VideoModel {
  final String title;
  final String grade;
  final String unit;
  final String duration;
  final String videoUrl;
  final bool isVideo;

  VideoModel({
    required this.title,
    required this.grade,
    required this.unit,
    required this.duration,
    required this.videoUrl,
    required this.isVideo,
  });

  Map<String, dynamic> toMap() => {
    "title": title,
    "grade": grade,
    "unit": unit,
    "duration": duration,
    "videoUrl": videoUrl,
    "isVideo": isVideo,
    "createdAt": FieldValue.serverTimestamp(),
  };

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      title: map["title"],
      grade: map["grade"],
      unit: map["unit"],
      duration: map["duration"],
      videoUrl: map["videoUrl"],
      isVideo: map["isVideo"] ?? true,
    );
  }
}
