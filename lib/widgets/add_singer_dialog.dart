import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/karaoke_list_provider.dart';

class AddSingerDialog extends HookConsumerWidget {
  const AddSingerDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newSingerController = TextEditingController();

    return AlertDialog(
      title: const Text('Adicionar cantor'),
      content: TextField(
        controller: newSingerController,
        decoration: const InputDecoration(labelText: 'Nome'),
        autofocus: true,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            final name = newSingerController.text.trim();
            if (name.isNotEmpty) {
              ref.read(karaokeListProvider.notifier).add(name);
            }
            Navigator.of(context).pop();
          },
          child: const Text('Adicionar'),
        ),
      ],
    );
  }
}
