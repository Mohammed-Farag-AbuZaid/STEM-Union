import 'package:flutter/material.dart';
import 'package:stem_union/common/styles/blueprint_background.dart';
import 'package:stem_union/utils/constants/colors.dart';
import 'package:stem_union/utils/helpers/helper_functions.dart';

class EcoCard extends StatelessWidget {
  const EcoCard({
    super.key,
    required this.icon,
    required this.pill,
    required this.name,
    required this.description,
    required this.stats,
    required this.linkLabel,
    this.onTap,
  });

  final IconData icon;
  final String pill;
  final String name;
  final String description;
  final List<(String, String)> stats;
  final String linkLabel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final amber = isDark ? TColors.secondry : TColors.primary;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0D0D0D) : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDark ? const Color(0xFF1E1E1E) : TColors.grey,
          width: 0.5,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: BlueprintGrid(
        child: Padding(
          padding: const EdgeInsets.all(32),

          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // .eco-top
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // .eco-icon
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF130D00),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(icon, color: amber, size: 18),
                    ),
                    // .eco-pill
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: amber.withOpacity(0.3),
                          width: 0.5,
                        ),
                      ),
                      child: Text(
                        pill,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: amber,
                          fontFamily: 'JetBrainsMono',
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),
                // .eco-name
                Text(
                  name,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 10),
                // .eco-desc
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Text(
                    description,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: TColors.darkGrey,
                      fontSize: 13,
                      height: 1.7,
                    ),
                  ),
                ),

                const SizedBox(height: 22),

                Wrap(
                  spacing: 24,
                  runSpacing: 12,
                  children: [
                    for (final (number, label) in stats)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // .eco-stat-num
                          Text(
                            number,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontFamily: 'JetBrainsMono',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: isDark
                                      ? TColors.grey
                                      : TColors.darkerGrey,
                                ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            label,
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  fontFamily: 'JetBrainsMono',
                                  fontSize: 10,
                                  color: TColors.darkGrey,
                                ),
                          ),
                        ],
                      ),
                  ],
                ),

                const SizedBox(height: 22),
                // .eco-link
                InkWell(
                  onTap: onTap,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        linkLabel,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontFamily: 'JetBrainsMono',
                          fontSize: 12,
                          color: amber,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
