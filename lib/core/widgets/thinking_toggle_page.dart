import 'package:al_motafawiq/feature/logout/preasntation/logout_screen.dart';
import 'package:al_motafawiq/feature/welcome/presentation/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../feature/auth/preasntation/register_screen.dart';
import '../thinking_actions/thinking_actions_tap.dart';
import 'animate_gradient.dart';
import 'package:easy_localization/easy_localization.dart';

class ThinkingButtonToggle extends StatefulWidget {
  const ThinkingButtonToggle({super.key});

  @override
  _ThinkingButtonToggleState createState() => _ThinkingButtonToggleState();
}

class _ThinkingButtonToggleState extends State<ThinkingButtonToggle>
    with SingleTickerProviderStateMixin {
  bool isOpen = false;

  late AnimationController _controller;
  late Animation<double> scaleAnim;
  late Animation<double> glowAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    scaleAnim = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    glowAnim = Tween<double>(
      begin: 0.0,
      end: 12.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  void toggleContent() {
    setState(() {
      isOpen = !isOpen;
      isOpen ? _controller.forward() : _controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          AnimateGradientu(child: Scaffold()),

          /// المحتوى اللي بيظهر لما الزرار يفتح
          AnimatedOpacity(
            opacity: isOpen ? 1 : 0,
            duration: Duration(milliseconds: 300),
            child: isOpen
                ? SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      SizedBox(height: 180.h),

                      // Grid للأزرار العادية (عدا الخروج)
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: thinkingAction
                            .where((a) => a.titter != "تسجيل الخروج")
                            .length,
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.w,
                          mainAxisSpacing: 12.h,
                          childAspectRatio: 2.5,
                        ),
                        itemBuilder: (context, index) {
                          final action = thinkingAction
                              .where((a) => a.titter != "تسجيل الخروج")
                              .toList()[index];
                          return TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0, end: 1),
                            duration: Duration(
                              milliseconds: 300 + index * 100,
                            ),
                            builder: (context, value, child) {
                              return Opacity(
                                opacity: value,
                                child: Transform.translate(
                                  offset: Offset(0, (1 - value) * 30),
                                  child: child,
                                ),
                              );
                            },
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white.withOpacity(
                                  0.2,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    15.r,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                if (action.page != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => action.page!,
                                    ),
                                  );
                                }
                              },
                              icon: Icon(
                                action.icon,
                                color: Colors.white,
                              ),
                              label: Text(
                                action.titter.tr(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      SizedBox(height: 20.h),

                      // زرار الخروج منفصل مع Animation
                      TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: 1),
                        duration: Duration(milliseconds: 500),
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(0, (1 - value) * 50),
                              child: child,
                            ),
                          );
                        },
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              padding: EdgeInsets.symmetric(
                                vertical: 20.h,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LogoutScreen(),
                                ),
                              );
                            },
                            label: Text(
                              "تسجيل الخروج".tr(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
                : SizedBox.shrink(),
          ),

          /// الزرار فوق في نص الشاشة
          SafeArea(
            child: Column(
              children: [
                Center(
                  child: GestureDetector(
                    onTap: toggleContent,
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: scaleAnim.value,
                          child: Container(
                            width: 85,
                            height: 85,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.shade800,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueAccent.withOpacity(0.5),
                                  blurRadius: glowAnim.value,
                                  spreadRadius: glowAnim.value,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text("🤔", style: TextStyle(fontSize: 45)),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
