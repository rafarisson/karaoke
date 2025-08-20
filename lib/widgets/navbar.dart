import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// import '../providers/singer_list_provider.dart';
import '../providers/singer_filter_provider.dart';

class NavBar extends HookConsumerWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final allSingers = ref.watch(singerListProvider);
    // final filteredSingers = ref.watch(singerListFilterProvider);
    // final notSungCount = ref.watch(singerListNotSungProvider).length;
    // final hasSungCount = ref.watch(singerListHasSungProvider).length;

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 6,
      child: Row(
        children: [
          _buildFilterButton(
            context: context,
            ref: ref,
            icon: Icons.format_list_bulleted,
            type: SingerListFilterType.all,
          ),
          Spacer(),
          _buildFilterButton(
            context: context,
            ref: ref,
            icon: Icons.mic_none,
            type: SingerListFilterType.notSung,
          ),
          _buildFilterButton(
            context: context,
            ref: ref,
            icon: Icons.done,
            type: SingerListFilterType.hasSung,
          ),
        ],
      ),
    );

    // return BottomNavigationBar(
    //   // elevation: 0.0,
    //   onTap: (value) {
    //     ref.read(singerListFilterProvider.notifier).state =
    //         SingerListFilterType.values[value];
    //   },
    //   items: <BottomNavigationBarItem>[
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.list),
    //       label: 'Todos ${allSingers.isEmpty ? '' : allSingers.length}',
    //       tooltip: 'Todos',
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.mic_none),
    //       label: 'Pendente ${notSungCount == 0 ? '' : notSungCount}',
    //       tooltip: 'Pendente',
    //     ),
    //     // BottomNavigationBarItem(
    //     //   icon: Icon(Icons.done),
    //     //   label: 'Concluído ${hasSungCount == 0 ? '' : hasSungCount}',
    //     //   tooltip: 'Concluído',
    //     // ),
    //   ],
    //   currentIndex: filteredSingers.index,
    //   selectedItemColor: Theme.of(context).colorScheme.primary,
    // );
  }

  Widget _buildFilterButton({
    required BuildContext context,
    required WidgetRef ref,
    required IconData icon,
    required SingerListFilterType type,
  }) {
    final current = ref.watch(singerListFilterProvider);

    // return IconButton(
    //   icon: Icon(icon),
    //   onPressed: () => ref.read(singerListFilterProvider.notifier).state = type,
    //   color: current == type ? Theme.of(context).colorScheme.primary : null,
    // );

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: current == type
            ? Theme.of(context).colorScheme.primaryContainer
            : null,
      ),
      child: IconButton(
        icon: Icon(icon),
        onPressed: () =>
            ref.read(singerListFilterProvider.notifier).state = type,
        color: current == type ? Theme.of(context).colorScheme.primary : null,
      ),
    );

    // return TextButton.icon(
    //   onPressed: () => ref.read(singerListFilterProvider.notifier).state = type,
    //   label: current == type ? Text(label) : Text(''),
    //   icon: Icon(icon),
    // );

    // return Row(
    //   children: [
    //     IconButton(
    //       icon: Icon(icon),
    //       onPressed: () =>
    //           ref.read(singerListFilterProvider.notifier).state = type,
    //       color: current == type ? Theme.of(context).colorScheme.primary : null,
    //     ),
    //     Visibility(visible: current == type, child: Text(label)),
    //   ],
    // );
  }
}
