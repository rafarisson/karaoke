import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/karaoke_list_provider.dart';
import '../providers/karaoke_current_singer_provider.dart';
import '../widgets/karaoke_item_widget.dart';
import '../widgets/menu_widget.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final singers = ref.watch(filteredSortedKaraokeSingers);
    final newSingerController = useTextEditingController();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          children: [
            TextField(
              controller: newSingerController,
              decoration: const InputDecoration(
                labelText: 'What do we need to do?',
              ),
              onSubmitted: (value) {
                ref.read(karaokeListProvider.notifier).add(value);
                newSingerController.clear();
              },
            ),

            const SizedBox(height: 42),

            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                '${ref.watch(notSungKaraokeSingersCount)} pendentes',
                style: const TextStyle(fontSize: 20),
              ),
            ),

            if (singers.isNotEmpty) const Divider(height: 0),
            for (var i = 0; i < singers.length; i++) ...[
              if (i > 0) const Divider(height: 0),
              ProviderScope(
                overrides: [karaokeCurrentSinger.overrideWithValue(singers[i])],
                child: const KaraokeItemWidget(),
              ),
            ],
          ],
        ),
        bottomNavigationBar: const MenuWidget(),
      ),
    );
  }
}
