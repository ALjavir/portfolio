import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget scrollD() {
  return Lottie.asset(
    'lib/assets/icon/scroll down.json',
    options: LottieOptions(enableMergePaths: false),
  );
}

Widget lottieImage(String image, double? size) {
  return LottieBuilder.asset(
    image,
    height: size,
    width: size,
    options: LottieOptions(enableMergePaths: false),
  );
}
