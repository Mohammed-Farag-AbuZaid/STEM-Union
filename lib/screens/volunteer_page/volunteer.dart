import 'package:flutter/material.dart';
import 'package:stem_union/screens/home_page/widgets/mobile_drawer.dart';
import 'package:stem_union/screens/home_page/widgets/nav_bar.dart';
import 'package:stem_union/screens/volunteer_page/volunteer_content.dart';

class VolunteerScreen extends StatelessWidget {
  const VolunteerScreen({super.key});

  void _handleNavTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.of(context).popUntil((route) => route.isFirst);
        break;
      case 1:
        Navigator.of(context).pop();
        break;
      case 2:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: StemUnionDrawer(
        onNavItemTap: (index) => _handleNavTap(context, index),
      ),
      body: Builder(
        builder: (navBarContext) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NavBar(
                  onNavItemTap: (index) => _handleNavTap(context, index),
                  onMenuTap: () => Scaffold.of(navBarContext).openDrawer(),
                ),
                const VolunteerContent(),
              ],
            ),
          );
        },
      ),
    );
  }
}