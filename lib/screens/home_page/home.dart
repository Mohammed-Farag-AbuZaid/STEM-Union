import 'package:flutter/material.dart';
import 'package:stem_union/screens/home_page/app_routs.dart';
import 'package:stem_union/screens/home_page/widgets/footer.dart';
import 'package:stem_union/screens/home_page/widgets/hero_section.dart';
import 'package:stem_union/screens/home_page/widgets/mession.dart';
import 'package:stem_union/screens/home_page/widgets/mobile_drawer.dart';
import 'package:stem_union/screens/home_page/widgets/nav_bar.dart';
import 'package:stem_union/screens/services_page/services.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _servicesKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollToServices() {
    final renderObject = _servicesKey.currentContext?.findRenderObject();
    if (renderObject != null) {
      Scrollable.ensureVisible(
        _servicesKey.currentContext!,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _handleNavTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
        break;
      case 1:
        scrollToServices();
        break;
      case 2:
        Get.toNamed(AppRoutes.volunteer);
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
          return ListView(
            controller: _scrollController,
            scrollDirection: Axis.vertical,
            children: [
              NavBar(
                onNavItemTap: (index) => _handleNavTap(context, index),
                onMenuTap: () => Scaffold.of(navBarContext).openDrawer(),
              ),
              const SizedBox(height: 15),
              const HeroSection(),
              const MissionStrip(),
              KeyedSubtree(
                key: _servicesKey,
                child: const ServicesPage(),
              ),
              const StemUnionFooter(),
            ],
          );
        },
      ),
    );
  }
}