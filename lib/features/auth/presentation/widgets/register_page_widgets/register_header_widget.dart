import 'package:flutter/material.dart';

class RegisterHeaderWidget extends StatelessWidget {
  const RegisterHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(
          height: 20,
        ),
        Text(
          "Create Account",
          style: TextStyle(
              fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Text(
          "Enter details to get started",
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
