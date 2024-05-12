import 'package:e_kyc/features/auth/presentation/widgets/auth_button_widget.dart';
import 'package:e_kyc/features/auth/presentation/widgets/register_page_widgets/to_login_widget.dart';
import 'package:flutter/material.dart';
import '../../../../core/util.dart';
import '../widgets/input_text_widget.dart';
import '../widgets/logo_widget.dart';
import '../widgets/register_page_widgets/register_header_widget.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  static const String routeName = "RegisterPage";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController = TextEditingController();

  final TextEditingController _mobileNumberController = TextEditingController();

  final TextEditingController _dateController = TextEditingController();

  final TextEditingController _nationalIdController = TextEditingController();

  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xFF03312b),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                LogoWidget(width: 60, height: 60,),
                const RegisterHeaderWidget(),
                _inputFields(context),
                const ToLoginWidget(),
              ]),
        ),
      ),
    ));
  }

  _inputFields(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InputTextWidget(
          hintText: "Username",
          icon: const Icon(
            Icons.person,
            color: Color(0xFFEE7A0A),
          ),
          inputController: _usernameController,
          isPassword: false,
          forNumbersOrCalenderOrGender: 0,
        ),
        const SizedBox(
          height: 10,
        ),
        InputTextWidget(
          hintText: "Mobile Number",
          icon: const Icon(
            Icons.phone_android_rounded,
            color: Color(0xFFEE7A0A),
          ),
          inputController: _mobileNumberController,
          isPassword: false,
          forNumbersOrCalenderOrGender: 1,
        ),
        const SizedBox(
          height: 10,
        ),
        InputTextWidget(
          hintText: "National ID",
          icon: const Icon(
            Icons.credit_card,
            color: Color(0xFFEE7A0A),
          ),
          inputController: _nationalIdController,
          isPassword: false,
          forNumbersOrCalenderOrGender: 1,
        ),
        const SizedBox(
          height: 10,
        ),
        InputTextWidget(
          hintText: "Birthdate",
          icon: const Icon(
            Icons.calendar_month,
            color: Color(0xFFEE7A0A),
          ),
          inputController: _dateController,
          isPassword: false,
          forNumbersOrCalenderOrGender: 2,
        ),
        const SizedBox(
          height: 10,
        ),
        InputTextWidget(
          hintText: "Gender",
          icon: const Icon(
            Icons.transgender,
            color: Color(0xFFEE7A0A),
          ),
          inputController: TextEditingController(text: _selectedGender),
          isPassword: false,
          forNumbersOrCalenderOrGender: 3,
        ),
        const SizedBox(
          height: 10,
        ),
        InputTextWidget(
          hintText: "Email",
          icon: const Icon(
            Icons.email_outlined,
            color: Color(0xFFEE7A0A),
          ),
          inputController: _emailController,
          isPassword: false,
          forNumbersOrCalenderOrGender: 0,
        ),
        const SizedBox(
          height: 10,
        ),
        InputTextWidget(
          hintText: "Password",
          icon: const Icon(
            Icons.password,
            color: Color(0xFFEE7A0A),
          ),
          inputController: _passwordController,
          isPassword: true,
          forNumbersOrCalenderOrGender: 0,
        ),
        const SizedBox(
          height: 10,
        ),
        InputTextWidget(
          hintText: "Confirm Password",
          icon: const Icon(
            Icons.password,
            color: Color(0xFFEE7A0A),
          ),
          inputController: _confirmPasswordController,
          isPassword: true,
          forNumbersOrCalenderOrGender: 0,
        ),
        const SizedBox(
          height: 10,
        ),
        AuthButtonWidget(
          validationFunction: _validateSignUp,
          hintText: 'Sign Up',
        ),
      ],
    );
  }

  _validateSignUp() {
    String username = _usernameController.text;
    String mobile = _mobileNumberController.text;
    String nationalId = _nationalIdController.text;
    String birthdate = _dateController.text;
    String gender = _selectedGender.toString();
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    SnackBarMessage snackBarMessage = SnackBarMessage();

    if (username.isEmpty ||
        mobile.isEmpty ||
        nationalId.isEmpty ||
        birthdate.isEmpty ||
        gender.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      snackBarMessage.showAuthSnackBar(context, "Please fill in all fields.");
      return;
    }

    if(nationalId.length != 14){
      snackBarMessage.showAuthSnackBar(context, "Please Enter a valid National ID with 14 digit");
      return;
    }


    if (!email.contains("@") || !email.contains(".com")) {
      snackBarMessage.showAuthSnackBar(context, "Email should contain @ and .com");
      return;
    }

    if(password.length < 8){
      snackBarMessage.showAuthSnackBar(context, "Please Enter at least 8 characters");
      return;
    }

    if (password != confirmPassword) {
      snackBarMessage.showAuthSnackBar(context, "Passwords do not match.");
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
}