import 'package:flutter/material.dart';
import 'package:stem_union/common/styles/blueprint_background.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: 
        BlueprintGrid(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.transparent,
            child: const Text(
              'Home Page',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }
}