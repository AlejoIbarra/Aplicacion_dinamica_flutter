import 'package:flutter/material.dart';
import 'package:app_dinamica/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:app_dinamica/services/favorites_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoritesProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color.fromARGB(255, 0, 252, 38),
        brightness: Brightness.dark,
      ),
      home: SplashScreen(),
    );
  }
}
