import 'package:coop/features/login/presentation/pages/login_page.dart';
import 'package:coop/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CoopApp());
}

class CoopApp extends StatelessWidget {
  const CoopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: const Color(0xFFF7F8FA), // Light background for the dashboard
        cardColor: Colors.white,
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 57, color: Color(0xFF2D3748)),
          displayMedium: TextStyle(fontSize: 45, color: Color(0xFF2D3748)),
          displaySmall: TextStyle(fontSize: 36, color: Color(0xFF2D3748)),
          headlineLarge: TextStyle(fontSize: 32, color: Color(0xFF2D3748)),
          headlineMedium: TextStyle(fontSize: 28, color: Color(0xFF2D3748)),
          headlineSmall: TextStyle(fontSize: 24, color: Color(0xFF2D3748)),
          titleLarge: TextStyle(fontSize: 22, color: Color(0xFF2D3748), fontWeight: FontWeight.bold),
          titleMedium: TextStyle(fontSize: 16, color: Color(0xFF2D3748), fontWeight: FontWeight.w600),
          titleSmall: TextStyle(fontSize: 14, color: Color(0xFF2D3748), fontWeight: FontWeight.w500),
          bodyLarge: TextStyle(fontSize: 16, color: Color(0xFF4A5568)),
          bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF4A5568)),
          bodySmall: TextStyle(fontSize: 12, color: Color(0xFF4A5568)),
          labelLarge: TextStyle(fontSize: 14, color: Color(0xFF718096)),
          labelMedium: TextStyle(fontSize: 12, color: Color(0xFFA0AEC0)),
          labelSmall: TextStyle(fontSize: 11, color: Color(0xFFCBD5E0)),
        ),
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF038920), // A shade of blue for primary actions
          secondary: const Color(0xFF8B5CF6), // A purple accent
          surface: Colors.white,
          onSurface: const Color(0xFF2D3748),
          error: Colors.redAccent,
        ),
        // Custom button themes, input decoration themes etc. would go here
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/dashboard': (context) => const DashboardScreen(),
      },
    );
  }
}


