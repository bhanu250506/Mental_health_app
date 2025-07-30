import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_chat/dummyScreen.dart';
import 'package:health_chat/providers/auth_provider.dart';
import 'package:health_chat/providers/theme_provider.dart';
import 'package:health_chat/screens/auth/welcome_screen.dart';
import 'package:health_chat/screens/home/home_screen.dart';
import 'package:health_chat/theme/app_theme.dart';

void main() {
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
    final authState = ref.watch(authProvider);
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      title: 'Aura - Mental Health Assistant',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      home: authState.token != null ? const HomeScreen() : const WelcomeScreen(),
    );
  }
}