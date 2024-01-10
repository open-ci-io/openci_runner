import 'package:flutter_riverpod/flutter_riverpod.dart';

T getPreviousValue<T>(AsyncValue<T>? state) {
  if (state == null) {
    throw Exception('State is Null.');
  }
  final previousValue = state.valueOrNull;
  if (previousValue == null) {
    throw Exception('PreviousValue is Null.');
  }
  return previousValue;
}
