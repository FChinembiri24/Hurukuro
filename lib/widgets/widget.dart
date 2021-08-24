import 'package:flutter/material.dart';

AppBar appBarMain(BuildContext context, String name) {
  return AppBar(
    title: Text("Hello " + name),
    elevation: 0.0,
    centerTitle: false,
  );
}

InputDecoration textDeco(String hint) {
  return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.white54),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)));
}

TextStyle wordStyle() {
  return TextStyle(color: Colors.white);
}

TextStyle wordStyle4() {
  return TextStyle(
    color: Colors.white,
    decoration: TextDecoration.underline,
  );
}

TextStyle wordStyle2() {
  return TextStyle(
    color: Colors.white,
    fontSize: 18,
  );
}

TextStyle wordStyle3() {
  return TextStyle(
    color: Colors.black,
    fontSize: 18,
  );
}
