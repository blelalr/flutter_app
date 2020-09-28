
import 'dart:ui';

import 'package:flutter/widgets.dart';

// ignore: non_constant_identifier_names
TextWidget(String text, FontWeight fontWeight, double size) {
  return Text(text,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: size)
  );
}