import 'package:flutter/material.dart';

// Snackbar or something like that appear to user using the messages.
// Create a class with methods to show each Snackbar on screen.
class SnackBarMessage {

  void showSuccessSnackBar({required String msg, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  void showErrorSnackBar({required String msg, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  void showAuthSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),

    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
