import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:stem_union/screens/services_page/project_card.dart';
import 'package:stem_union/utils/constants/colors.dart';
import 'package:stem_union/utils/helpers/helper_functions.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final isMobile = context.width < 700; 

    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '// Services',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: isDark ? TColors.secondry : TColors.primary,
                ),
          ),
          const SizedBox(height: 20),
          Text(
            'We provide a range of services to support STEM students.',
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 20),
          Text(
            'STEM-Union connects students across 27 schools — through '
            'STEM-Shop, where you trade with peers nationwide, and STEM-Hub, '
            'where you find and reuse what other schools have already built. '
            'No more starting from zero, alone.',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: TColors.darkGrey,
                  height: 2,
                ),
          ),
          const SizedBox(height: 32),

          isMobile
              ? Column(
                  children: const [
                    _ShopCard(),
                    SizedBox(height: 16),
                    _HubCard(),
                  ],
                )
              : const IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(child: _ShopCard()),
                      SizedBox(width: 16),
                      Expanded(child: _HubCard()),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}

class _ShopCard extends StatelessWidget {
  const _ShopCard();

  @override
  Widget build(BuildContext context) {
    return EcoCard(
      icon: Icons.shopping_bag_outlined,
      pill: 'marketplace',
      name: 'STEM_Shop',
      description:
          'Buy and sell directly with students from any of the 27 schools — '
          'components, kits, devices, anything project-related. One '
          'marketplace instead of 27 disconnected group chats.',
      stats: const [
        ('27', 'schools listed'),
        ('cross-school', 'buy & sell'),
      ],
      linkLabel: 'Open STEM-Shop →',
      onTap: () {
      },
    );
  }
}

class _HubCard extends StatelessWidget {
  const _HubCard();

  @override
  Widget build(BuildContext context) {
    return EcoCard(
      icon: Icons.map_outlined,
      pill: 'directory',
      name: 'STEM_Hub',
      description:
          'A directory of what every school has already built — capstone '
          'guides, exam banks, tools. Find it and reuse it before your '
          'school spends months rebuilding it from scratch.',
      stats: const [
        ('1', 'place to search'),
        ('rated', 'by quality'),
      ],
      linkLabel: 'Open STEM-Hub →',
      onTap: () {
      },
    );
  }
}