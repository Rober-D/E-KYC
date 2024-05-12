import 'package:flutter/material.dart';

import '../../pages/login_page.dart';

class ToLoginWidget extends StatelessWidget {
  const ToLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have an account?",
          style: TextStyle(color: Colors.white),
        ),
        TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, LoginPage.routeName);
            },
            child: const Text(
              "Login",
              style: TextStyle(color: Color(0xFFEE7A0A)),
            ))
      ],
    );
  }
}
