import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const deepBlue = Color(0xFF000080);
    const saffron = Color(0xFFFF9933);
    const lightGrey = Color(0xFFF5F5F5);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stride AI',
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: deepBlue,
          onPrimary: Colors.white,
          secondary: saffron,
          onSecondary: Colors.black87,
          error: Colors.red[700]!,
          onError: Colors.white,
          background: lightGrey,
          onBackground: Colors.black87,
          surface: Colors.white,
          onSurface: Colors.black87,
          primaryContainer: const Color(0xFFE6E6FF),
          secondaryContainer: const Color(0xFFFFF3E0),
          surfaceVariant: Colors.grey[100]!,
          outline: Colors.grey[300]!,
        ),
        scaffoldBackgroundColor: lightGrey,
        useMaterial3: true,
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ).apply(
          bodyColor: Colors.black87,
          displayColor: Colors.black87,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 2,
          shadowColor: deepBlue.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          foregroundColor: deepBlue,
          iconTheme: IconThemeData(color: deepBlue),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: deepBlue,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: deepBlue,
            side: const BorderSide(color: deepBlue, width: 1.5),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: saffron,
            foregroundColor: Colors.black87,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: lightGrey,
          selectedColor: saffron.withOpacity(0.2),
          labelStyle: const TextStyle(color: Colors.black87),
          side: BorderSide(color: Colors.grey[300]!),
        ),
        iconTheme: const IconThemeData(
          color: deepBlue,
          size: 24,
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: saffron,
          linearTrackColor: Color(0xFFE6E6FF),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: saffron,
          foregroundColor: Colors.black87,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: deepBlue, width: 2),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
