// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:news/screens/DetailedNews.dart';
import 'package:news/screens/splash.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/login.dart';
import 'screens/news.dart';
import 'screens/register.dart';
import 'providers/auth_provider.dart';
import 'providers/news_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => NewsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFF5F9FD)),
            scaffoldBackgroundColor: const Color(0xFFF5F9FD)
        ),
        title: 'Flutter News App',
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashStartScreen(),
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/news': (context) => const NewsScreen(),
          '/news/details': (context) => const DetailedNews(),
        },
      ),
    );
  }
}


