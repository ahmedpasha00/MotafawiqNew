import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/container_dashboard.dart';

class CousstomUploadVideos extends StatelessWidget {
  final void Function()? onTap;
  final String tittel;


  const CousstomUploadVideos({super.key, this.onTap, required this.tittel, required Widget child,});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      GestureDetector(
      onTap: onTap,
      child: ContainerDashboard(
        minHeight: 200,
        borderRadius: BorderRadius.circular(24.r),
        gradientColors: [
          Colors.blue.shade400,
          Colors.blue.shade900,
        ],
        child: Column(
          children: [
            Text(
             tittel,
              style: TextStyle(
                fontSize: 25.sp,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20.h),
            Icon(Icons.cloud_upload,
              size: 100.r,
              color: Colors.white,
            )
          ],
        ),
      ),
      )
    ]
    );

  }
}
