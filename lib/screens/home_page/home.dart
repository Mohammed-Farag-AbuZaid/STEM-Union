import 'package:flutter/material.dart';
import 'package:stem_union/screens/home_page/widgets/hero_section.dart';
import 'package:stem_union/screens/home_page/widgets/nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          NavBar(),
          HeroSection(),
        ],
      ),
    );
  }
}