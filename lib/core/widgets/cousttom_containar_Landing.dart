import 'package:clay_containers/widgets/clay_container.dart';
import 'package:clay_containers/widgets/clay_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';
import 'animate_gradient.dart';
import 'floating_image.dart';

class CousttomContainarLanding extends StatelessWidget {
  const CousttomContainarLanding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,

      body: Stack(
        children: [

          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(10.0.h),
              child: Column(
                children: [
                  SizedBox(height: 50.h),
                  Stack(
                    clipBehavior: Clip.none,

                    children: [
                      Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsetsGeometry.symmetric(
                            vertical: 130.h,
                            horizontal: 3.w,
                          ),
                          child: Row(),
                        ),
                      ),

                      Positioned(
                        top: -210,

                        left: 10,
                        bottom: -120,
                        child: Center(
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Container(
                                width: 300.w,
                                height: 20.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.shade900Color,
                                      blurRadius: 20,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                              ),
                              FloatingImageWave(
                                imagePath: "assets/images/manasa1.png",
                              ),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: 190,
                        right: 12,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                          child: Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                child: ClayContainer(
                                  color: Colors.blue,

                                  child: ClayText(
                                    "الدخول للكورس",
                                    emboss: true,
                                    size: 15,
                                    // maxLines: 2,
                                    // overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              SizedBox(width: 15.w),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  clipBehavior: Clip.none,

                                  children: [
                                    ClayContainer(
                                      emboss: true,
                                      color: AppColors.grayColor,
                                      height: 50,
                                      width: 200,
                                      borderRadius: 5,
                                      child: SingleChildScrollView(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 10.h,
                                            horizontal: 10.w,
                                          ),

                                          decoration: BoxDecoration(
                                            color: Colors.blue,

                                            borderRadius: BorderRadius.circular(
                                              12.r,
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              ClayContainer(
                                                color: Colors.blue,

                                                child: ClayText(
                                                  "فيديو شرح الدرس  الاول تفاضل",
                                                  emboss: true,
                                                  size: 15,
                                                  // maxLines: 2,
                                                  // overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(height: 3.h),
                                              ClayContainer(
                                                color: Colors.blue,

                                                child: ClayText(
                                                  "عدد الساعات: 11",
                                                  emboss: true,
                                                  size: 15,
                                                  // maxLines: 2,
                                                  // overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

  }
}
