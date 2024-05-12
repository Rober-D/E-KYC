import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  LogoWidget({super.key, required this.width, required this.height});

  double width;
  double height;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Image.asset(
        'assets/images/logo.png',
        width: width,
        height: height,
      ),
    );
  }
}
