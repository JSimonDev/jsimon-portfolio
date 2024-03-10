import 'dart:ui';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'locale_provider.g.dart';

@riverpod
class MyLocale extends _$MyLocale {
  @override
  Locale build() {
    return const Locale('en');
  }

  void changeLocale(Locale locale) {
    state = locale;
  }
}
