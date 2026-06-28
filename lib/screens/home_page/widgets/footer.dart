import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:stem_union/screens/home_page/app_routs.dart';
import 'package:stem_union/utils/constants/colors.dart';
import 'package:stem_union/utils/helpers/helper_functions.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class StemUnionFooter extends StatelessWidget {
  const StemUnionFooter({super.key});

  static const _links = [
    '/ services',
    '/ volunteer',
    '/ stem shop',
    '/ stem hub',
    '/ tf-unions',
  ];

  void _handleLinkTap(int index) {
    switch (index) {
      case 0:
        Get.offAllNamed(AppRoutes.home);
        break;
      case 1:
        Get.toNamed(AppRoutes.volunteer);
        break;
      case 2:
        url_launcher.launchUrl(Uri.parse('https://stem-shop.vercel.app/'));
        break;
      case 3:
        url_launcher.launchUrl(Uri.parse('https://stem-hub.vercel.app/'));
        break;
      case 4:
        url_launcher.launchUrl(Uri.parse('https://tfunions.vercel.app/'));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final isMobile = context.width < 700;

    final borderColor = isDark ? const Color(0xFF1A1A1A) : TColors.grey;
    final logoColor = isDark
        ? const Color(0xFF333333)
        : const Color(0xFFAAAAAA);
    final amber = isDark ? TColors.secondry : TColors.primary;
    final linkColor = isDark
        ? const Color(0xFF333333)
        : const Color(0xFFAAAAAA);
    final rightColor = isDark
        ? const Color(0xFF222222)
        : const Color(0xFFBBBBBB);

    final logo = Text.rich(
      TextSpan(
        text: 'STEM',
        style: TextStyle(
          fontFamily: 'JetBrainsMono',
          fontSize: 13,
          color: logoColor,
        ),
        children: [
          TextSpan(
            text: '_',
            style: TextStyle(color: amber),
          ),
          const TextSpan(text: 'Union · part of  '),
          TextSpan(
            text: 'TF-Unions',
            style: TextStyle(color: amber),
          ),
        ],
      ),
    );

    final links = Wrap(
      spacing: 20,
      runSpacing: 8,
      children: [
        for (final link in _links)
          _FooterLink(
            text: link,
            color: linkColor,
            amber: amber,
            onTap: () {
              final index = _links.indexOf(link);
              _handleLinkTap(index);
            },
          ),
      ],
    );

    final copyright = Text(
      '© 2026 TF-Unions non-profit',
      style: TextStyle(
        fontFamily: 'JetBrainsMono',
        fontSize: 11,
        color: rightColor,
      ),
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 40,
        vertical: 28,
      ),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: borderColor, width: 0.5)),
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                logo,
                const SizedBox(height: 16),
                links,
                const SizedBox(height: 16),
                copyright,
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [logo, links, copyright],
            ),
    );
  }
}

class _FooterLink extends StatefulWidget {
  const _FooterLink({
    required this.text,
    required this.color,
    required this.amber,
    required this.onTap,
  });

  final String text;
  final Color color;
  final Color amber;
  final VoidCallback onTap;

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Text(
          widget.text,
          style: TextStyle(
            fontFamily: 'JetBrainsMono',
            fontSize: 11,
            color: _hovering ? widget.amber : widget.color,
          ),
        ),
      ),
    );
  }
}
