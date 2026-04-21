import 'package:flutter_riverpod/legacy.dart';

final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void add() {
    state++;
  }

  void remove() {
    if (state > 0) {
      state--;
    }
  }

  void reset() {
    state = 0;
  }
}