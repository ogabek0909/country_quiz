import 'package:country_quiz/dummy_data.dart';
import 'package:country_quiz/providers/questions_provider.dart';
import 'package:country_quiz/screens/quiz_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});
  static const routeName = 'categories-screen';

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _showDialogController;
  int? _numberOfQuestions;
  List<Map<String, String>> categories = [
    {
      'question': 'Countries',
      'option': 'Capitals',
      'image': "assets/images/country.png",
    },
    {
      'question': 'Capitals',
      'option': 'Countries',
      'image': "assets/images/capital.png",
    },
    {
      'question': 'Countries',
      'option': 'Flags',
      'image': "assets/images/flag.png",
    },
    {
      'question': 'Flags',
      'option': 'Countries',
      'image': "assets/images/flags.png",
    }
  ];

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      //lowerBound: 0,
      //upperBound: 1,
    );

    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    debugPrint('_numberOfQuestions: $_numberOfQuestions');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Country Quiz'),
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: ListView.separated(
          itemCount: 4,
          separatorBuilder: (context, index) => const SizedBox(height: 15),
          itemBuilder: (context, index) => AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) => SlideTransition(
              position: Tween(
                begin: Offset(index.isOdd ? .8 : -.8, 0),
                end: const Offset(0, 0),
              ).animate(
                CurvedAnimation(
                  parent: _animationController,
                  curve: Curves.slowMiddle,
                ),
              ),
              child: child,
            ),
            child: Consumer(
              builder: (context, ref, child) => GestureDetector(
                onTap: () {
                  _showDialogController = AnimationController(
                    vsync: this,
                    duration: const Duration(milliseconds: 500),
                  );
                  _showDialogController.forward();
                  showDialog(
                    context: context,
                    builder: (context) => Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height / 6,
                      ),
                      child: AlertDialog(
                        title: const Text('Choose the number of questions'),
                        content: StatefulBuilder(
                          builder: (context, setState) => AnimatedBuilder(
                            animation: _showDialogController,
                            builder: (context, child) {
                              return SlideTransition(
                                position: Tween(
                                  begin: const Offset(0, .5),
                                  end: const Offset(0, 0),
                                ).animate(
                                  CurvedAnimation(
                                    parent: _showDialogController,
                                    curve: Curves.easeIn,
                                  ),
                                ),
                                child: child,
                              );
                            },
                            child: Column(
                              children: [
                                RadioListTile<int>(
                                  value: 10,
                                  groupValue: _numberOfQuestions,
                                  onChanged: (value) {
                                    setState(() {
                                      _numberOfQuestions = value!;
                                    });
                                  },
                                  title: const Text('10 questions'),
                                ),
                                RadioListTile<int>(
                                  value: 15,
                                  groupValue: _numberOfQuestions,
                                  onChanged: (value) {
                                    setState(() {
                                      _numberOfQuestions = value!;
                                    });
                                  },
                                  title: const Text('15 questions'),
                                ),
                                RadioListTile<int>(
                                  value: 20,
                                  groupValue: _numberOfQuestions,
                                  onChanged: (value) {
                                    setState(() {
                                      _numberOfQuestions = value!;
                                    });
                                  },
                                  title: const Text('20 questions'),
                                ),
                                RadioListTile<int>(
                                  value: 30,
                                  groupValue: _numberOfQuestions,
                                  onChanged: (value) {
                                    setState(() {
                                      _numberOfQuestions = value!;
                                    });
                                  },
                                  title: const Text('30 questions'),
                                ),
                                RadioListTile<int>(
                                  value: dummyCountries.length,
                                  groupValue: _numberOfQuestions,
                                  onChanged: (value) {
                                    setState(() {
                                      _numberOfQuestions = value!;
                                    });
                                  },
                                  title: const Text('All of them'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Back'),
                          ),
                          TextButton(
                            onPressed: () {
                              if (_numberOfQuestions == null) {
                                return;
                              }
                              ref
                                  .read(questionsListProvider.notifier)
                                  .getQuestions(
                                    _numberOfQuestions!,
                                    categories[index]['question']!,
                                    categories[index]['option']!,
                                  );
                              context.goNamed(
                                QuizScreen.routeName,
                                extra: categories[index],
                              );
                            },
                            child: const Text('Next'),
                          ),
                        ],
                      ),
                    ),
                  );
                  // context.goNamed(QuizScreen.routeName);
                },
                child: child,
              ),
              child: Container(
                margin: const EdgeInsets.only(top: 3),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.elliptical(50, 300),
                  ),
                  image: DecorationImage(
                    image: AssetImage(categories[index]['image']!),
                    fit: BoxFit.cover,
                  ),
                ),
                height: 300,
                width: double.infinity,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.elliptical(50, 300),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Colors.black26,
                        Colors.black26,
                        Colors.black26,
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Text(
                            categories[index]['question']!,
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'And',
                              style: Theme.of(context).textTheme.bodyLarge,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              categories[index]['option']!,
                              style: Theme.of(context).textTheme.bodyLarge,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
