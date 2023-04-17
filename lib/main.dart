import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_quiz/screens/categories_screen.dart';
import 'package:country_quiz/screens/quiz_screen.dart';
import 'package:country_quiz/screens/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  CachedNetworkImage.logLevel = CacheManagerLogLevel.debug;
  runApp(


    ProviderScope(child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          bodyLarge: GoogleFonts.ubuntuCondensed(
            fontSize: 40,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
          bodyMedium: GoogleFonts.anekOdia(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          displaySmall: GoogleFonts.comingSoon(
            color: const Color.fromARGB(255, 172, 54, 54),
            fontWeight: FontWeight.bold,
          ),
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 153, 174, 175),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 138, 143, 113),
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      routerConfig: GoRouter(
        // initialLocation: '/result',
        routes: [
          GoRoute(
            path: '/',
            name: CategoriesScreen.routeName,
            builder: (context, state) => const CategoriesScreen(),
            routes: [
              GoRoute(
                path: 'quiz',
                name: QuizScreen.routeName,
                builder: (context, state) => QuizScreen(
                  category: state.extra as Map<String, String>,
                ),
              ),
              GoRoute(
                path: 'result',
                name: ResultScreen.routeName,
                builder: (context, state) => ResultScreen(
                  rightAnswers: (state.extra as List<int>)[0],
                  numberOfQuestions: (state.extra as List<int>)[1],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
