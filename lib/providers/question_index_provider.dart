import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../screens/result_screen.dart';

final questionIndexPorvider = StateNotifierProvider<QuestionIndex, int>((ref) {
  return QuestionIndex();
});

class QuestionIndex extends StateNotifier<int> {
  QuestionIndex() : super(0);
  void increment(int index) {
    state = index;
    
  }
}
