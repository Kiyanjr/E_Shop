import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/features/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shop/provider/cart_provider.dart'; // For Persian locale

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TechLand',
      debugShowCheckedModeBanner: false, // Remove debug banner
      theme: ThemeData(
        // Modern and bright theme colors
        primaryColor: const Color(0xFFE0F7FA), // Light cyan
        scaffoldBackgroundColor: Colors.white, // White background for the whole app
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF37474F), // Dark grey text color for AppBar
          elevation: 0, // No shadow
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        // Updated text theme for better readability and modern look
        textTheme: const TextTheme(
          headlineSmall: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF37474F), fontSize: 22),
          titleLarge: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF37474F), fontSize: 20),
          titleMedium: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF37474F), fontSize: 16),
          bodyLarge: TextStyle(color: Color(0xFF37474F), fontSize: 15),
          bodyMedium: TextStyle(color: Color(0xFF37474F), fontSize: 14, height: 1.5),
          bodySmall: TextStyle(color: Colors.grey, fontSize: 12),
        ),
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF00ACC1), // Teal as the primary accent color
          secondary: const Color(0xFF00ACC1), // Secondary accent, can be same as primary
          surface: Colors.white, // For cards and surfaces
          onPrimary: Colors.white, // Text on primary color buttons
          onSecondary: Colors.white,
          onSurface: const Color(0xFF37474F), // Text on white surfaces
          outline: Colors.grey[300], // For borders if needed
        ),
        // Define ElevatedButton theme for consistency
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00ACC1), // Teal background
            foregroundColor: Colors.white, // White text
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
          ),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            foregroundColor: const Color(0xFF37474F), // Default icon color
          ),
        ),
      ),
      home: const SplashScreen(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'), // English locale
      ],
      locale: const Locale('en', 'US'), // Set default locale to English
    );
  }
}
