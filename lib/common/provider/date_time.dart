import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'date_time.g.dart';

@riverpod
DateTime nowDateTime(NowDateTimeRef ref) => DateTime.now();
