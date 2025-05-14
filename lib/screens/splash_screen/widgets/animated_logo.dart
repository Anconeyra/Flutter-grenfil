import 'package:flutter/material.dart';

@immutable
class AnimatedLogo extends StatefulWidget {
  final String imagePath;
  final double height;
  final Duration animationDuration;

  const AnimatedLogo({
    super.key,
    required this.imagePath,
    this.height = 150,
    this.animationDuration = const Duration(seconds: 2),
  });

  @override
  AnimatedLogoState createState() => AnimatedLogoState(); // Estado ahora es público
}

class AnimatedLogoState extends State<AnimatedLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    )..repeat(reverse: true);
    _opacityAnimation = Tween<double>(begin: 0.2, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacityAnimation.value,
      duration: const Duration(milliseconds: 500),
      child: Image.asset(widget.imagePath, height: widget.height),
    );
  }
}