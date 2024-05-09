import 'package:flutter/material.dart';

import 'login_page.dart';

class RegisterPage extends StatelessWidget {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =TextEditingController();

  RegisterPage({super.key});

  static const String routeName = "RegisterPage";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(

          backgroundColor: const Color(0xFF03312b),
          body: Container(
            margin: const EdgeInsets.all(24),
            child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              _logo(),
              _header(context),
              _inputFields(context),
              _loginInfo(context),
            ]),
          ),
        ));
  }
  _logo() {
    return Align(
      alignment: Alignment.topLeft,
      child: Image.asset(
        'assets/images/logo.png',
        width: 60, // Adjust the width as needed
        height: 60, // Adjust the height as needed
      ),
    );
  }

  _header(context) {
    return Column(
      children: const[
        Text(
          "Create Account",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold,color: Colors.white),
        ),
        Text(
          "Enter details to get started",
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  _inputFields(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _usernameController,
          decoration: InputDecoration(
            hintText: "Username",
            fillColor:  const Color(0xFF003A31),
            filled: true,
            prefixIcon: const Icon(Icons.person),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            hintText: "Email ",
            fillColor:  const Color(0xFF003A31),
            filled: true,
            prefixIcon: const Icon(Icons.email_outlined),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            hintText: "Password",
            fillColor: const Color(0xFF003A31),
            filled: true,
            prefixIcon: const Icon(Icons.password_outlined),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
          ),
          obscureText: true,
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: _confirmPasswordController,
          decoration: InputDecoration(
            hintText: "Confirm Password",
            fillColor:  const Color(0xFF003A31),
            filled: true,
            prefixIcon: const Icon(Icons.password_outlined),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
          ),
          obscureText: true,
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: () {
            _validateSignUp(context);

          },
          style: ElevatedButton.styleFrom(
            backgroundColor:  const Color(0xFFEE7A0A),
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text(
            "Sign Up",
            style: TextStyle(fontSize: 20 ,color: Colors.white),
          ),
        )
      ],
    );
  }

  _loginInfo(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account?",
          style: TextStyle(color: Colors.white),
        ),
        TextButton(onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        },
            child: const Text(
              "Login",
              style: TextStyle(color: Color(0xFFEE7A0A)),
            ))
      ],
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),

    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _validateSignUp(BuildContext context) {
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (username.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showSnackBar(context, "Please fill in all fields.");
      return;
    }

    if (!email.contains("@gmail.com")) {
      _showSnackBar(context, "Email should contain @gmail.com");
      return;
    }

    if (password != confirmPassword) {
      _showSnackBar(context, "Passwords do not match.");
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
}