import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputTextWidget extends StatelessWidget {
  const InputTextWidget({
    super.key,
    required this.inputController,
    required this.hintText,
    required this.icon,
    required this.isPassword,
    required this.forNumbersOrCalenderOrGender,
  });

  final TextEditingController inputController;
  final String hintText;
  final Icon icon;
  final bool isPassword;
  final int forNumbersOrCalenderOrGender;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: inputController,
      style: const TextStyle(color: Colors.grey),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        fillColor: const Color(0xFF003A31),
        filled: true,
        prefixIcon: icon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),
      obscureText: isPassword,
      onTap: () {
        getNumberOrCalenderOrGender(context);
      },
      keyboardType: forNumbersOrCalenderOrGender == 1
          ? const TextInputType.numberWithOptions(decimal: false)
          : null,
      inputFormatters: forNumbersOrCalenderOrGender == 1
          ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
          : null,
    );
  }

  void _showGenderPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Gender"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Male'),
                onTap: () {
                  inputController.text = 'Male';
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Female'),
                onTap: () {
                  inputController.text = 'Female';
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      inputController.text = pickedDate.toString().split(" ")[0];
    }
  }

  void getNumberOrCalenderOrGender(BuildContext context) {
    if (forNumbersOrCalenderOrGender == 2) {
      _selectDate(context);
    } else if (forNumbersOrCalenderOrGender == 3) {
      _showGenderPicker(context);
    }
  }
}
