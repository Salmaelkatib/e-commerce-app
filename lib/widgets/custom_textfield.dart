import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final TextEditingController _controller;
  const CustomTextField(this.hint, this.icon, this._controller, {super.key});

  String? _errorMessage(String str) {
    switch (hint) {
      case 'Enter your username':
        return 'Username field is empty';
      case 'Enter your email':
        return 'Email field is empty';
      case 'Enter your password':
        return 'Password field is empty';
      case 'Enter your address':
        return 'Address field is empty';
    }
    return null;
  }

  TextEditingController getcontroller() {
    return _controller;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: TextFormField(
          controller: _controller,
          obscureText: hint == 'Enter your password' ? true : false,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: Colors.blue.shade900,
            ),
            hintText: hint,
            fillColor: Colors.grey.shade300,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.blue.shade900),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.blue.shade900),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.blue.shade900),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return _errorMessage(hint);
            }
            return null;
          },
        ));
  }
}
