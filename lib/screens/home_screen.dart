import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/karaoke_list_provider.dart';
// import '../providers/karaoke_current_singer_provider.dart';
import '../widgets/karaoke_item_widget.dart';
import '../widgets/menu_widget.dart';
import '../widgets/add_singer_dialog.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final singers = ref.watch(filteredSortedKaraokeSingers);
    // final newSingerController = useTextEditingController();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Karaoke App')),
        body: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(16),
            //   child: TextField(
            //     controller: newSingerController,
            //     decoration: const InputDecoration(
            //       labelText: 'Add singer',
            //       border: OutlineInputBorder(),
            //     ),
            //     onSubmitted: (value) {
            //       ref.read(karaokeListProvider.notifier).add(value);
            //       newSingerController.clear();
            //     },
            //   ),
            // ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: singers.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final singer = singers[index];
                  return KaraokeItemWidget(singer: singer, index: index);
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const AddSingerDialog(),
            );
          },
        ),
        bottomNavigationBar: const MenuWidget(),
      ),
    );
  }
}
