import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:stem_union/utils/constants/colors.dart';
import 'package:stem_union/utils/helpers/helper_functions.dart';

class MissionStrip extends StatelessWidget {
  const MissionStrip({super.key});

  static const _items = [
    _MissionItem(
      label: '// our mission',
      text:
          'Help STEM students learn faster, grow in a structured way, and access real opportunities.',
    ),
    _MissionItem(
      label: '// who we serve',
      text:
          'Any student with goals in science, tech, engineering, or math — regardless of school or background.',
    ),
    _MissionItem(
      label: '// how we operate',
      text:
          'Non-profit, volunteer-driven, and community-built. Everything we make is free or low-cost for students.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final isMobile = context.width < 700;
    final borderColor = isDark ? TColors.darkerGrey : TColors.grey;

    final children = <Widget>[];
    for (var i = 0; i < _items.length; i++) {
      final isLast = i == _items.length - 1;

      children.add(
        _MissionCell(
          item: _items[i],
          isDark: isDark,
          isMobile: isMobile,
          border: isLast
              ? null
              : Border(
                  right: isMobile
                      ? BorderSide.none
                      : BorderSide(color: borderColor, width: 1),
                  bottom: isMobile
                      ? BorderSide(color: borderColor, width: 1)
                      : BorderSide.none,
                ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 40,
        vertical: 32,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: borderColor, width: 1),
          bottom: BorderSide(color: borderColor, width: 1),
        ),
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            )
          : IntrinsicHeight(
              // Lets each column's divider stretch to match the tallest
              // column's content height, instead of only its own height.
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children
                    .map((c) => Expanded(child: c))
                    .toList(growable: false),
              ),
            ),
    );
  }
}

class _MissionItem {
  const _MissionItem({required this.label, required this.text});
  final String label;
  final String text;
}

class _MissionCell extends StatelessWidget {
  const _MissionCell({
    required this.item,
    required this.isDark,
    required this.isMobile,
    required this.border,
  });

  final _MissionItem item;
  final bool isDark;
  final bool isMobile;
  final Border? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        right: isMobile ? 0 : 32,
        bottom: isMobile ? 16 : 0,
        top: isMobile ? 16 : 0,
      ),
      decoration: BoxDecoration(border: border),
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              item.label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: isDark ? TColors.secondry : TColors.primary,
                    fontFamily: 'JetBrainsMono',
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              item.text,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: isDark ? TColors.grey : TColors.darkerGrey,
                    height: 1.6,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}