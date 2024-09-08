import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum BottomNav { home, progress, finish }

class BottomNavNotifier extends StateNotifier<BottomNav> {
  BottomNavNotifier() : super(BottomNav.home);

  void changeNavIndex(int index) {
    state = BottomNav.values[index];
  }
}

final bottomNavProvider = StateNotifierProvider<BottomNavNotifier, BottomNav>((ref) {
  return BottomNavNotifier();
});

extension BottomNavEx on BottomNav {
  Icon get icon {
    switch (this) {
      case BottomNav.home:
        return Icon(Icons.web, size: 25,);
      case BottomNav.progress:
        return Icon(Icons.list, size: 25,);
      case BottomNav.finish:
        return Icon(Icons.check_circle, size: 25,);
    }
  }

  String get toNmae{
    switch (this) {
      case BottomNav.home:
        return '홈';
      case BottomNav.progress:
        return '진행중';
      case BottomNav.finish:
        return '완료';
    }
  }
}