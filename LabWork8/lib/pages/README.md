# BLoC Registration Implementation

## How to Use

To navigate to the RegisterPage with BLoC, use:

```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const RegisterPage()),
);
```

## Features

- ✅ Email and Password input fields
- ✅ BLoC pattern for state management
- ✅ Loading indicator during registration
- ✅ Success → Navigates to MainPage
- ✅ Failure → Shows error SnackBar

## Testing

1. Navigate to RegisterPage
2. Enter email and password
3. Click Register button
4. Wait 2 seconds (simulated network delay)
5. Should navigate to MainPage on success

