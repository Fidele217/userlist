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
  }):_controller=controller,_textLabel=textLabel,_icon=icon, super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      keyboardType: TextInputType.name,
      decoration:  InputDecoration(
          icon: _icon,
          //hintText: 'Enter your full name',
          label:Text(_textLabel),
          border: const OutlineInputBorder()
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$_textLabel cannot be empty.';
        }
        return null;
      },
    );
  }
}
