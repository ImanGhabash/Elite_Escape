import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/controllers/locale_controller.dart';
import 'package:task/controllers/theme_controller.dart';
import 'package:task/generated/l10n.dart';
import 'package:task/main.dart';
import 'package:task/view/welcome/welcome_screen.dart';

class HomeDrawer extends ConsumerWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    final themeMode = ref.watch(themeProvider);
    final isDark = themeMode == ThemeMode.dark;

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: Text(
                S.of(context).settings,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          ExpansionTile(
            leading: const Icon(Icons.language, color: Color(0xFF5A9C92)),
            title: Text(S.of(context).change_language),
            children: [
              RadioListTile<String>(
                title: const Text('العربية'),
                value: 'ar',
                groupValue: locale.languageCode,
                onChanged: (_) {
                  ref.read(localeProvider.notifier).state =
                      const Locale('ar');
                  Navigator.pop(context);
                },
              ),
              RadioListTile<String>(
                title: const Text('English'),
                value: 'en',
                groupValue: locale.languageCode,
                onChanged: (_) {
                  ref.read(localeProvider.notifier).state =
                      const Locale('en');
                  Navigator.pop(context);
                },
              ),
            ],
          ),

          SwitchListTile(
            secondary: const Icon(Icons.nightlight_round),
            title: Text(S.of(context).night_mode),
            value: isDark,
            onChanged: (value) {
              ref.read(themeProvider.notifier).state =
                  value ? ThemeMode.dark : ThemeMode.light;
            },
            activeColor: Color(0xFF5A9C92),        
              activeTrackColor: Colors.blueGrey, 
              inactiveThumbColor: Colors.grey,        
              inactiveTrackColor: Colors.grey[300],    //
          ),

          const Divider(),

        ListTile(
  leading: const Icon(Icons.logout),
  title: Text(S.of(context).Logout),
  onTap: () async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');

    ref.read(tokenProvider.notifier).state = null;

    if (!context.mounted) return;

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const WelcomeScreen()),
      (route) => false,
    );
  },
),


          ListTile(
            leading: const Icon(Icons.person_add),
            title: Text(S.of(context).signup),
            onTap: () => Navigator.pushNamed(context, '/register'),
          ),
        ],
      ),
    );
  }
}
