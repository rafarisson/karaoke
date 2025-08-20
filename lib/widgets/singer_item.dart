import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/singer.dart';
import '../providers/singer_list_provider.dart';
import 'alert.dart';
import 'singer_edit_alert.dart';

class SingerItem extends HookConsumerWidget {
  final Singer singer;
  final int index;

  const SingerItem({super.key, required this.singer, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Opacity(
      opacity: singer.hasSung ? 0.4 : 1.0,
      child: Card(
        child: ListTile(
          leading: GestureDetector(
            onTap: () =>
                ref.read(singerListProvider.notifier).toggeHasSung(singer.id),
            child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Icon(
                singer.hasSung ? Icons.mic_off : Icons.mic_none,
                color: Colors.white,
              ),
            ),
          ),
          title: Text(singer.name),
          subtitle: Text('${singer.singCounter}'),
          trailing: Visibility(
            visible: !singer.hasSung,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () =>
                      SingerEditAlert.show(context, ref, singer: singer),
                  icon: const Icon(Icons.edit_outlined),
                  color: Theme.of(context).colorScheme.primary,
                ),
                IconButton(
                  onPressed: () async {
                    final confirm = await Alert.show(
                      context: context,
                      content: Text('Deseja realmente apagar: ${singer.name}'),
                    );
                    if (confirm == true) {
                      ref.read(singerListProvider.notifier).remove(singer.id);
                    }
                  },
                  icon: const Icon(Icons.delete_outline),
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
