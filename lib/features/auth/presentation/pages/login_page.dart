import 'package:e_kyc/core/util.dart';
import 'package:e_kyc/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:e_kyc/features/auth/presentation/pages/register_page.dart';
import 'package:e_kyc/features/auth/presentation/widgets/input_text_widget.dart';
import 'package:e_kyc/features/auth/presentation/widgets/login_page_widgets/login_header_widget.dart';
import 'package:e_kyc/features/auth/presentation/widgets/login_page_widgets/to_signup_widget.dart';
import 'package:e_kyc/features/auth/presentation/widgets/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  static const String routeName = "LoginPage";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color(0xFF03312b),
          body: Container(
            margin: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                LogoWidget(width: 100, height: 100),
                const LoginHeaderWidget(),
                _inputField(context),
                const ToSignUpWidget(),
              ],
            ),
          )),
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InputTextWidget(
            inputController: _usernameController,
            hintText: "Username",
            icon: const Icon(
              Icons.person,
              color: Color(0xFFEE7A0A),
            ),
            isPassword: false,
            forNumbersOrCalenderOrGender: 0),
        const SizedBox(height: 15),
        InputTextWidget(
            inputController: _passwordController,
            hintText: "Password",
            icon: const Icon(
              Icons.password,
              color: Color(0xFFEE7A0A),
            ),
            isPassword: true,
            forNumbersOrCalenderOrGender: 0),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            bool login = _validateLogin(context);
            if (login) {
              BlocProvider.of<AuthBloc>(context).add(LoginEvent(
                  emailOrUserName: _usernameController.text,
                  password: _passwordController.text));
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFEE7A0A),
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text(
            "Login",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        )
      ],
    );
  }

  bool _validateLogin(BuildContext context) {
    String username = _usernameController.text;
    String password = _passwordController.text;
    SnackBarMessage snackBarMessage = SnackBarMessage();

    if (username.isEmpty || password.isEmpty) {
      snackBarMessage.showAuthSnackBar(context, "Please fill in all fields.");
      return false;
    } else {
      return true;
    }
  }
}
