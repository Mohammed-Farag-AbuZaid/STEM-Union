import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:stem_union/authentication/controllers/user_controller.dart';
import 'package:stem_union/screens/home_page/widgets/profile_dialog.dart';
import 'package:stem_union/utils/constants/colors.dart';
import 'package:stem_union/utils/helpers/helper_functions.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key, required this.onNavItemTap, this.onMenuTap});

  final void Function(int) onNavItemTap;
  final VoidCallback? onMenuTap;

  static const navItems = ['Home', 'Services', 'Volunteer'];

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final isMobile = context.width < 700;
    final amber = isDark ? TColors.secondry : TColors.primary;
    final navBg = isDark ? const Color(0xFF0A0A0A) : Colors.white;
    final borderColor = isDark ? const Color(0xFF1C1C1C) : TColors.grey;

    return Obx(() {
      final user = UserController.instance.user.value;
      return Container(
        height: 64,
        margin: EdgeInsets.fromLTRB(isMobile ? 12 : 24, 10, isMobile ? 12 : 24, 0),
        decoration: BoxDecoration(
          color: navBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 0.5),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 14 : 24),
          child: Row(
            children: isMobile
                ? _mobileChildren(context, user, isDark, amber)
                : _desktopChildren(context, user, isDark, amber),
          ),
        ),
      );
    });
  }

  List<Widget> _mobileChildren(BuildContext context, dynamic user, bool isDark, Color amber) {
    return [
      GestureDetector(
        onTap: widget.onMenuTap,
        child: SizedBox(
          width: 38,
          height: 38,
          child: Icon(
            Icons.menu_rounded,
            color: isDark ? Colors.white70 : Colors.black54,
            size: 22,
          ),
        ),
      ),
      const Spacer(),
      _Wordmark(isDark: isDark, amber: amber),
      const Spacer(),
      if (user.id.isNotEmpty)
        _AvatarButton(user: user, amber: amber, isDark: isDark, showUsername: false)
      else
        const SizedBox(width: 34),
    ];
  }

  List<Widget> _desktopChildren(BuildContext context, dynamic user, bool isDark, Color amber) {
    return [
      _Wordmark(
        isDark: isDark,
        amber: amber,
        onTap: () {
          setState(() => _activeIndex = 0);
          widget.onNavItemTap(0);
        },
      ),
      const Spacer(),
      Row(
        children: List.generate(NavBar.navItems.length, (i) {
          final isActive = _activeIndex == i;
          return GestureDetector(
            onTap: () {
              setState(() => _activeIndex = i);
              widget.onNavItemTap(i);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: isActive ? amber.withOpacity(0.1) : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                NavBar.navItems[i],
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontFamily: 'JetBrainsMono',
                      fontSize: 13,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                      color: isActive
                          ? (isDark ? Colors.white : Colors.black)
                          : (isDark ? Colors.white60 : Colors.black54),
                    ),
              ),
            ),
          );
        }),
      ),
      const Spacer(),
      if (user.id.isEmpty)
        Row(
          children: [
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Text(
                  'Login',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontFamily: 'JetBrainsMono',
                        fontSize: 13,
                        color: isDark ? Colors.white60 : Colors.black54,
                      ),
                ),
              ),
            ),
            const SizedBox(width: 4),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: amber,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Text(
                  'Register',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontFamily: 'JetBrainsMono',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0A0A0A),
                      ),
                ),
              ),
            ),
          ],
        )
      else
        _AvatarButton(user: user, amber: amber, isDark: isDark, showUsername: true),
    ];
  }
}

class _Wordmark extends StatelessWidget {
  const _Wordmark({required this.isDark, required this.amber, this.onTap});

  final bool isDark;
  final Color amber;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text.rich(
        TextSpan(
          text: 'STEM',
          style: TextStyle(
            fontFamily: 'JetBrainsMono',
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: isDark ? Colors.white : Colors.black,
          ),
          children: [
            TextSpan(text: '_', style: TextStyle(color: amber)),
            const TextSpan(text: 'Union'),
          ],
        ),
      ),
    );
  }
}

class _AvatarButton extends StatelessWidget {
  const _AvatarButton({
    required this.user,
    required this.amber,
    required this.isDark,
    required this.showUsername,
  });

  final dynamic user;
  final Color amber;
  final bool isDark;
  final bool showUsername;

  @override
  Widget build(BuildContext context) {
    final firstName = (user.firstName as String? ?? '').trim();
    final email = (user.email as String? ?? '').trim();
    final initial = firstName.isNotEmpty
        ? firstName[0].toUpperCase()
        : (email.isNotEmpty ? email[0].toUpperCase() : 'U');
    final profilePic = (user.profilePicture as String? ?? '').trim();
    final username = (user.username as String? ?? '').trim();

    return GestureDetector(
      onTap: () => showProfileDialog(context: context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: amber, width: 1.5),
            ),
            child: ClipOval(
              child: profilePic.isNotEmpty
                  ? Image.network(
                      profilePic,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _initialCircle(initial),
                    )
                  : _initialCircle(initial),
            ),
          ),
          if (showUsername && username.isNotEmpty) ...[
            const SizedBox(width: 8),
            Text(
              '@$username',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontFamily: 'JetBrainsMono',
                    fontSize: 13,
                    color: isDark ? Colors.white60 : Colors.black54,
                  ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 16,
              color: isDark ? Colors.white30 : Colors.black26,
            ),
          ],
        ],
      ),
    );
  }

  Widget _initialCircle(String initial) {
    return Container(
      color: isDark ? const Color(0xFF1A1A1A) : const Color(0xFFEFEFEF),
      child: Center(
        child: Text(
          initial,
          style: TextStyle(
            color: amber,
            fontSize: 13,
            fontWeight: FontWeight.bold,
            fontFamily: 'JetBrainsMono',
          ),
        ),
      ),
    );
  }
}