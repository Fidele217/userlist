

import 'package:flutter/material.dart';

class CustomDatePickerFormField extends StatelessWidget {
  final TextEditingController _controller;
  final String _textLabel;
  final VoidCallback _callback;
  const CustomDatePickerFormField(
      {Key? key,
        required TextEditingController controller,
        required String textLabel,
        required VoidCallback callback
  }) : _controller=controller,_textLabel=textLabel,_callback=callback, super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      keyboardType: TextInputType.name,
      decoration:  InputDecoration(
          icon: const Icon(Icons.calendar_today),
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
      onTap: () => _callback,
    );
  }


}
