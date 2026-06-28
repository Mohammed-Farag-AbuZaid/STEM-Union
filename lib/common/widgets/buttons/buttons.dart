import 'package:flutter/material.dart';
import 'package:stem_union/utils/constants/colors.dart';
import 'package:stem_union/utils/helpers/helper_functions.dart';

class VolunteerButton extends StatelessWidget {
  const VolunteerButton({super.key, this.text = 'Become a volunteer '});

  final String text;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return ElevatedButton(
      onPressed: () {},
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Text(
          "$text →",
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: isDark ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}

class TransparentButton extends StatelessWidget {
  const TransparentButton({super.key, this.text = 'Learn more'});
  final String text;
  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        side: BorderSide(color: isDark ? TColors.grey : TColors.darkerGrey),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: isDark ? TColors.grey : TColors.darkerGrey,
        ),
      ),
    );
  }
}
