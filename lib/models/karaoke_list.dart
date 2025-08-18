import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../repositories/karaoke_repository.dart';
import 'karaoke_singer.dart';

const _uuid = Uuid();

class KaraokeList extends StateNotifier<List<KaraokeSinger>> {
  final KaraokeRepository repository;

  KaraokeList(this.repository) : super([]) {
    _loadInitial();
  }

  Future<void> _loadInitial() async {
    state = await repository.load();
  }

  Future<void> _save() async {
    await repository.save(state);
  }

  // KaraokeList([List<KaraokeSinger>? initialSingers])
  //   : super(initialSingers ?? []);

  void clear() {
    state = [];
    repository.clear();
  }

  void add(String name) {
    final existingCount = state
        .where((s) => s.name.toLowerCase() == name.toLowerCase())
        .length;

    state = [
      ...state,
      KaraokeSinger(id: _uuid.v4(), name: name, singCounter: existingCount + 1),
    ];
    _save();
  }

  void toggeHasSung(String id) {
    final newState = [...state];
    final replaceIndex = state.indexWhere((singer) => singer.id == id);

    if (replaceIndex != -1) {
      newState[replaceIndex] = KaraokeSinger(
        id: newState[replaceIndex].id,
        name: newState[replaceIndex].name,
        singCounter: newState[replaceIndex].singCounter,
        hasSung: !newState[replaceIndex].hasSung,
      );
    }

    state = newState;
    _save();
  }

  void edit({required String id, required String name}) {
    final newState = [...state];
    final replaceIndex = state.indexWhere((singer) => singer.id == id);

    if (replaceIndex != -1) {
      newState[replaceIndex] = KaraokeSinger(
        id: newState[replaceIndex].id,
        hasSung: newState[replaceIndex].hasSung,
        singCounter: newState[replaceIndex].singCounter,
        name: name,
      );
    }

    state = newState;
    _save();
  }

  void remove(String id) {
    state = state.where((s) => s.id != id).toList();
    _save();
  }
}
