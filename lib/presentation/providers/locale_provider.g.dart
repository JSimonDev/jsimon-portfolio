// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locale_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MyLocale)
const myLocaleProvider = MyLocaleProvider._();

final class MyLocaleProvider extends $NotifierProvider<MyLocale, Locale> {
  const MyLocaleProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'myLocaleProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$myLocaleHash();

  @$internal
  @override
  MyLocale create() => MyLocale();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Locale value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Locale>(value),
    );
  }
}

String _$myLocaleHash() => r'0efa377a9317d8ebd9408507184a72aa0ff456aa';

abstract class _$MyLocale extends $Notifier<Locale> {
  Locale build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Locale, Locale>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<Locale, Locale>, Locale, Object?, Object?>;
    element.handleValue(ref, created);
  }
}
