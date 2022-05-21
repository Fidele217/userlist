import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController _controller;
  final String _textLabel;
  final Icon _icon;

  const CustomTextFormField({
    Key? key,
    required textLabel,
    required controller,
    required icon,
  })  : _controller = controller,
        _textLabel = textLabel,
        _icon = icon,
        super(key: key);

  static bool isValidPhoneNumber(String? string) {
    // Null or empty string is invalid phone number
    if (string == null || string.isEmpty) {
      return false;
    }

    // You may need to change this pattern to fit your requirement.
    // I just copied the pattern from here: https://regexr.com/3c53v
    const pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(string)) {
      return false;
    }
    return true;
  }

  static validateEmail(String? value) {
    // Check if this field is empty
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }

    // using regular expression
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return "Please enter a valid email address";
    }

    // the email is valid
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
          icon: _icon,
          //hintText: 'Enter your full name',
          label: Text(_textLabel),
          border: const OutlineInputBorder()),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$_textLabel cannot be empty.';
        }
        return null;
      },
    );
  }
}
