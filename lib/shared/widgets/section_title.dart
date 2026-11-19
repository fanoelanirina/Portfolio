import 'package:flutter/material.dart';
import '../../core/core.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.number, required this.title});

  final String number;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 28, height: 2, color: AppColors.accent),
        const SizedBox(width: 12),
        Text(
          '$number — ${title.toUpperCase()}',
          style: context.text.sectionLabel,
        ),
      ],
    );
  }
}
