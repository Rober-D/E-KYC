import 'package:e_kyc/core/util.dart';
import 'package:e_kyc/features/auth/domain/entities/user_status.dart';
import 'package:e_kyc/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:e_kyc/features/auth/presentation/provider/user_token_provider.dart';
import 'package:e_kyc/features/auth/presentation/widgets/input_text_widget.dart';
import 'package:e_kyc/features/auth/presentation/widgets/login_page_widgets/login_header_widget.dart';
import 'package:e_kyc/features/auth/presentation/widgets/login_page_widgets/to_signup_widget.dart';
import 'package:e_kyc/features/auth/presentation/widgets/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import '../../../../core/colors.dart';
import '../../../national_id/presentation/pages/home_page.dart';

class LoginPage extends StatelessWidget {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String userToken = "";

  LoginPage({super.key});

  static const String routeName = "LoginPage";

  @override
  Widget build(BuildContext context) {
    UserTokenProvider tokenProvider = Provider.of<UserTokenProvider>(context);

    return SafeArea(
      child: Scaffold(
          backgroundColor: PRIMARY_GREEN,
          body: Container(
            margin: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                LogoWidget(width: 100, height: 100),
                const LoginHeaderWidget(),
                _inputField(context),
                ElevatedButton(
                  onPressed: () async {
                    bool login = _validateLogin(context);
                    if (login) {
                      UserStatusEntity userState =
                      await BlocProvider.of<AuthBloc>(context)
                          .loginUseCase
                          .authenticationRepository
                          .logIn(
                          emailOrUsername: _usernameController.text,
                          password: _passwordController.text);

                      SnackBarMessage snackMsg = SnackBarMessage();
                      if (userState.errorMessage == "Invalid email or password") {

                        snackMsg.showErrorSnackBar(
                            msg: userState.errorMessage, context: context);
                      } else {
                        tokenProvider.setUserToken(userState.userToken);
                        snackMsg.showSuccessSnackBar(
                            msg: "Logged In Successfully", context: context);

                        Navigator.pushReplacementNamed(context, HomePage.routeName);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(minimumSize: const Size(250, 30),
                    backgroundColor: PRIMARY_ORANGE,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
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
            icon: Icon(
              Icons.person,
              color: PRIMARY_ORANGE,
            ),
            isPassword: false,
            forNumbersOrCalenderOrGender: 0),
        const SizedBox(height: 15),
        InputTextWidget(
            inputController: _passwordController,
            hintText: "Password",
            icon: Icon(
              Icons.password,
              color: PRIMARY_ORANGE,
            ),
            isPassword: true,
            forNumbersOrCalenderOrGender: 0),
        const SizedBox(height: 10),
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

  String _getUserName(UserStatusEntity user) {
    Map<String, dynamic> decodedUserStatus = JwtDecoder.decode(user.userToken);
    return decodedUserStatus["sub"];
  }
}
