import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stem_union/authentication/controllers/user_controller.dart';
import 'package:stem_union/screens/home_page/widgets/profile_dialog.dart';
import 'package:stem_union/utils/constants/colors.dart';
import 'package:stem_union/utils/helpers/helper_functions.dart';

class StemUnionDrawer extends StatelessWidget {
  const StemUnionDrawer({super.key, required this.onNavItemTap});

  final void Function(int) onNavItemTap;

  static const navItems = ['Home', 'Services', 'Volunteer'];
  static const navIcons = [
    Icons.home_outlined,
    Icons.apps_outlined,
    Icons.volunteer_activism_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final amber = isDark ? TColors.secondry : TColors.primary;
    final bg = isDark ? const Color(0xFF0A0A0A) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final mutedColor = isDark ? Colors.white60 : Colors.black54;

    return SafeArea(
      child: Drawer(
        backgroundColor: bg,
        child: Obx(() {
          final user = UserController.instance.user.value;

          return ListView(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 20),
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.arrow_back, color: textColor),
                  ),
                ),
              ),
              for (int i = 0; i < navItems.length; i++)
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  leading: Icon(navIcons[i], color: textColor),
                  title: Text(
                    navItems[i],
                    style: TextStyle(
                      color: textColor,
                      fontFamily: 'JetBrainsMono',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    onNavItemTap(i);
                  },
                ),
              const SizedBox(height: 30),
              if (user.id.isEmpty)
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  leading: Icon(Icons.login, color: textColor),
                  title: Text(
                    'Login',
                    style: TextStyle(
                      color: mutedColor,
                      fontFamily: 'JetBrainsMono',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                )
              else
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  leading: Icon(Icons.person_outline, color: amber),
                  title: Text(
                    user.username.isNotEmpty ? '@${user.username}' : 'Profile',
                    style: TextStyle(
                      color: textColor,
                      fontFamily: 'JetBrainsMono',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    showProfileDialog(context: context);
                  },
                ),
            ],
          );
        }),
      ),
    );
  }
}