import 'package:flutter/material.dart';

enum FileOptions { photo }

class SelectableItem {
  final IconData icon;
  final String text;

  const SelectableItem({
    required this.icon,
    required this.text,
  });
}

class popUpItems {
  static const List<SelectableItem> popupContents = [photo];

  static const photo = SelectableItem(icon: Icons.insert_photo, text: 'Photo');
}
