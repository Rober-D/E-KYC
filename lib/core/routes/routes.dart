import 'package:e_kyc/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/pages/register_page.dart';

// Routes to Navigate between screens.
class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RegisterPage.routeName:
        return MaterialPageRoute(
            builder: (context) => RegisterPage(), settings: settings);
      case LoginPage.routeName:
        return MaterialPageRoute(
            builder: (context) => LoginPage(), settings: settings);


      default:
        return MaterialPageRoute(
            builder: (context) => LoginPage(), settings: settings);
    }
  }
}
