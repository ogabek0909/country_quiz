import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/question.dart';
import '../providers/questions_provider.dart';
import '../screens/result_screen.dart';

class QuizScreen extends ConsumerStatefulWidget {
  final Map<String, String> category;
  const QuizScreen({super.key, required this.category});
  static const routeName = 'quiz-screen';

  @override
  ConsumerState<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen>
    with TickerProviderStateMixin {
  int index = 0;
  final bool optionIsTrue = false;
  late List<Question> questions;
  late List<String> options;
  late AnimationController _animationController;
  int ans = 0;

  void func(bool isTrue) async {
    await _animationController.forward();
    Future.delayed(
      const Duration(milliseconds: 300),
      () {
        if (isTrue) {
          ans++;
        }
        if (index == questions.length - 1) {
          context
              .goNamed(ResultScreen.routeName, extra: [ans, questions.length]);
          return;
        }
        setState(() {
          index++;
        });
      },
    );
  }

  @override
  void initState() {
    questions = ref.read(questionsListProvider);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    options = questions[index].options;
    options.shuffle();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quizs'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                height: 300,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(index * 0.005),
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                  // place is for image
                ),
                alignment: Alignment.center,
                child: widget.category['question'] == 'Flags'
                    ? CachedNetworkImage(
                        imageUrl: questions[index].question,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Placeholder(),
                        fadeOutDuration: const Duration(milliseconds: 500),
                        fadeInDuration: const Duration(milliseconds: 500),
                      )
                    : Text(
                        questions[index].question,
                        // widget.category['question'] == 'Countries'
                        //     ? dummyCountries[questions[index].question].country
                        //     : dummyCountries[questions[index].question].capital,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  OptionButton(
                    // option: dummyCountries[options[0]].capital,
                    animationController: _animationController,
                    optionIsTrue: questions[index].answer == options[0],
                    option: options[0],
                    optionType: widget.category['option']!,
                    func: () => func(questions[index].answer == options[0]),
                  ),
                  const SizedBox(width: 5),
                  OptionButton(
                    animationController: _animationController,
                    option: options[1],
                    optionIsTrue: questions[index].answer == options[1],
                    func: () => func(questions[index].answer == options[1]),
                    optionType: widget.category['option']!,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  OptionButton(
                    animationController: _animationController,
                    option: options[2],
                    optionIsTrue: questions[index].answer == options[2],
                    func: () => func(questions[index].answer == options[2]),
                    optionType: widget.category['option']!,
                  ),
                  const SizedBox(width: 5),
                  OptionButton(
                    animationController: _animationController,
                    option: options[3],
                    optionIsTrue: questions[index].answer == options[3],
                    func: () => func(questions[index].answer == options[3]),
                    optionType: widget.category['option']!,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OptionButton extends ConsumerWidget {
  final String option;
  final VoidCallback func;
  final String optionType;
  final bool optionIsTrue;
  final AnimationController animationController;
  OptionButton({
    super.key,
    required this.func,
    required this.optionType,
    required this.option,
    required this.optionIsTrue,
    required this.animationController,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _colorTween = ColorTween(
      begin: Colors.amber.withOpacity(.3),
      end: optionIsTrue ? Colors.green :  Colors.amber.withOpacity(.3),
    );
    return Flexible(
      child: GestureDetector(
        onTap: func,
        child: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) => ClipRRect(
             borderRadius: BorderRadius.circular(10),
            child: ColoredBox(
              color: _colorTween.animate(animationController).value!,
              child: child,
            ),
          ),
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              // color: Colors.amber.withOpacity(.3),
              border: Border.all(),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(8),
            alignment: Alignment.center,
            child: optionType == 'Flags'
                ? CachedNetworkImage(
                    imageUrl: option,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.fill,
                    placeholder: (context, url) => const Placeholder(),
                    fadeOutDuration: const Duration(milliseconds: 500),
                    fadeInDuration: const Duration(milliseconds: 500),
                  )
                : Text(
                    option,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
          ),
        ),
      ),
    );
  }
}
