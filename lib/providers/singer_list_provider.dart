import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/singer.dart';
import '../notifiers/singer_list_notifier.dart';

final singerListProvider = StateNotifierProvider<SingerList, List<Singer>>((
  ref,
) {
  return SingerList();
});
