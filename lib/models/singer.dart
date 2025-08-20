import 'package:flutter/foundation.dart' show immutable;

@immutable
class Singer {
  final String id;
  final String name;
  final int singCounter;
  final bool hasSung;

  const Singer({
    required this.id,
    required this.name,
    this.singCounter = 1,
    this.hasSung = false,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'singCounter': singCounter,
    'hasSung': hasSung,
  };

  factory Singer.fromJson(Map<String, dynamic> json) {
    return Singer(
      id: json['id'],
      name: json['name'],
      singCounter: json['singCounter'] ?? 1,
      hasSung: json['hasSung'] ?? false,
    );
  }
}
