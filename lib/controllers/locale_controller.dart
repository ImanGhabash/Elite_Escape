import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider للغة
final localeProvider = StateProvider<Locale>((ref) => const Locale('en'));

class LocaleController {
  final Ref ref;
  LocaleController(this.ref);

  void changeLocale(String languageCode) {
    ref.read(localeProvider.notifier).state = Locale(languageCode);
  }
}