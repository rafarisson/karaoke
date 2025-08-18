import 'package:flutter/material.dart';

import '../models/karaoke_singer.dart';

class KaraokeSingerEdit {
  static Future<bool?> show(
    BuildContext context, {
    required KaraokeSinger singer,
    String title = 'Cantor',
    String confirmText = 'OK',
    String cancelText = 'Cancelar',
  }) async {
    final controller = TextEditingController(text: singer.name);

    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Nome'),
          autofocus: true,
          textCapitalization: TextCapitalization.words,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }
}
