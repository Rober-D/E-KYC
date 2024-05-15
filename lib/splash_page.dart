import 'package:e_kyc/core/colors.dart';
import 'package:e_kyc/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  static const String routeName = "SplashPage";
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {

    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, LoginPage.routeName);
    });
    setState(() {});
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_GREEN,
      body: Center(
        child: Image.asset(
          "assets/images/logo.png",
        ),
      ),
    );
  }
}