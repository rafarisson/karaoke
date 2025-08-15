// lib/widgets/add_singer_alert.dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/karaoke_list_provider.dart';
import 'karaoke_alert.dart';

class AddSingerAlert {
  static Future<void> show(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController();

    final confirmed = await KaraokeAlert.show(
      context: context,
      title: 'Adicionar cantor',
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(labelText: 'Nome'),
        autofocus: true,
      ),
      cancelText: 'Cancelar',
      confirmText: 'Adicionar',
    );

    if (confirmed == true) {
      final name = controller.text.trim();
      if (name.isNotEmpty) {
        ref.read(karaokeListProvider.notifier).add(name);
      }
    }
  }
}
