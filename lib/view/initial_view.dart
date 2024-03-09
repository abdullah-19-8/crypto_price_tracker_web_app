import 'package:flutter/material.dart';

class InitialView extends StatelessWidget {
  const InitialView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(onPressed: () {}, child: Text("Tap")),
      ),
    );
  }
}
