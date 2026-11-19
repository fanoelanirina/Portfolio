import 'package:flutter/material.dart';
import '../../../../core/core.dart';

/// Une étape de la frise : point + ligne verticale + carte avec logo.
class TimelineEntry extends StatelessWidget {
  const TimelineEntry({
    super.key,
    required this.logoAsset,
    required this.logoFallback,
    required this.title,
    required this.organization,
    required this.description,
    this.period = '',
    this.isFirst = false,
    this.isLast = false,
  });

  final String logoAsset;
  final String logoFallback;
  final String title;
  final String organization;
  final String description;
  final String period;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final lineColor = AppColors.accent.withValues(alpha: 0.3);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 20,
            child: Column(
              children: [
                isFirst
                    ? const SizedBox(height: 26)
                    : Container(width: 2, height: 26, color: lineColor),
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accent.withValues(alpha: 0.5),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),
                if (!isLast)
                  Expanded(child: Container(width: 2, color: lineColor)),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 24),
              child: _buildCard(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: context.palette.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.palette.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _LogoBadge(asset: logoAsset, fallback: logoFallback),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (period.isNotEmpty) ...[
                  Text(period, style: context.text.menuNumber),
                  const SizedBox(height: 4),
                ],
                Text(title, style: context.text.cardTitle),
                const SizedBox(height: 2),
                Text(organization, style: context.text.cardOrg),
                const SizedBox(height: 8),
                Text(description, style: context.text.cardSubtitle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LogoBadge extends StatelessWidget {
  const _LogoBadge({required this.asset, required this.fallback});

  final String asset;
  final String fallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Image.asset(
        asset,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stack) => Center(
          child: Text(
            fallback,
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}
