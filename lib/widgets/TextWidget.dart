
import 'dart:ui';

import 'package:flutter/widgets.dart';

// ignore: non_constant_identifier_names
TextWidget(String username, FontWeight fontWeight, double size) {
  return Text(username,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: size)
  );
}