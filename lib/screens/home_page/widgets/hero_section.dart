import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:stem_union/common/styles/blueprint_background.dart';
import 'package:stem_union/utils/constants/colors.dart';
import 'package:stem_union/utils/helpers/helper_functions.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return BlueprintGrid(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 47),
            Text(
              '-- // built for ambitious STEM students',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: isDark ? TColors.secondry : TColors.primary,
              ),
            ),

            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                text: 'Tools, resources, community, \nand more for ',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: context.width > 600 ? 45 : 30,
                ),
                children: [
                  TextSpan(
                    text: ' STEM students',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: isDark ? TColors.secondry : TColors.primary,
                      fontWeight: FontWeight.w400,
                      fontSize: context.width > 600 ? 45 : 30,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
            SizedBox(
              width: 540,
              child: Text(
                'STEM-Union gives you the guides, software, and digital resources you need — plus a community of students moving in the same direction. Part of the TF-Unions ecosystem.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: TColors.darkGrey,
                  height: 2,
                ),
              ),
            ),

            SizedBox(height: 30),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Text(
                      'Become a volunteer → ',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color:  isDark ? Colors.black : Colors.white,
                      ),
                      
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
