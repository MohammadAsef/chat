import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  String label;
  IconData icon;
  bool obsecureText;
  Function validator;
  TextEditingController controlller;

  FormInput({
    this.label,
    this.icon,
    this.obsecureText,
    this.controlller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35),
      child: TextFormField(
        obscureText: obsecureText ?? false,
        validator: validator,
        controller: controlller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          contentPadding: const EdgeInsets.all(8),
          prefixIcon: Icon(
            icon,
            color: Colors.grey,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.black),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
