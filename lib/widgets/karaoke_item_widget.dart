import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/karaoke_singer.dart';
import '../providers/karaoke_list_provider.dart';

class KaraokeItemWidget extends HookConsumerWidget {
  final KaraokeSinger singer;
  final int index;

  const KaraokeItemWidget({
    super.key,
    required this.singer,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Opacity(
      opacity: singer.hasSung ? 0.3 : 1.0,
      child: ListTile(
        onTap: () =>
            ref.read(karaokeListProvider.notifier).toggeHasSung(singer.id),
        leading: Text('${index + 1}'),
        title: Text(singer.name),
        subtitle: Text('${singer.singCounter}'),
        // trailing: Row(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
        //     IconButton(
        //       onPressed: () async {
        //         final confirm = await showDialog<bool>(
        //           context: context,
        //           builder: (context) => AlertDialog(
        //             title: const Text('Confirmar exclusão'),
        //             content: Text('Deseja realmente remover "${singer.name}"?'),
        //             actions: [
        //               TextButton(
        //                 onPressed: () => Navigator.of(context).pop(false),
        //                 child: const Text('Cancelar'),
        //               ),
        //               ElevatedButton(
        //                 style: ElevatedButton.styleFrom(
        //                   foregroundColor: Colors.red,
        //                 ),
        //                 onPressed: () => Navigator.of(context).pop(true),
        //                 child: const Text('Remover'),
        //               ),
        //             ],
        //           ),
        //         );
        //         if (confirm == true) {
        //           ref.read(karaokeListProvider.notifier).remove(singer.id);
        //         }
        //       },
        //       icon: Icon(Icons.delete),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
