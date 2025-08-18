import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/karaoke_singer.dart';
import '../providers/karaoke_list_provider.dart';

import 'karaoke_alert.dart';

class AddSingerAlert {
  static Future<void> show(
    BuildContext context,
    WidgetRef ref, {
    KaraokeSinger? singer,
  }) async {
    final controller = TextEditingController(text: singer?.name ?? '');

    final isEditing = singer != null;

    final confirmed = await KaraokeAlert.show(
      context: context,
      title: isEditing ? 'Editar cantor' : 'Adicionar cantor',
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(labelText: 'Nome'),
        autofocus: true,
        textCapitalization: TextCapitalization.words,
      ),
      cancelText: 'Cancelar',
      confirmText: isEditing ? 'Salvar' : 'Adicionar',
    );

    if (confirmed == true) {
      final name = controller.text.trim();
      if (name.isNotEmpty) {
        if (isEditing) {
          ref
              .read(karaokeListProvider.notifier)
              .edit(id: singer.id, name: name);
        } else {
          ref.read(karaokeListProvider.notifier).add(name);
        }
      }
    }
  }
}
