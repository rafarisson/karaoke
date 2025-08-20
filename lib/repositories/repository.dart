import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';
import '../models/singer.dart';

class SingerRepository {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/karaoke.json');
  }

  Future<void> clear() async {
    if (kIsWeb) return;
    final file = await _localFile;
    if (file.existsSync()) {
      await file.writeAsString('[]');
    }
  }

  Future<void> save(List<Singer> singers) async {
    if (kIsWeb) return;
    final file = await _localFile;
    final jsonString = jsonEncode(singers.map((s) => s.toJson()).toList());
    await file.writeAsString(jsonString);
  }

  Future<List<Singer>> load() async {
    if (kIsWeb) return [];
    try {
      final file = await _localFile;
      if (!await file.exists()) return [];
      final jsonString = await file.readAsString();
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => Singer.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }
}
