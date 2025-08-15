import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/karaoke_singer.dart';

class KaraokeRepository {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/karaoke.json');
  }

  Future<void> clear() async {
    final file = await _localFile;
    if (file.existsSync()) {
      await file.writeAsString('[]');
    }
  }

  Future<void> save(List<KaraokeSinger> singers) async {
    final file = await _localFile;
    final jsonString = jsonEncode(singers.map((s) => s.toJson()).toList());
    await file.writeAsString(jsonString);
  }

  Future<List<KaraokeSinger>> load() async {
    try {
      final file = await _localFile;
      if (!await file.exists()) return [];
      final jsonString = await file.readAsString();
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => KaraokeSinger.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }
}
