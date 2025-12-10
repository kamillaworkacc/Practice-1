import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'welcome': 'Welcome',
      'login': 'Login',
      'email': 'Email',
      'password': 'Password',
      'news': 'News',
      'animations': 'Animations',
      'map': 'Map',
      'qr': 'QR Code',
      'logout': 'Logout',
    },
    'kk': {
      'welcome': 'Қош келдіңіз',
      'login': 'Кіру',
      'email': 'Электрондық пошта',
      'password': 'Құпия сөз',
      'news': 'Жаңалықтар',
      'animations': 'Анимациялар',
      'map': 'Карта',
      'qr': 'QR Код',
      'logout': 'Шығу',
    },
    'ru': {
      'welcome': 'Добро пожаловать',
      'login': 'Войти',
      'email': 'Электронная почта',
      'password': 'Пароль',
      'news': 'Новости',
      'animations': 'Анимации',
      'map': 'Карта',
      'qr': 'QR Код',
      'logout': 'Выйти',
    },
  };

  String get welcome {
    return _localizedValues[locale.languageCode]?['welcome'] ?? 'Welcome';
  }

  String get login {
    return _localizedValues[locale.languageCode]?['login'] ?? 'Login';
  }

  String get email {
    return _localizedValues[locale.languageCode]?['email'] ?? 'Email';
  }

  String get password {
    return _localizedValues[locale.languageCode]?['password'] ?? 'Password';
  }

  String get news {
    return _localizedValues[locale.languageCode]?['news'] ?? 'News';
  }

  String get animations {
    return _localizedValues[locale.languageCode]?['animations'] ?? 'Animations';
  }

  String get map {
    return _localizedValues[locale.languageCode]?['map'] ?? 'Map';
  }

  String get qr {
    return _localizedValues[locale.languageCode]?['qr'] ?? 'QR Code';
  }

  String get logout {
    return _localizedValues[locale.languageCode]?['logout'] ?? 'Logout';
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'kk', 'ru'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

