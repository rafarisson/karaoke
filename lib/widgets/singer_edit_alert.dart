import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/singer.dart';
import '../providers/singer_list_provider.dart';
import 'alert.dart';

class SingerEditAlert {
  static Future<void> show(
    BuildContext context,
    WidgetRef ref, {
    Singer? singer,
  }) async {
    final controller = TextEditingController(text: singer?.name ?? '');

    final isEditing = singer != null;

    final confirmed = await Alert.show(
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
          ref.read(singerListProvider.notifier).edit(id: singer.id, name: name);
        } else {
          ref.read(singerListProvider.notifier).add(name);
        }
      }
    }
  }
}
