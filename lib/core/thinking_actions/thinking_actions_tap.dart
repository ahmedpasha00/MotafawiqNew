import 'package:al_motafawiq/feature/chat_ai/data/cubit/chat_cubit.dart';
import 'package:al_motafawiq/feature/chat_ai/data/repo/chat_repository.dart';
import 'package:al_motafawiq/feature/chat_ai/preasentation/chat_ai_screen.dart';
import 'package:al_motafawiq/feature/dashboard/preasntation/cubit/dashboard_cubit.dart';
import 'package:al_motafawiq/feature/dashboard/preasntation/data/repo/dashboard_repo.dart';
import 'package:al_motafawiq/feature/enrolled_courses/preasntation/enrolled_courses_screen.dart';
import 'package:al_motafawiq/feature/live_stream/presentation/live_stream_screen.dart';
import 'package:al_motafawiq/feature/my_courses/preasntation/my_courses_screen.dart';
import 'package:al_motafawiq/feature/sittengs/presentation/setting_screen.dart';
import 'package:al_motafawiq/feature/teacher_student_chat/presentation/teacher_student_chat_screen.dart';
import 'package:al_motafawiq/feature/top10/preasntation/top10_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../feature/dashboard/preasntation/dashboard_screen.dart';
import '../../feature/logout/preasntation/logout_screen.dart';
import '../../feature/profile/presentation/profile_screen.dart';
import '../../feature/view_details/preasntation/view_details_screen.dart';
import '../model/thinking_action.dart';

List<ThinkingAction> thinkingAction = [
  ThinkingAction(
    titter: "الملف الشخصي".tr(),
    icon: Icons.person,
    page: ProfileScreen(),
  ),
  ThinkingAction(
    titter: "لوحة التحكم".tr(),
    icon: Icons.dashboard,
    page: BlocProvider(
      create: (context) =>
      DashboardCubit(
        DashboardRepo(FirebaseFirestore.instance, FirebaseAuth.instance),
      )
        ..getStudentData(),
      child: DashboardScreen(),
    ),
  ),
  ThinkingAction(
    titter: "كورساتي".tr(),
    icon: Icons.video_camera_back,
    page: MyCoursesScreen(),
  ),
  ThinkingAction(
    titter: "الكورسات الغير مشترك بها".tr(),
    icon: Icons.insights,
    page: EnrolledCoursesScreen(),
  ),
  ThinkingAction(
    titter: "أعلى 10".tr(),
    icon: Icons.star,
    page: Top10Screen(),
  ),
  ThinkingAction(
    titter: "تفاصيل المشاهدة".tr(),
    icon: Icons.remove_red_eye,
    page: ViewDetailsScreen(),
  ),
  ThinkingAction(
    titter: "تسجيل الخروج".tr(),
    icon: Icons.logout,
    page: LogoutScreen(),
  ),
  ThinkingAction(
    titter: "الإعدادات".tr(),
    icon: Icons.settings,
    page: SettingScreen(),
  ),
  ThinkingAction(
    titter: "دردشة بين المدرس والطالب".tr(),
    icon: Icons.wechat_outlined,
    page: TeacherStudentChatScreen(),
  ),


  ThinkingAction(
    titter: "شات ذكاء اصطناعي".tr(),
    icon: Icons.chat_outlined,
    page: BlocProvider(
      create: (context) => ChatCubit(ChatRepository()),
      child: ChatScreen(),
    ),
  ),
  ThinkingAction(
    titter: "بث مباشر".tr(),
    icon: Icons.live_tv_rounded,
    page: LiveStreamScreen(),
  ),
];
