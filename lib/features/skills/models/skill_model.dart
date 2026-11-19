import 'package:flutter/widgets.dart';

class SkillItem {
  const SkillItem(this.name, {this.detail, this.logoAssets = const []});

  final String name;
  final String? detail;
  final List<String> logoAssets;
}

class SkillGroup {
  const SkillGroup({this.label, required this.items});

  final String? label;
  final List<SkillItem> items;

  bool get isDetailed => items.every((item) => item.detail != null);
}

class SkillCategory {
  const SkillCategory({
    required this.icon,
    required this.title,
    required this.groups,
    this.badge,
  });

  final IconData icon;
  final String title;
  final String? badge;
  final List<SkillGroup> groups;
}
