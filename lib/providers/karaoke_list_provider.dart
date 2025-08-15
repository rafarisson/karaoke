import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/karaoke_singer.dart';
import '../models/karaoke_list.dart';

final karaokeListProvider =
    StateNotifierProvider<KaraokeList, List<KaraokeSinger>>((ref) {
      return KaraokeList(const []);
    });

enum KaraokeListFilter { all, notSung, sung }

enum KaraokeListSort { none, singCounterAsc, singCounterDesc }

final karaokeListFilter = StateProvider((_) => KaraokeListFilter.all);
final karaokeListSort = StateProvider((_) => KaraokeListSort.singCounterAsc);

final filteredSortedKaraokeSingers = Provider<List<KaraokeSinger>>((ref) {
  final filter = ref.watch(karaokeListFilter);
  final sort = ref.watch(karaokeListSort);
  final singers = ref.watch(karaokeListProvider);

  List<KaraokeSinger> filtered;
  switch (filter) {
    case KaraokeListFilter.all:
      filtered = singers;
      break;
    case KaraokeListFilter.notSung:
      filtered = singers.where((s) => !s.hasSung).toList();
      break;
    case KaraokeListFilter.sung:
      filtered = singers.where((s) => s.hasSung).toList();
      break;
  }

  final result = [...filtered];
  switch (sort) {
    case KaraokeListSort.singCounterAsc:
      result.sort((a, b) => a.singCounter.compareTo(b.singCounter));
      break;
    case KaraokeListSort.singCounterDesc:
      result.sort((a, b) => b.singCounter.compareTo(a.singCounter));
      break;
    case KaraokeListSort.none:
      break;
  }

  return result;
});

final notSungKaraokeSingersCount = Provider<int>((ref) {
  return ref.watch(karaokeListProvider).where((todo) => !todo.hasSung).length;
});
