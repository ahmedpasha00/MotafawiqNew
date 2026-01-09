import 'package:al_motafawiq/core/widgets/container_dashboard.dart';
import 'package:al_motafawiq/core/widgets/cousstom_botton.dart';
import 'package:al_motafawiq/core/widgets/cousttom_containar_Landing.dart';
import 'package:al_motafawiq/feature/feature_admin/core/wigets/cousstom_upload_videos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/animate_gradient.dart';
import '../../upload_video/presentation/upload_screen.dart';

class UploadVideosScreen extends StatelessWidget {
  const UploadVideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimateGradientu(child: Scaffold()),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.0.r),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0.r),
                      child: CousstomUploadVideos(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UploadScreen(),
                            ),
                          );
                        },
                        tittel: "رفع الفيديو", child: Text(""),
                      ),
                    ),

                    SizedBox(height: 380.h),
                    Padding(
                      padding: EdgeInsets.all(16.0.r),
                      child: CousstomBotton(
                        titell: "رجوع",
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
