import 'package:flutter/material.dart';

class FinishTabScreen extends StatelessWidget {
  const FinishTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text('Finish'),
        ),
      ),
    );
  }
}
