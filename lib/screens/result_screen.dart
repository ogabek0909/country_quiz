import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  final int rightAnswers;
  final int numberOfQuestions;
  const ResultScreen({
    super.key,
    required this.rightAnswers,
    required this.numberOfQuestions,
  });
  static const routeName = 'result-screen';

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final ConfettiController _confettiController = ConfettiController();
  String congratulations = 'You did not find any answers to the questions!';
  @override
  void initState() {
    _confettiController.play();
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        _confettiController.stop();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.rightAnswers == widget.numberOfQuestions){

      congratulations = 'Congratulations \nyou found all of ${widget.numberOfQuestions} questions!';
    }else if(widget.rightAnswers != 0){
      congratulations = 'Congratulations \nyou found ${widget.rightAnswers} of ${widget.numberOfQuestions} questions!';

    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        congratulations,
                        style: Theme.of(context).textTheme.displaySmall,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 300,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/pngegg.png',
                    fit: BoxFit.cover,
                    height: 300,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK, Back To Home Screen'),
                )
              ],
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 200,
                margin: const EdgeInsets.symmetric(vertical: 150),
                width: double.infinity,
                alignment: Alignment.center,
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  // maximumSize: const Size(30, 30),
                  shouldLoop: false,
                  blastDirection: pi,
                  blastDirectionality: BlastDirectionality.explosive,
                  maxBlastForce: 70, // set a lower max blast force
                  minBlastForce: 20, // set a lower min blast force
                  emissionFrequency: 1,
                  numberOfParticles: 40, // a lot of particles at once
                  gravity: .6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
