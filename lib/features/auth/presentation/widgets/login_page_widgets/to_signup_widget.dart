import 'package:flutter/material.dart';
import '../../pages/register_page.dart';

class ToSignUpWidget extends StatelessWidget {
  const ToSignUpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account? ", style: TextStyle(color: Colors.white),),
        TextButton(onPressed: () {
          Navigator.pushReplacementNamed(context, RegisterPage.routeName);
        }, child: const Text("Sign Up",
            style: TextStyle(color: Color(0xFFEE7A0A))))
      ],
    );
  }
}
