import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class AccentText extends StatelessWidget {
  const AccentText(this.text, {super.key, required this.style});

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    final parts = text.split('**');
    return Text.rich(
      TextSpan(
        children: [
          for (var i = 0; i < parts.length; i++)
            TextSpan(
              text: parts[i],
              style: i.isOdd
                  ? const TextStyle(
                      color: AppColors.accent,
                      fontWeight: FontWeight.w600,
                    )
                  : null,
            ),
        ],
      ),
      style: style,
    );
  }
}
