import 'package:animations/animations.dart';
import 'package:coop/features/login/presentation/pages/login_page.dart';
import 'package:coop/presentation/components/side_menu.dart';
import 'package:coop/presentation/pages/bills_page.dart';
import 'package:coop/presentation/pages/goals_page.dart';
import 'package:coop/presentation/pages/home_page.dart';
import 'package:coop/presentation/pages/settings_page.dart';
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
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor:
            const Color(0xFFF7F8FA),
        cardColor: Colors.white,
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 57, color: Color(0xFF2D3748)),
          displayMedium: TextStyle(fontSize: 45, color: Color(0xFF2D3748)),
          displaySmall: TextStyle(fontSize: 36, color: Color(0xFF2D3748)),
          headlineLarge: TextStyle(fontSize: 32, color: Color(0xFF2D3748)),
          headlineMedium: TextStyle(fontSize: 28, color: Color(0xFF2D3748)),
          headlineSmall: TextStyle(fontSize: 24, color: Color(0xFF2D3748)),
          titleLarge: TextStyle(
              fontSize: 22,
              color: Color(0xFF2D3748),
              fontWeight: FontWeight.bold),
          titleMedium: TextStyle(
              fontSize: 16,
              color: Color(0xFF2D3748),
              fontWeight: FontWeight.w600),
          titleSmall: TextStyle(
              fontSize: 14,
              color: Color(0xFF2D3748),
              fontWeight: FontWeight.w500),
          bodyLarge: TextStyle(fontSize: 16, color: Color(0xFF4A5568)),
          bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF4A5568)),
          bodySmall: TextStyle(fontSize: 12, color: Color(0xFF4A5568)),
          labelLarge: TextStyle(fontSize: 14, color: Color(0xFF718096)),
          labelMedium: TextStyle(fontSize: 12, color: Color(0xFFA0AEC0)),
          labelSmall: TextStyle(fontSize: 11, color: Color(0xFFCBD5E0)),
        ),
        colorScheme: ColorScheme.light(
          primary:
              const Color(0xff008080), // A shade of blue for primary actions
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
        '/dashboard': (context) => const MainLayout(),
      },
    );
  }
}

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int selectedIndex = 0;

  final List<String> pageTitles = [
    "Dashboard",
    "Goals",
    "Bills",
    "Settings",
  ];

  final List<Widget> pages = const [
    DashboardScreen(),
    GoalsPage(),
    BillsPage(),
    SettingsPage(),
  ];

  void onMenuItemSelected(int index) {
    setState(() => selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= 900) {
              // ✅ Desktop layout
              return Row(
                children: [
                  SizedBox(
                    width: 280,
                    child: SideMenu(
                      currentIndex: selectedIndex,
                      onPageSelected: onMenuItemSelected,
                    ),
                  ),
                  Expanded(
                    child: PageTransitionSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (
                        Widget child,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation,
                      ) {
                        return SharedAxisTransition(
                          animation: animation,
                          secondaryAnimation: secondaryAnimation,
                          transitionType: SharedAxisTransitionType.horizontal,
                          child: child,
                        );
                      },
                      child: pages[selectedIndex],
                    ),
                  )
                ],
              );
            } else {
              return IndexedStack(
                index: selectedIndex,
                children: pages,
              );
            }
          },
        ),
      ),
    );
  }
}
