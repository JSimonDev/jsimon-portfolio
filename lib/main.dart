import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jsimon/config/router/app_router.dart';
import 'package:jsimon/config/theme/app_theme.dart';

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
    final appRouter = ref.read(appRouterProvider);
    final initTheme =
        AppTheme(selectedColor: "Morado Oscuro", isDarkMode: true).getTheme();

    return ThemeProvider(
      initTheme: initTheme,
      builder: (context, theme) {
        return MaterialApp.router(
          title: 'JSimon',
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            scrollbars: false,
          ),
          debugShowCheckedModeBanner: false,
          routerConfig: appRouter,
          theme: theme,
        );
      },
    );
  }
}
