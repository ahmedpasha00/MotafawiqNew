import 'package:flutter/material.dart';

class ThinkingAction{

  final String titter;
  final IconData icon;
  final Widget? page;
  final VoidCallback? onTap; // اختياري


  ThinkingAction({required this.titter, required this.icon,  this.page, this.onTap});
}