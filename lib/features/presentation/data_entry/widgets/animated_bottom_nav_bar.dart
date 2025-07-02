import 'package:flutter/material.dart';

class AnimatedBottomNavBar extends StatefulWidget {
  final VoidCallback onTap;

  const AnimatedBottomNavBar({super.key, required this.onTap});

  @override
  State<AnimatedBottomNavBar> createState() => _AnimatedBottomNavBarState();
}

class _AnimatedBottomNavBarState extends State<AnimatedBottomNavBar>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.95,
      upperBound: 1.0,
    );
    _controller.addListener(() {
      setState(() {
        _scale = _controller.value;
      });
    });
    _controller.value = 1.0;
  }

  void _handleTapDown(TapDownDetails details) {
    _controller.reverse(); // scale down
  }

  void _handleTapUp(TapUpDetails details) {
    _controller.forward(); // scale back up
    widget.onTap(); // trigger action
  }

  void _handleTapCancel() {
    _controller.forward(); // scale back up if canceled
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        child: Container(
          height: 70,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFEDF6FF), Color(0xFFD6EFFF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, -2),
                blurRadius: 8,
              ),
            ],
          ),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check,
                  color: Color(0xFF1E88E5),
                  size: 28,
                ),
                SizedBox(height: 4),
                Text(
                  'Done',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF1E88E5),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
