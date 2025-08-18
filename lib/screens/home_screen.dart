import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../providers/karaoke_list_provider.dart';
// import '../providers/karaoke_current_singer_provider.dart';
import '../widgets/karaoke_item_widget.dart';
import '../widgets/menu_widget.dart';
import '../widgets/add_singer_dialog.dart';
import '../widgets/karaoke_alert.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final singers = ref.watch(karaokeListProvider);
    final singersSorted = ref.watch(filteredSortedKaraokeSingers);
    // final newSingerController = useTextEditingController();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Karaoke App'),
          actions: [
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: (value) async {
                if (value == 'clear') {
                  if (singers.isNotEmpty) {
                    final confirm = await KaraokeAlert.show(
                      context: context,
                      content: const Text(
                        'Deseja realmente apagar todos os itens?',
                      ),
                    );
                    if (confirm == true) {
                      ref.read(karaokeListProvider.notifier).clear();
                    }
                  }
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'clear',
                  enabled: singers.isNotEmpty,
                  child: Text('Limpar lista'),
                ),
              ],
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: SlidableAutoCloseBehavior(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: singersSorted.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final singer = singersSorted[index];
                    return KaraokeItemWidget(singer: singer, index: index);
                  },
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => AddSingerAlert.show(context, ref),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: const MenuWidget(),
      ),
    );
  }
}
