import 'package:flutter/material.dart';
import 'package:stem_union/utils/constants/image_strings.dart';
import 'package:stem_union/utils/constants/sizes.dart';


class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          height: 150,
          image: AssetImage(
            dark ? TImages.google : TImages.google,
          ),
        ),
        Text(
          'Welcome Back',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: TSizes.sm),
        Text(
          'Please enter your details to sign in',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
