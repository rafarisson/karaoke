import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import '../providers/singer_list_provider.dart';
import '../providers/singer_filter_provider.dart';
import '../widgets/singer_item.dart';
// import '../widgets/singer_edit_alert.dart';
import '../widgets/navbar.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final allSingers = ref.watch(singerListProvider);
    final filteredSingers = ref.watch(singerListFilterSortProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Karaoke App'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Expanded(
            // child: ListView.separated(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredSingers.length,
              // separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final singer = filteredSingers[index];
                return SingerItem(singer: singer, index: index);
              },
            ),
          ),
        ],
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => SingerEditAlert.show(context, ref),
      //   tooltip: 'Adicionar',
      //   shape: CircleBorder(),
      //   child: const Icon(Icons.add),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const NavBar(),
    );
  }
}
