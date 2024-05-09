import 'package:e_kyc/features/auth/presentation/pages/register_page.dart';
import 'package:flutter/material.dart';

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
              _logo(),
              _header(context),
              _inputField(context),
              _signup(context),
            ],
          ),
        ),
      ),
    );
  }
  _logo() {
    return Align(
      alignment: Alignment.topLeft,
      child: Image.asset(
        'assets/images/logo.png',
        width: 100,
        height: 100,
      ),
    );
  }

  _header(context) {
    return Column(
      children: const [
        Text(
          "LOGIN",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold,color: Colors.white),
        ),
        Text("Enter your credential to login",style: TextStyle(color: Colors.white),),
      ],
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _usernameController,
          decoration: InputDecoration(

              hintText: "Username",
              fillColor:  const Color(0xFF003A31),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),

              filled: true,
              prefixIcon: const Icon(Icons.person)),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            hintText: "Password",
            fillColor:  const Color(0xFF003A31),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),

            filled: true,
            prefixIcon: const Icon(Icons.password_outlined),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            _validateLogin(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFEE7A0A),
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text(
            "Login",
            style: TextStyle(fontSize: 20,color: Colors.white),
          ),
        )
      ],
    );
  }
  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? ",style: TextStyle(color: Colors.white),),
        TextButton(onPressed: () {  Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterPage()),
        );
        }, child: const Text("Sign Up",
            style: TextStyle(color: Color(0xFFEE7A0A))))
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
  void _validateLogin(BuildContext context) {
    String username = _usernameController.text;

    String password = _passwordController.text;


    if (username.isEmpty || password.isEmpty ) {
      _showSnackBar(context, "Please fill in all fields.");
      return;
    }
  }
}