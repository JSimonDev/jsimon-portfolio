import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jsimon/config/router/app_router.dart';
import 'package:jsimon/config/theme/app_theme.dart';
import 'package:jsimon/config/utils/utils.dart';
import 'package:jsimon/l10n/app_localizations.dart';
import 'package:jsimon/presentation/providers/locale_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final isDarkMode =
      await KeyValueStorageServiceImpl().getValue<bool>('isDarkMode');

  final language =
      await KeyValueStorageServiceImpl().getValue<String>('language');

  runApp(
    ProviderScope(
      child: MyPortfolio(
        isDarkMode: isDarkMode,
        language: language,
      ),
    ),
  );
}

class MyPortfolio extends ConsumerStatefulWidget {
  final bool? isDarkMode;
  final String? language;

  const MyPortfolio({
    super.key,
    required this.isDarkMode,
    required this.language,
  });

  @override
  ConsumerState<MyPortfolio> createState() => _MyPortfolioState();
}

class _MyPortfolioState extends ConsumerState<MyPortfolio> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final localeNotifier = ref.read(myLocaleProvider.notifier);

      if (widget.language == null) return;
      localeNotifier.changeLocale(Locale(widget.language!));
    });
  }

  @override
  Widget build(BuildContext context) {
    final appRouter = ref.read(appRouterProvider);
    final Locale locale = ref.watch(myLocaleProvider);
    final bool systemMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final initTheme = AppTheme(
      isDarkMode: widget.isDarkMode ?? systemMode,
    ).getTheme();

    return ThemeProvider(
      initTheme: initTheme,
      builder: (context, theme) {
        return MaterialApp.router(
          title: 'JSimon Portfolio',
          locale: locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          debugShowCheckedModeBanner: false,
          routerConfig: appRouter,
          theme: theme,
        );
      },
    );
  }
}
