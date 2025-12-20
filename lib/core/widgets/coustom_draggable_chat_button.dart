import 'package:flutter/material.dart';

class CoustomDraggableChatButton extends StatefulWidget {
  final VoidCallback? onTap; // هنا هتمرر الدالة من الصفحة

  const CoustomDraggableChatButton({super.key, this.onTap});

  @override
  State<CoustomDraggableChatButton> createState() =>
      _CoustomDraggableChatButtonState();
}

class _CoustomDraggableChatButtonState
    extends State<CoustomDraggableChatButton> with SingleTickerProviderStateMixin {
  double posX = 20;
  double posY = 500;
  bool isDragging = false;

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  final double buttonSize = 70;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.9,
      upperBound: 1.1,
      value: 1,
    );

    _scaleAnimation = _controller.drive(Tween<double>(begin: 1.0, end: 1.1));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPanStart(DragStartDetails details) {
    setState(() => isDragging = true);
    _controller.forward();
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() => isDragging = false);
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Positioned(
          left: posX,
          top: posY,
          child: GestureDetector(
            onPanStart: _onPanStart,
            onPanUpdate: (details) {
              setState(() {
                posX += details.delta.dx;
                posY += details.delta.dy;

                // الحدود
                posX = posX.clamp(0, screenWidth - buttonSize);
                posY = posY.clamp(0, screenHeight - buttonSize);
              });
            },
            onPanEnd: _onPanEnd,
            onTap: () {
              if (widget.onTap != null) {
                widget.onTap!(); // هنا نرسل الحدث للصفحة اللي ضعت فيها الودجيت
              }
            },
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                width: buttonSize,
                height: buttonSize,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.deepPurple, Colors.purpleAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 12,
                      spreadRadius: 2,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.chat_bubble,
                  color: Colors.white,
                  size: 32,
                ),

              ),
            ),
          ),
        ),
      ],
    );
  }
}
