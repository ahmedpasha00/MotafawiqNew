import 'package:flutter/material.dart';

import 'animate_gradient.dart';

class ThinkingButtonToggle extends StatefulWidget {
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

          /// ======= المحتوى اللي بيظهر لما الزرار يفتح =======
          AnimatedOpacity(
            opacity: isOpen ? 1 : 0,
            duration: Duration(milliseconds: 300),
            child: isOpen
                ? SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 180,
                          ), // << هنا بننزل المحتوى تحت الزرار

                          Center(
                            child: Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                "ضيف انت المحتوى بتاعك هنا 🔥\nصور – شاشات – نص – أي حاجة!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ),

          /// ======= الزرار فوق في نص الشاشة =======
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
