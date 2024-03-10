import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:jsimon/config/router/app_router.dart';
import 'package:jsimon/config/theme/app_theme.dart';

import 'config/utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final isDarkMode =
      await KeyValueStorageServiceImpl().getValue<bool>('isDarkMode');

  runApp(
    ProviderScope(
      child: MyApp(
        isDarkMode: isDarkMode,
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  final bool? isDarkMode;

  const MyApp({
    super.key,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.read(appRouterProvider);

    final bool systemMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    final initTheme = AppTheme(
      selectedColor: "Morado Oscuro",
      isDarkMode: isDarkMode ?? systemMode,
    ).getTheme();

    return ThemeProvider(
      initTheme: initTheme,
      builder: (context, theme) {
        return MaterialApp.router(
          title: 'JSimon Portfolio',
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
