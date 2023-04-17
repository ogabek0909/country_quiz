import 'dart:math';

import 'package:country_quiz/dummy_data.dart';

class Question {
  final String question;
  final String answer;
  final List<String> options;

  Question({
    required this.question,
    required this.answer,
    required this.options,
  });

  factory Question.getQuestions(
      int questionIndex, String questionType, String optionType) {
    String answer = '';
    List<String> _options = [];
    if (optionType == 'Countries') {
      _options.add(dummyCountries[questionIndex].country);
      answer = dummyCountries[questionIndex].country;
    } else if (optionType == 'Capitals') {
      _options.add(dummyCountries[questionIndex].capital);
      answer = dummyCountries[questionIndex].capital;
    } else {
      _options.add(dummyCountries[questionIndex].flagUrl);
      answer = dummyCountries[questionIndex].flagUrl;
    }
    for (int i = 0; i < 3; i++) {
      if (optionType == 'Countries') {
        int index = Random().nextInt(dummyCountries.length);
        while (_options.contains(dummyCountries[index].country)) {
          index = Random().nextInt(dummyCountries.length);
        }
        _options.add(dummyCountries[index].country);
      } else if (optionType == 'Capitals') {
        int index = Random().nextInt(dummyCountries.length);
        while (_options.contains(dummyCountries[index].capital)) {
          index = Random().nextInt(dummyCountries.length);
        }
        _options.add(dummyCountries[index].capital);
      } else {
        int index = Random().nextInt(dummyCountries.length);
        while (_options.contains(dummyCountries[index].flagUrl)) {
          index = Random().nextInt(dummyCountries.length);
        }
        _options.add(dummyCountries[index].flagUrl);
      }
    }
    String question = '';
    if (questionType == 'Countries') {
      question = dummyCountries[questionIndex].country;
    } else if (questionType == 'Capitals') {
      question = dummyCountries[questionIndex].capital;
    } else {
      question = dummyCountries[questionIndex].flagUrl;
    }
    return Question(
      question: question,
      options: _options,
      answer: answer,
    );
  }
}
