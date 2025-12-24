import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_text_style.dart';

class CousstomBotton extends StatefulWidget {
  final String titell;
  final double? width;
  final void Function()? onTap;
  const CousstomBotton({super.key, required this.titell, this.onTap, this.width});

  @override
  State<CousstomBotton> createState() => _CousstomBottonState();
}

class _CousstomBottonState extends State<CousstomBotton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(

        width: double.infinity,
        height: 56.h,
        decoration: BoxDecoration(


          borderRadius: BorderRadius.circular(12.r),
          color:  Color(0xFF0B1D51),
        ),
        child: Center(
          child: Text(widget.titell,
          style: AppTextStyle.Bold20Whit,

          ),
        ),
      ),
    );
  }
}
