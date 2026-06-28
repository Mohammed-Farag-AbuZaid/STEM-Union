import 'package:flutter/material.dart';
import 'package:stem_union/screens/home_page/widgets/hero_section.dart';
import 'package:stem_union/screens/home_page/widgets/mession.dart';
import 'package:stem_union/screens/home_page/widgets/nav_bar.dart';
import 'package:stem_union/screens/services_page/services.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          NavBar(),
          HeroSection(),
          MissionStrip(),
          ServicesPage(),
        ],
      ),
    );
  }
}