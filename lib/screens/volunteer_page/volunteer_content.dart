import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:stem_union/utils/constants/colors.dart';
import 'package:stem_union/utils/helpers/helper_functions.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class VolunteerContent extends StatelessWidget {
  const VolunteerContent({super.key});

  static const _volunteerUrl = 'https://tfunions.vercel.app/volunteer';

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final isMobile = context.width < 700;
    final amber = isDark ? TColors.secondry : TColors.primary;
    final textColor = isDark ? Colors.white : Colors.black;
    final mutedColor = isDark ? Colors.white60 : Colors.black54;
    final noteBg = isDark ? const Color(0xFF0D0D0D) : const Color(0xFFF7F7F7);
    final noteBorder = isDark ? const Color(0xFF1E1E1E) : TColors.grey;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 40,
        vertical: 48,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 640),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '// join the team',
              style: TextStyle(
                fontFamily: 'JetBrainsMono',
                fontSize: 11,
                color: amber,
              ),
            ),
            const SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: 'Help build it.\n',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w300,
                  color: textColor,
                  height: 1.3,
                ),
                children: [
                  TextSpan(
                    text: 'Volunteer with us.',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'STEM-Union is community-built. We need students who '
              'want to contribute to STEM-Shop, STEM-Hub, and '
              'everything else we run.',
              style: TextStyle(
                fontSize: 14,
                color: mutedColor,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              decoration: BoxDecoration(
                color: noteBg,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: noteBorder, width: 0.5),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, color: amber, size: 16),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: 'Volunteering is managed through ',
                        style: TextStyle(
                          fontSize: 12.5,
                          color: mutedColor,
                          height: 1.7,
                        ),
                        children: [
                          TextSpan(
                            text: 'TF-Unions',
                            style: TextStyle(
                              color: textColor.withOpacity(0.8),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const TextSpan(
                              text: ', not STEM-Union directly. Apply there, pick '),
                          TextSpan(
                            text: 'STEM-Union',
                            style: TextStyle(
                              color: textColor.withOpacity(0.8),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const TextSpan(
                              text:
                                  ', then choose which part of it you want to help with.'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            ElevatedButton(
              onPressed: () => launcher.launchUrl(Uri.parse('https://tfunions.vercel.app/')),
              style: ElevatedButton.styleFrom(
                backgroundColor: amber,
                foregroundColor: const Color(0xFF0A0A0A),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                elevation: 0,
              ),
              child: const Text(
                'Volunteer via TF-Unions →',
                style: TextStyle(
                  fontFamily: 'JetBrainsMono',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}