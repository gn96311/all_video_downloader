import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ProgressState { downloading, paused, waiting, completed }

class ProgressStateNotifier extends StateNotifier<ProgressState>{
  ProgressStateNotifier() : super(ProgressState.waiting);
}

final progressStateProvider = StateNotifierProvider<ProgressStateNotifier, ProgressState>((ref) {
  return ProgressStateNotifier();
});

extension ProgressStateEx on ProgressState{
  String get toName{
    switch (this) {
      case ProgressState.downloading:
        return 'Downloading';
      case ProgressState.paused:
        return 'Paused';
      case ProgressState.waiting:
        return 'Waiting';
      case ProgressState.completed:
        return 'Completed';
    }
  }
}