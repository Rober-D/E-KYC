import 'package:e_kyc/features/auth/presentation/pages/login_page.dart';
import 'package:e_kyc/features/national_id/presentation/pages/choose.dart';
import 'package:e_kyc/features/national_id/presentation/pages/create_national_id.dart';
import 'package:e_kyc/features/national_id/presentation/pages/make_sure.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/national_id/presentation/pages/home_page.dart';
import '../../splash_page.dart';

// Routes to Navigate between screens.
class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RegisterPage.routeName:
        return MaterialPageRoute(
            builder: (context) => const RegisterPage(), settings: settings);
      case SplashPage.routeName:
        return MaterialPageRoute(
            builder: (context) => const SplashPage(), settings: settings);
      case LoginPage.routeName:
        return MaterialPageRoute(
            builder: (context) => LoginPage(), settings: settings);
      case Choose.routeName:
        return MaterialPageRoute(
            builder: (context) => Choose(), settings: settings);
      case Makesure.routeName:
        return MaterialPageRoute(
            builder: (context) => Makesure(), settings: settings);
      case HomePage.routeName:
        return MaterialPageRoute(
            builder: (context) => HomePage(), settings: settings);
      case CreateNationalIdCardPage.routeName:
        return MaterialPageRoute(
            builder: (context) => CreateNationalIdCardPage(), settings: settings);

      default:
        return MaterialPageRoute(
            builder: (context) => LoginPage(), settings: settings);
    }
  }
}
