import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/repository.dart';

final singerRepositoryProvider = Provider((_) => SingerRepository());
