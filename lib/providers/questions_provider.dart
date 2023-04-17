import 'dart:math';

import 'package:country_quiz/dummy_data.dart';
import 'package:country_quiz/models/question.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final questionsListProvider =
    StateNotifierProvider<QuestionsList, List<Question>>(
        (ref) => QuestionsList());

class QuestionsList extends StateNotifier<List<Question>> {
  QuestionsList() : super([]);
  void getQuestions(int l, String questionType, String optionType){
    List<int> questionIndexes = [];
    for(int i = 0; i < l; i++){
      int index = Random().nextInt(dummyCountries.length);
      while(questionIndexes.contains(index)){
        index = Random().nextInt(dummyCountries.length);
      }
      questionIndexes.add(index);
    }
    List<Question> questions = [];
    for(int i in questionIndexes){
      questions.add(Question.getQuestions(i,questionType,optionType));
    }
    state = [...questions];
    print('object');
  }
}
