# JSimon Flutter Portfolio

Comando para generar el build web en la rama gh-pages:
```dart run peanut:peanut --web-renderer canvaskit```

Comando para generar el build de la aplicacion movil version release e instalarla en un dispositivo conectado:
```flutter build apk --release && flutter install --release```

Comando para generar el build de la aplicacion web version debug:
```flutter run -d chrome --web-renderer canvaskit```

Para generar los iconos de la aplicacion:
```dart run flutter_launcher_icons```

Para generar los splash de la aplicacion:
```dart run flutter_native_splash:create```

Para cambiar el nombre del bundle de la app:
```flutter pub run change_app_package_name:main com.new.package.name```

Para generar los archivos de traduccion:
```flutter gen-l10n```

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
