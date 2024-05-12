import 'package:flutter/material.dart';

class AuthButtonWidget extends StatelessWidget {
  AuthButtonWidget(
      {super.key, required this.validationFunction, required this.hintText});

  void Function()? validationFunction;
  String hintText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: validationFunction,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFEE7A0A),
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: Text(
        hintText,
        style: const TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }
}
