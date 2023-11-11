import 'package:currency_converter/core/extensions/context_extension.dart';
import 'package:currency_converter/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';

import 'home_screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "/splash_screen";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (routes) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: "currency_animation".toLottieAsset(width: context.screenWidth, repeat: true),
      ),
    );
  }
}
