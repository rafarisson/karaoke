import 'package:uuid/uuid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/singer.dart';

const _uuid = Uuid();

class SingerList extends StateNotifier<List<Singer>> {
  SingerList() : super([]);

  void clear() {
    state = [];
    // repository.clear();
  }

  void add(String name) {
    final existingCount = state
        .where((s) => s.name.toLowerCase() == name.toLowerCase())
        .length;

    state = [
      ...state,
      Singer(id: _uuid.v4(), name: name, singCounter: existingCount + 1),
    ];
    // _save();
  }

  void toggeHasSung(String id) {
    final newState = [...state];
    final replaceIndex = state.indexWhere((singer) => singer.id == id);

    if (replaceIndex != -1) {
      newState[replaceIndex] = Singer(
        id: newState[replaceIndex].id,
        name: newState[replaceIndex].name,
        singCounter: newState[replaceIndex].singCounter,
        hasSung: !newState[replaceIndex].hasSung,
      );
    }

    state = newState;
    // _save();
  }

  void edit({required String id, required String name}) {
    final newState = [...state];
    final replaceIndex = state.indexWhere((singer) => singer.id == id);

    if (replaceIndex != -1) {
      newState[replaceIndex] = Singer(
        id: newState[replaceIndex].id,
        hasSung: newState[replaceIndex].hasSung,
        singCounter: newState[replaceIndex].singCounter,
        name: name,
      );
    }

    state = newState;
    // _save();
  }

  void remove(String id) {
    state = state.where((s) => s.id != id).toList();
    // _save();
  }
}
