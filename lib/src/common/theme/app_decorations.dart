import 'package:flutter/material.dart';

class AppDecorations {
  static InputDecoration defaultInputDecoration(
      {labelText, hintText, errorText}) {
    return InputDecoration(
        prefixIcon: const Icon(Icons.search),
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.only(bottom: 15),
        labelText: labelText,
        hintText: hintText,
        alignLabelWithHint: true,
        suffixIconConstraints:
            const BoxConstraints(minWidth: 24, minHeight: 24),
        errorStyle: const TextStyle(color: Colors.red),
        errorText: errorText);
  }
}
