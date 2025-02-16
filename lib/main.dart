import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:note_taking_app/screens/quote_page.dart';
import 'package:note_taking_app/providers/nav_provider.dart';
import 'package:note_taking_app/services/database_helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // resetDatabaseInDebug();
  runApp(const ProviderScope(child: MyApp()));
}

void resetDatabaseInDebug() async {
  if (!kReleaseMode) {
    // Cek jika bukan mode release
    await DatabaseHelper().deleteDatabaseFile();
    log("Database reset in debug mode!");
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Note Taking App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
        ),
      ),
      // home: QuotePage(),
      routerConfig: router,
    );
  }
}
