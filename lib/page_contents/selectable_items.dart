import 'package:flutter/material.dart';

enum FileOptions { photo, video, voiceRecording, document }

class SelectableItem {
  final IconData icon;
  final String text;

  const SelectableItem({
    required this.icon,
    required this.text,
  });
}

class popUpItems {
  static const List<SelectableItem> popupContents = [
    photo,
    video,
    recording,
    document,
  ];

  static const photo = SelectableItem(
    icon: Icons.insert_photo,
    text: 'Photo'
  );
static const video = SelectableItem(
    icon: Icons.videocam,
    text: 'Video'
  );
static const recording = SelectableItem(
    icon: Icons.keyboard_voice,
    text: 'Audio'
  );
static const document = SelectableItem(
    icon: Icons.insert_drive_file,
    text: 'File'
  );
}
