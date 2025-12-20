import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CousstomHomePage extends StatefulWidget {
  final String TextHome;
  final double height;
  final TextStyle style;
  final Color color;
  const CousstomHomePage({super.key,required this.TextHome, required this.height, required this.style, required this.color});

  @override
  State<CousstomHomePage> createState() => _CousstomHomePageState();
}

class _CousstomHomePageState extends State<CousstomHomePage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color:  widget.color,
      ),
child: Center(
  child: Text(widget.TextHome,
  style: widget.style,
  ),
),
    );
  }
}
