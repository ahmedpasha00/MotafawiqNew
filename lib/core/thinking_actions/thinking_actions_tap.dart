



import 'package:al_motafawiq/feature/enrolled_courses/preasntation/enrolled_courses_screen.dart';
import 'package:al_motafawiq/feature/my_courses/preasntation/my_courses_screen.dart';
import 'package:al_motafawiq/feature/top10/preasntation/top10_screen.dart';
import 'package:flutter/material.dart';

import '../../feature/dashboard/preasntation/dashboard_screen.dart';
import '../../feature/logout/preasntation/logout_screen.dart';
import '../../feature/profile/presentation/profile_screen.dart';
import '../../feature/view_details/preasntation/view_details_screen.dart';
import '../model/thinking_action.dart';

List<ThinkingAction> thinkingAction =[
  ThinkingAction(titter: "الملف الشخصي", icon: Icons.person, page: ProfileScreen()),
  ThinkingAction(titter: "لوحة التحكم", icon: Icons.dashboard, page: DashboardScreen()),
  ThinkingAction(titter: "كورساتي", icon: Icons.video_camera_back, page: MyCoursesScreen()),
  ThinkingAction(titter: "الكورسات الغير مشترك بها", icon: Icons.insights, page: EnrolledCoursesScreen()),
  ThinkingAction(titter: "أعلى 10", icon: Icons.star, page: Top10Screen()), // أضف أعلى 10
  ThinkingAction(titter: "تفاصيل المشاهدة", icon: Icons.remove_red_eye, page: ViewDetailsScreen()), // تفاصيل المشاهدة
  ThinkingAction(titter: "تسجيل الخروج", icon: Icons.logout, page: LogoutScreen()), // كبير في الآخر

];
