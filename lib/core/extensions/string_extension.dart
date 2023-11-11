import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

extension FilesExtension on String {
  LottieBuilder toLottieAsset({double? width, double? height, bool repeat = false, BoxFit fit = BoxFit.contain}) => Lottie.asset(
        "assets/animations/$this.json",
        width: width,
        height: height,
        fit: fit,
        repeat: repeat,
      );

  SvgPicture toSvgAsset({double? width, double? height, BoxFit fit = BoxFit.contain}) => SvgPicture.asset(
        "assets/images/$this.svg",
        width: width,
        height: height,
        fit: fit,
      );
}
