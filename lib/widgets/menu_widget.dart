import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/karaoke_list_provider.dart';

class MenuWidget extends HookConsumerWidget {
  const MenuWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(karaokeListFilter);
    final notSungCount = ref.watch(notSungKaraokeSingersCount);
    final hasSungCount = ref.watch(hasSungKaraokeSingersCount);
    final singers = ref.watch(karaokeListProvider);

    // return BottomAppBar(
    //   shape: CircularNotchedRectangle(),
    //   child: Row(
    //     children: [
    //       IconButton(icon: Icon(Icons.menu), onPressed: () {}),
    //       Spacer(),
    //       IconButton(icon: Icon(Icons.search), onPressed: () {}),
    //       IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
    //     ],
    //   ),
    return BottomNavigationBar(
      // elevation: 0.0,
      onTap: (value) {
        ref.read(karaokeListFilter.notifier).state =
            KaraokeListFilter.values[value];
      },
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Todos ${singers.isEmpty ? '' : singers.length}',
          tooltip: 'Todos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.mic_none),
          label: 'Pendente ${notSungCount == 0 ? '' : notSungCount}',
          tooltip: 'Pendente',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.done),
          label: 'Concluído ${hasSungCount == 0 ? '' : hasSungCount}',
          tooltip: 'Concluído',
        ),
      ],
      currentIndex: filter.index,
      // selectedItemColor: Colors.amber[800],
    );
  }
}
