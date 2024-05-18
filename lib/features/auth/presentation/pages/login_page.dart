import 'package:e_kyc/core/util.dart';
import 'package:e_kyc/features/auth/domain/entities/user_entity.dart';
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
                      var userState = await BlocProvider.of<AuthBloc>(context)
                          .loginUseCase
                          .authenticationRepository
                          .logIn(
                              emailOrUsername: _usernameController.text,
                              password: _passwordController.text);

                      SnackBarMessage snackMsg = SnackBarMessage();
                      userState.fold((failure) {
                        snackMsg.showErrorSnackBar(
                            msg: failure.errorMessage, context: context);
                      }, (success) async{
                        String userName = _getUserName(success);
                        UserEntity userLoggedIn =
                            await BlocProvider.of<AuthBloc>(context)
                                .getUserUseCase
                                .authenticationRepository
                                .getUser(
                                    username: userName,
                                    userToken: success.userToken);

                        print("User Token : ${success.userToken}");
                        print("Username : ${userLoggedIn.userName}");
                        print("NID : ${userLoggedIn.nationalId}");
                        print("BD : ${userLoggedIn.birthdate}");
                        print("Gender : ${userLoggedIn.gender}");
                        print("Mobile : ${userLoggedIn.mobileNumber}");

                        tokenProvider.setUserToken(success.userToken);
                        tokenProvider.setUser(userLoggedIn);

                        snackMsg.showSuccessSnackBar(
                            msg: "Logged In Successfully", context: context);

                        Navigator.pushReplacementNamed(
                            context, HomePage.routeName);
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(250, 30),
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

  String _getUserName(UserStatusSuccessEntity user) {
    Map<String, dynamic> decodedUserStatus = JwtDecoder.decode(user.userToken);
    return decodedUserStatus["sub"];
  }
}
