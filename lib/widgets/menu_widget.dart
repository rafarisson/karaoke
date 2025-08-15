import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/karaoke_list_provider.dart';

class MenuWidget extends HookConsumerWidget {
  const MenuWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(karaokeListFilter);

    return BottomNavigationBar(
      elevation: 0.0,
      onTap: (value) {
        ref.read(karaokeListFilter.notifier).state =
            KaraokeListFilter.values[value];
      },
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Todos',
          tooltip: 'Todos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.circle),
          label: 'Pendente',
          tooltip: 'Pendente',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.done),
          label: 'Concluído',
          tooltip: 'Concluído',
        ),
      ],
      currentIndex: filter.index,
      // selectedItemColor: Colors.amber[800],
    );
  }
}
