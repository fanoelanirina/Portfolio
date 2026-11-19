import 'package:flutter/material.dart';
import '../../core/core.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.label,
    this.icon,
    this.filled = true,
    this.onPressed,
    this.fontSize,
    this.foregroundColor,
    this.scale = 1.0,
  });

  final String label;
  final IconData? icon;
  final bool filled;
  final VoidCallback? onPressed;
  final double? fontSize;
  final Color? foregroundColor;
  final double scale;

  @override
  Widget build(BuildContext context) {
    final textStyle = context.text.button;
    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 18 * scale),
          SizedBox(width: 8 * scale),
        ],
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label,
              maxLines: 1,
              softWrap: false,
              textAlign: TextAlign.center,
              style: textStyle.copyWith(
                fontSize: (fontSize ?? textStyle.fontSize ?? 14) * scale,
                color: foregroundColor,
              ),
            ),
          ),
        ),
      ],
    );

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12 * scale),
    );
    final padding = EdgeInsets.symmetric(
      horizontal: 20 * scale,
      vertical: 15 * scale,
    );

    // () {} : action vide pour l'instant (sinon le bouton apparaît désactivé)
    final action = onPressed ?? () {};

    return filled
        ? ElevatedButton(
            onPressed: action,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: Colors.white,
              elevation: 2, // Légère élévation moderne
              shadowColor: AppColors.accent.withValues(alpha: 0.4),
              padding: padding,
              shape: shape,
            ),
            child: content,
          )
        : OutlinedButton(
            onPressed: action,
            style: OutlinedButton.styleFrom(
              backgroundColor:
                  Colors.transparent, // Fond transparent plus élégant
              foregroundColor: foregroundColor ?? context.palette.textPrimary,
              side: BorderSide(
                color: AppColors.accent.withValues(alpha: 0.4),
                width: 1.5, // Épaisseur idéale pour la visibilité
              ),
              padding: padding,
              shape: shape,
            ),
            child: content,
          );
  }
}
