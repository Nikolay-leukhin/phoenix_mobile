import 'package:flutter/material.dart';

class SplashScaffold extends StatelessWidget {
  const SplashScaffold({super.key, required this.body});

  final Widget? body;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash_background.png'),
            fit: BoxFit.fill
          )
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: body,
        ),
      ),
    );
  }
}
