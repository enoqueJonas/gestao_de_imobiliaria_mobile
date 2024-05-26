// input_decorations.dart
import 'package:flutter/material.dart';

InputDecoration customInputIconDecoration({
  required String hintText,
  required IconData prefixIcon,
}) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white,
    hintText: hintText,
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: Color.fromARGB(255, 204, 204, 204)),
      borderRadius: BorderRadius.circular(10),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color.fromARGB(255, 204, 204, 204)),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide:
          const BorderSide(color: const Color.fromRGBO(26, 147, 192, 1)),
      borderRadius: BorderRadius.circular(10),
    ),
    errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(10)),
    prefixIcon: Icon(prefixIcon, color: Color.fromRGBO(26, 147, 192, 1)),
    contentPadding: EdgeInsets.all(20),
  );
}
