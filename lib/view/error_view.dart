import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
            "Error: Wrong url, please check your url\nyou have to write like this\"/#/crypto/:coinName\""),
      ),
    );
  }
}
