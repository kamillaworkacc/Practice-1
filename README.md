# Pixel Space - Flutter Final Project

A cute space-themed mobile application built with Flutter/Dart for the Mobile Application Development course.

## Features

- ✅ **Authentication** using BLOC pattern and TextController
- ✅ **News Page** with animations using BLOC (fetches from jsonplaceholder.typicode.com/posts)
- ✅ **Post Detail Page** with animations using BLOC (fetches from jsonplaceholder.typicode.com/posts/1)
- ✅ **Animation Page** with various animation techniques
- ✅ **Firebase** integration (Firebase Core & Auth)
- ✅ **Retrofit** for API calls
- ✅ **Google Maps** integration
- ✅ **QR Code** generation and scanning support
- ✅ **SharedPreferences** for local storage
- ✅ **Localization** support (English, Kazakh, Russian)
- ✅ **Cute Space/Pixel Theme** throughout the app

## Project Structure

```
lib/
├── bloc/
│   ├── auth/          # Authentication BLOC
│   ├── news/          # News BLOC
│   └── post/          # Post Detail BLOC
├── models/            # Data models
├── pages/             # UI pages
│   ├── login_page.dart
│   ├── home_page.dart
│   ├── news_page.dart
│   ├── post_detail_page.dart
│   ├── animation_page.dart
│   ├── map_page.dart
│   └── qr_page.dart
├── services/          # API and storage services
├── theme/             # App theme
└── l10n/              # Localization
```

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Android Studio or VS Code
- Firebase project (optional, for full Firebase features)

### Installation

1. Clone or download this project
2. Navigate to the project directory:
   ```bash
   cd final_project
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Generate required files:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

5. Run the app:
   ```bash
   flutter run
   ```

## Usage

1. **Login**: Enter any email and password to login (demo authentication)
2. **News**: Browse posts from the API with smooth animations
3. **Post Details**: Tap on any news item to see detailed view with animations
4. **Animations**: Explore various animation techniques on the Animation page
5. **Map**: View space-themed locations on Google Maps
6. **QR Code**: Generate and scan QR codes

## Technologies Used

- **Flutter** - UI Framework
- **BLOC** - State Management
- **Firebase** - Backend Services
- **Retrofit** - HTTP Client
- **Dio** - HTTP Client
- **Google Maps** - Maps Integration
- **QR Flutter** - QR Code Generation
- **SharedPreferences** - Local Storage
- **Intl** - Internationalization

## Theme

The app features a cute space/pixel theme with:
- Purple and pink color scheme
- Space-themed icons and animations
- Smooth transitions and animations
- Modern Material Design 3

## API

The app uses the JSONPlaceholder API:
- Posts: `https://jsonplaceholder.typicode.com/posts`
- Single Post: `https://jsonplaceholder.typicode.com/posts/{id}`

## License

This project is created for educational purposes as part of the Mobile Application Development course.

## Author

Final Examination Project - Mobile Application Development using Flutter/Dart
