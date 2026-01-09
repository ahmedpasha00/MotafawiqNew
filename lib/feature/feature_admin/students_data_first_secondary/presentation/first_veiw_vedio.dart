import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/animate_gradient.dart';
import '../../upload_video/data/models/video_model.dart';
import 'first_video_player_screen.dart';

class FirstViewVideo extends StatelessWidget {
  const FirstViewVideo({super.key});

  @override
  Widget build(BuildContext context) {
    // تجميع الفيديوهات حسب الوحدة
    final Map<String, List<VideoModel>> videosByUnit = {};
    for (var video in videos) {
      if (!videosByUnit.containsKey(video.unit)) {
        videosByUnit[video.unit] = [];
      }
      videosByUnit[video.unit]!.add(video);
    }

    return Scaffold(
      body: Stack(
        children: [
          AnimateGradientu(child: Scaffold()),

          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Column(
                children: videosByUnit.entries.map((entry) {
                  final unitName = entry.key;
                  final unitVideos = entry.value;

                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r)),
                    margin:
                    EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                    elevation: 4,
                    child: ExpansionTile(
                      tilePadding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      title: Text(
                        unitName,
                        style: TextStyle(
                            fontSize: 22.sp, fontWeight: FontWeight.bold),
                      ),
                      children: unitVideos.map((video) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 4.h),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r)),
                            color: Colors.grey.shade900.withOpacity(0.6),
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 8.h),
                              leading: video.isVideo
                                  ? Icon(Icons.play_circle_fill,
                                  color: Colors.pink, size: 30)
                                  : Icon(Icons.image,
                                  color: Colors.orange, size: 30),
                              title: Text(
                                video.title,
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                              subtitle: Text(
                                "المدة: ${video.duration}",
                                style: TextStyle(color: Colors.white70),
                              ),
                              onTap: () {
                                // عرض الفيديو في صفحة جديدة
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => VideoPlayerScreen(
                                        fileUrl: video.videoUrl),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// ================== بيانات تجريبية ==================
List<VideoModel> videos = [
  VideoModel(
      title: "درس 1",
      grade: "الأول الثانوي",
      unit: "الوحدة 1",
      duration: "10:00",
      videoUrl: "...",
      isVideo: true),
  VideoModel(
      title: "درس 2",
      grade: "الأول الثانوي",
      unit: "الوحدة 1",
      duration: "12:00",
      videoUrl: "...",
      isVideo: true),
  VideoModel(
      title: "درس 1",
      grade: "الأول الثانوي",
      unit: "الوحدة 2",
      duration: "08:00",
      videoUrl: "...",
      isVideo: true),
];
