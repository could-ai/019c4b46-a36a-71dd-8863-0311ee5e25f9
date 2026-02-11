import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/ide_home_screen.dart';

void main() {
  runApp(const DevinCloneApp());
}

class DevinCloneApp extends StatelessWidget {
  const DevinCloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Developer Workspace',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFF5E81AC),
          secondary: const Color(0xFF88C0D0),
          surface: const Color(0xFF2E3440),
          background: const Color(0xFF242933),
          onSurface: const Color(0xFFD8DEE9),
        ),
        scaffoldBackgroundColor: const Color(0xFF242933),
        textTheme: GoogleFonts.jetbrainsMonoTextTheme(
          ThemeData.dark().textTheme,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const IdeHomeScreen(),
      },
    );
  }
}
