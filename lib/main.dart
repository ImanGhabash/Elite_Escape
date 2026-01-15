import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/controllers/locale_controller.dart';
import 'package:task/controllers/theme_controller.dart';
import 'package:task/generated/l10n.dart';
import 'package:task/models/token_storage.dart';
import 'package:task/services/dio_service.dart';
import 'package:task/view/Home/home_screen.dart';
import 'package:task/view/cart_screen.dart';
import 'package:task/view/favourite.dart';
import 'package:task/view/signup/signup_screen.dart';
import 'package:task/view/welcome/auth_gate.dart';
// import 'view/welcome/welcome_screen.dart';

import 'package:flutter_localizations/flutter_localizations.dart';


Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initAuth();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
        routes: {
    '/register': (_) => const SignUpScreen(),
    '/home': (_) => const BottomNavBar(),

  },
  debugShowCheckedModeBanner: false,
      locale: locale,
      themeMode: themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
home: const AuthGate(),
    );
  }
}


final tokenProvider = StateProvider<String?>((ref) => null);

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}
Future<void> initAuth() async {
  final token = await TokenStorage().getToken();
  if (token != null) {
    DioService().setToken(token);
  }
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens()[currentIndex],

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            currentIndex = 2;
          });
        },
        backgroundColor: const Color(0xff5A9C92),
        shape: const CircleBorder(),
        child: const Icon(Icons.home, color: Colors.white, size: 32),
      ),

      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        height: 60,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _navIcon(0, Icons.grid_view_outlined),
            _navIcon(1, Icons.favorite_border),
            const SizedBox(width: 40),
            _navIcon(3, Icons.shopping_cart_outlined),
            _navIcon(4, Icons.person),
          ],
        ),
      ),
    );
  }

  // ================= ICON =================
  Widget _navIcon(int index, IconData icon) {
    return IconButton(
      onPressed: () {
        setState(() {
          currentIndex = index;
        });
      },
      icon: Icon(
        icon,
        size: 28,
        color: currentIndex == index
            ? const Color(0xff5A9C92)
            : Colors.grey,
      ),
    );
  }

  // ================= SCREENS =================
  List<Widget> _screens() {
    return [
      const Scaffold(),
      const FavoritesScreen(),
      const HomeScreen(),
      CartScreen(),

      // PROFILE WITH TOKEN
    
      
    ];
  }
}
