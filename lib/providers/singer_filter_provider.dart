import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/singer.dart';
import 'singer_list_provider.dart';

enum SingerListFilterType { all, notSung, hasSung }

final singerListFilterProvider = StateProvider((_) => SingerListFilterType.all);

final singerListFilterSortProvider = Provider<List<Singer>>((ref) {
  final filter = ref.watch(singerListFilterProvider);
  final singers = ref.watch(singerListProvider);

  List<Singer> filtered;
  switch (filter) {
    case SingerListFilterType.all:
      filtered = singers;
      break;
    case SingerListFilterType.notSung:
      filtered = singers.where((s) => !s.hasSung).toList();
      break;
    case SingerListFilterType.hasSung:
      filtered = singers.where((s) => s.hasSung).toList();
      break;
  }
  filtered.sort((a, b) => a.singCounter.compareTo(b.singCounter));

  return filtered;
});

final singerListNotSungProvider = Provider<List<Singer>>((ref) {
  return ref.watch(singerListProvider).where((s) => !s.hasSung).toList();
});

final singerListHasSungProvider = Provider<List<Singer>>((ref) {
  return ref.watch(singerListProvider).where((s) => s.hasSung).toList();
});
