import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/singer_list_provider.dart';
import '../providers/singer_filter_provider.dart';
import 'singer_edit_alert.dart';
import 'alert.dart';

class NavBar extends HookConsumerWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allSingers = ref.watch(singerListProvider);
    // final filteredSingers = ref.watch(singerListFilterProvider);
    // final notSungCount = ref.watch(singerListNotSungProvider).length;
    // final hasSungCount = ref.watch(singerListHasSungProvider).length;

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 6,
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.add),
            tooltip: 'Adicionar',
            onPressed: () => SingerEditAlert.show(context, ref),
          ),
          Spacer(),
          SegmentedButton<SingerListFilterType>(
            showSelectedIcon: false,
            selected: <SingerListFilterType>{
              ref.watch(singerListFilterProvider),
            },
            onSelectionChanged: (Set<SingerListFilterType> newSelection) {
              ref.read(singerListFilterProvider.notifier).state =
                  newSelection.first;
            },
            segments: const <ButtonSegment<SingerListFilterType>>[
              ButtonSegment(
                icon: Icon(Icons.format_list_bulleted),
                value: SingerListFilterType.all,
              ),
              ButtonSegment(
                icon: Icon(Icons.mic_none),
                value: SingerListFilterType.notSung,
              ),
              ButtonSegment(
                icon: Icon(Icons.mic_off),
                value: SingerListFilterType.hasSung,
              ),
            ],
          ),
          // ToggleButtons(
          //   isSelected: [true, false, false],
          //   children: const <Widget>[
          //     Icon(Icons.ac_unit),
          //     Icon(Icons.call),
          //     Icon(Icons.cake),
          //   ],
          // ),
          // _buildFilterButton(
          //   context: context,
          //   ref: ref,
          //   icon: Icons.format_list_bulleted,
          //   type: SingerListFilterType.all,
          // ),
          // _buildFilterButton(
          //   context: context,
          //   ref: ref,
          //   icon: Icons.mic_none,
          //   type: SingerListFilterType.notSung,
          // ),
          // _buildFilterButton(
          //   context: context,
          //   ref: ref,
          //   icon: Icons.done,
          //   type: SingerListFilterType.hasSung,
          // ),
          Spacer(),
          IconButton(
            icon: Icon(Icons.delete_outline_outlined),
            tooltip: 'Apagar todos',
            onPressed: allSingers.isNotEmpty
                ? () async {
                    final confirm = await Alert.show(
                      context: context,
                      content: const Text(
                        'Deseja realmente apagar todos os itens?',
                      ),
                    );
                    if (confirm == true) {
                      ref.read(singerListProvider.notifier).clear();
                    }
                  }
                : null,
          ),
        ],
      ),
    );
  }

  // Widget _buildFilterButton({
  //   required BuildContext context,
  //   required WidgetRef ref,
  //   required IconData icon,
  //   required SingerListFilterType type,
  // }) {
  //   final current = ref.watch(singerListFilterProvider);

  //   return Container(
  //     decoration: BoxDecoration(
  //       shape: BoxShape.circle,
  //       color: current == type
  //           ? Theme.of(context).colorScheme.primaryContainer
  //           : null,
  //     ),
  //     child: IconButton(
  //       icon: Icon(icon),
  //       onPressed: () =>
  //           ref.read(singerListFilterProvider.notifier).state = type,
  //       color: current == type ? Theme.of(context).colorScheme.primary : null,
  //     ),
  //   );
  // }
}
