import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stem_union/screens/home_page/widgets/footer.dart';
import 'package:stem_union/screens/home_page/widgets/hero_section.dart';
import 'package:stem_union/screens/home_page/widgets/mession.dart';
import 'package:stem_union/screens/home_page/widgets/mobile_drawer.dart';
import 'package:stem_union/screens/home_page/widgets/nav_bar.dart';
import 'package:stem_union/screens/services_page/services.dart';
import 'package:stem_union/screens/volunteer_page/volunteer_content.dart';

class HomeScrollController extends GetxController {
  final scrollController = ScrollController();
  final servicesKey = GlobalKey();
  final volunteerKey = GlobalKey();

  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void scrollToKey(GlobalKey key) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = key.currentContext;
      if (ctx == null) return;

      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null) return;

      final scrollBox = scrollController.position.context.storageContext
          .findRenderObject() as RenderBox?;
      if (scrollBox == null) return;

      final position = box.localToGlobal(Offset.zero, ancestor: scrollBox);
      final target = (scrollController.offset + position.dy)
          .clamp(0.0, scrollController.position.maxScrollExtent);

      scrollController.animateTo(
        target,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(HomeScrollController());

    void handleNavTap(BuildContext context, int index) {
      switch (index) {
        case 0:
          ctrl.scrollToTop();
          break;
        case 1:
          ctrl.scrollToKey(ctrl.servicesKey);
          break;
        case 2:
          ctrl.scrollToKey(ctrl.volunteerKey);
          break;
      }
    }

    return Scaffold(
      drawer: StemUnionDrawer(
        onNavItemTap: (index) => handleNavTap(context, index),
      ),
      body: Builder(
        builder: (navBarContext) {
          return SingleChildScrollView(         
            controller: ctrl.scrollController,
            child: Column(                     
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NavBar(
                  onNavItemTap: (index) => handleNavTap(context, index),
                  onMenuTap: () => Scaffold.of(navBarContext).openDrawer(),
                ),
                const SizedBox(height: 15),
                const HeroSection(),
                const MissionStrip(),
                KeyedSubtree(
                  key: ctrl.servicesKey,
                  child: const ServicesPage(),
                ),
                const SizedBox(height: 30),
                KeyedSubtree(
                  key: ctrl.volunteerKey,
                  child: const VolunteerContent(),
                ),
                const StemUnionFooter(),
              ],
            ),
          );
        },
      ),
    );
  }
}