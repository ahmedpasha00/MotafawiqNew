//دي الصفحه الرسيه\

import 'package:animated_background/animated_background.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/widgets/floating_image.dart';
import '../../../core/widgets/thinking_toggle_page.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ThinkingButtonToggle(),
    );
  }
}





