import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/singer.dart';
import '../notifiers/singer_list_notifier.dart';
import 'singer_repository_provider.dart';

final singerListProvider = StateNotifierProvider<SingerList, List<Singer>>((
  ref,
) {
  final repository = ref.watch(singerRepositoryProvider);
  return SingerList(repository);
});
