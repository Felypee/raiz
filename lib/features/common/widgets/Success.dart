import 'package:flutter/material.dart';

void showSuccess(BuildContext context) {
  ScaffoldMessenger.of(context)
      .showSnackBar(const SnackBar(content: Text("Success")));
}
