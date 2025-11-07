# LabWork8

A combined Flutter application that integrates Lab 7 and Lab 8 functionality.

## Features

1. **Language Selection Screen**: 
   - Introductory screen with RU (Russian) and KAZ (Kazakh) language options
   - Uses EasyLocalization for internationalization

2. **Registration Form** (from Lab 7):
   - Full name input with validation
   - Phone number input with formatting
   - Email address input with validation
   - Life story text area
   - Password and confirm password fields with visibility toggles
   - Form validation and submission

3. **User Information Page**:
   - Displays submitted registration information
   - Success message display
   - Navigation back to registration form

## Project Structure

```
lib/
├── main.dart              # App entry point with EasyLocalization setup
├── home.dart              # Language selection screen (RU/KAZ)
├── registration.dart      # Registration form page
├── user_info.dart         # User information display page
├── constants/
│   ├── colors.dart        # App color constants
│   └── text_styles_value.dart  # Text style constants
└── generated/
    └── locale_keys.g.dart # Generated locale keys

assets/
└── translations/
    ├── en.json           # English translations
    ├── ru.json           # Russian translations
    └── kk.json           # Kazakh translations
```

## Getting Started

1. Install dependencies:
   ```bash
   flutter pub get
   ```

2. Run the app:
   ```bash
   flutter run
   ```

## Dependencies

- `easy_localization: ^3.0.7` - For internationalization support
- `flutter` - Flutter SDK
- `cupertino_icons: ^1.0.8` - iOS style icons

## How It Works

1. The app starts with the language selection screen (home.dart)
2. User selects either RU or KAZ language
3. After language selection, the app navigates to the registration form
4. User fills out the registration form
5. Upon successful submission, user information is displayed
6. User can navigate back to the registration form

## Notes

- The language selection screen uses EasyLocalization to set the app locale
- The registration form includes comprehensive validation
- All form fields have proper focus management and keyboard navigation support
