import 'package:flutter/foundation.dart' show immutable;

@immutable
class KaraokeSinger {
  final String id;
  final String name;
  final int singCounter;
  final bool hasSung;

  const KaraokeSinger({
    required this.id,
    required this.name,
    this.singCounter = 1,
    this.hasSung = false,
  });

  factory KaraokeSinger.fromJson(Map<String, dynamic> json) {
    return KaraokeSinger(
      id: json['id'],
      name: json['name'],
      singCounter: json['singCounter'] ?? 1,
      hasSung: json['hasSung'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'singCounter': singCounter,
    'hasSung': hasSung,
  };
}
