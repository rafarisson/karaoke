import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../models/karaoke_singer.dart';
import '../providers/karaoke_list_provider.dart';

import 'karaoke_alert.dart';
import 'karaoke_singer_edit.dart';
import 'add_singer_dialog.dart';

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
    return Slidable(
      key: ValueKey(singer.id),
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        extentRatio: 0.3,
        children: [
          SlidableAction(
            onPressed: (context) async =>
                await removeItem(context, ref, singer),
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Apagar',
          ),
        ],
      ),
      startActionPane: ActionPane(
        motion: const StretchMotion(),
        extentRatio: 0.3,
        children: [
          SlidableAction(
            onPressed: (context) =>
                AddSingerAlert.show(context, ref, singer: singer),
            backgroundColor: const Color(0xFF0392CF),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Editar',
          ),
        ],
      ),
      child: Opacity(
        opacity: singer.hasSung ? 0.4 : 1.0,
        child: ListTile(
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${index + 1}'),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => ref
                    .read(karaokeListProvider.notifier)
                    .toggeHasSung(singer.id),
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Icon(
                    singer.hasSung ? Icons.mic_off : Icons.mic_none,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          title: Text(singer.name),
          subtitle: Text('${singer.singCounter}'),
        ),
      ),
    );
    // return Opacity(
    //   opacity: singer.hasSung ? 0.3 : 1.0,
    //   child: Card(
    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    //     margin: EdgeInsets.zero,
    //     child: ListTile(
    //       leading: Row(
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           Text('${index + 1}'),
    //           const SizedBox(width: 8),
    //           GestureDetector(
    //             onTap: () => ref
    //                 .read(karaokeListProvider.notifier)
    //                 .toggeHasSung(singer.id),
    //             child: CircleAvatar(
    //               backgroundColor: Theme.of(context).colorScheme.primary,
    //               child: Icon(
    //                 singer.hasSung ? Icons.mic_off : Icons.mic_none,
    //                 color: Colors.white,
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //       title: Text(singer.name),
    //       subtitle: Text('${singer.singCounter}'),
    //       onTap: () => KaraokeSingerEdit.show(context, singer: singer),
    //     ),
    //   ),
    // );
  }

  Future<void> removeItem(
    BuildContext context,
    WidgetRef ref,
    KaraokeSinger singer,
  ) async {
    final confirm = await KaraokeAlert.show(
      context: context,
      content: Text('Deseja realmente apagar: ${singer.name}'),
    );
    if (confirm == true) {
      ref.read(karaokeListProvider.notifier).remove(singer.id);
    }
  }
}
