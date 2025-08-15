import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/karaoke_list_provider.dart';
import '../providers/karaoke_current_singer_provider.dart';
import '../utils/focus_hook.dart';

class KaraokeItemWidget extends HookConsumerWidget {
  const KaraokeItemWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final singer = ref.watch(karaokeCurrentSinger);
    final itemFocusNode = useFocusNode();
    final itemIsFocused = useIsFocused(itemFocusNode);

    final textEditingController = useTextEditingController();
    final textFieldFocusNode = useFocusNode();

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: singer.hasSung ? 0.3 : 1.0,
      child: Material(
        color: Colors.white,
        elevation: 6,
        child: Focus(
          focusNode: itemFocusNode,
          onFocusChange: (focused) {
            if (focused) {
              textEditingController.text = singer.name;
            } else {
              ref
                  .read(karaokeListProvider.notifier)
                  .edit(id: singer.id, name: textEditingController.text);
            }
          },
          child: ListTile(
            onTap: () {
              itemFocusNode.requestFocus();
              textFieldFocusNode.requestFocus();
            },
            leading: Checkbox(
              value: singer.hasSung,
              onChanged: (value) => ref
                  .read(karaokeListProvider.notifier)
                  .toggeHasSung(singer.id),
            ),
            title: itemIsFocused
                ? TextField(
                    autofocus: true,
                    focusNode: textFieldFocusNode,
                    controller: textEditingController,
                  )
                : Text('${singer.name} ${singer.singCounter}'),
          ),
        ),
      ),
    );
  }
}
