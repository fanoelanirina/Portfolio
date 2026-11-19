import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/core.dart';
import '../../../../core/utils/url_helper.dart';

class ContactInfoTile extends StatefulWidget {
  const ContactInfoTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.subtitle,
    this.copyMessage,
    this.actionUrl,
    this.actionIcon,
    this.actionTooltip,
  });

  final IconData icon;
  final String label;
  final String value;
  final String? subtitle;
  final String? copyMessage;
  final String? actionUrl;
  final Widget? actionIcon;
  final String? actionTooltip;

  @override
  State<ContactInfoTile> createState() => _ContactInfoTileState();
}

class _ContactInfoTileState extends State<ContactInfoTile> {
  bool _hovered = false;
  bool _copied = false;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _copy() async {
    await Clipboard.setData(ClipboardData(text: widget.value));
    if (!mounted) return;

    setState(() => _copied = true);
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 2), () {
      if (mounted) setState(() => _copied = false);
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(
                Icons.check_circle_outline,
                color: Colors.white,
                size: 18,
              ),
              const SizedBox(width: 10),
              Text(widget.copyMessage!),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.accent,
          width: Responsive.isMobile(context) ? null : 320,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final text = context.text;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.fromLTRB(18, 14, 10, 14),
        decoration: BoxDecoration(
          color: p.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovered ? AppColors.accent : p.border,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(widget.icon, color: AppColors.accent, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.label.toUpperCase(),
                    style: text.menuNumber,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.value,
                    style: text.cardTitle.copyWith(fontSize: 15),
                  ),
                  if (widget.subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(widget.subtitle!, style: text.cardOrg),
                  ],
                ],
              ),
            ),
            if (widget.copyMessage != null)
              IconButton(
                tooltip: context.tr('Copier', 'Copy'),
                onPressed: _copy,
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    _copied ? Icons.check_rounded : Icons.copy_rounded,
                    key: ValueKey(_copied),
                    color: _copied ? AppColors.accent : p.textSecondary,
                    size: 20,
                  ),
                ),
              ),
            if (widget.actionUrl != null)
              IconButton(
                tooltip: widget.actionTooltip,
                onPressed: () => openUrl(widget.actionUrl!),
                icon:
                    widget.actionIcon ??
                    const Icon(
                      Icons.open_in_new,
                      color: AppColors.accent,
                      size: 20,
                    ),
              ),
          ],
        ),
      ),
    );
  }
}
