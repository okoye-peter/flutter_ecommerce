import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void updatePageIndicator(int index) => state = index;
}

final homeControllerProvider = NotifierProvider<HomeNotifier, int>(
  HomeNotifier.new,
);
