import 'package:flutter/material.dart';

class LogoBadge extends StatelessWidget {
  const LogoBadge({
    super.key,
    required this.asset,
    required this.fallback,
    this.size = 64,
  });

  final String asset;
  final String fallback;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(size * 0.125),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(size * 0.28),
      ),
      child: Image.asset(
        asset,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stack) => Center(
          child: Text(
            fallback,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w700,
              fontSize: size * 0.2,
            ),
          ),
        ),
      ),
    );
  }
}
