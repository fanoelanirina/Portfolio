import 'package:flutter/material.dart';
import '../../core/core.dart';
import '../../core/utils/url_helper.dart';

class SocialIconButton extends StatefulWidget {
  const SocialIconButton({
    super.key,
    required this.icon,
    required this.label,
    required this.url,
  });

  final Widget icon;
  final String label;
  final String url;

  @override
  State<SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<SocialIconButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final foreground = _hovered ? Colors.white : p.textPrimary;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => openUrl(widget.url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          decoration: BoxDecoration(
            color: _hovered ? AppColors.accent : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: _hovered ? AppColors.accent : p.borderStrong,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconTheme(
                data: IconThemeData(color: foreground, size: 18),
                child: widget.icon,
              ),
              const SizedBox(width: 10),
              Text(
                widget.label,
                style: context.text.button.copyWith(color: foreground),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
