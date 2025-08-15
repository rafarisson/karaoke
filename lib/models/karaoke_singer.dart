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
}
