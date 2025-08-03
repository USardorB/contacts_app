# Contacts App

A Flutter application with Firebase authentication and contact management features.

## Features

- **Firebase Authentication**: Complete sign-up, login, and logout functionality
- **SharedPreferences Integration**: Persistent welcome page state management
- **Go Router Navigation**: Proper route handling with authentication guards
- **Modern UI**: Clean and responsive design with proper loading states
- **Error Handling**: Comprehensive error handling for all authentication operations

## Authentication Flow

1. **Welcome Page**: First-time users see the welcome page
2. **Sign Up**: Users can create new accounts with email and password
3. **Login**: Existing users can log in with their credentials
4. **Password Reset**: Users can request password reset emails
5. **Contacts Page**: Authenticated users see their contacts dashboard
6. **Logout**: Users can log out and return to welcome page

## Technical Implementation

### Authentication Service (`lib/feature/auth/data/auth_service.dart`)
- Firebase Auth integration with proper error handling
- User profile management (display name)
- SharedPreferences integration for welcome page state
- Custom `AuthException` for better error handling

### Router Configuration (`lib/core/router/app_router.dart`)
- Dynamic routing based on authentication state
- Welcome page state management
- Proper redirects for authenticated/unauthenticated users

### Pages
- **Welcome Page**: Entry point with "Join Now" button
- **Sign Up Page**: User registration with validation
- **Login Page**: User authentication with password reset
- **Contacts Page**: Main dashboard with user info and logout

## Getting Started

1. Ensure Firebase is properly configured in your project
2. Run `flutter pub get` to install dependencies
3. Run the app with `flutter run`

## Dependencies

- `firebase_auth`: Firebase authentication
- `firebase_core`: Firebase core functionality
- `go_router`: Navigation and routing
- `shared_preferences`: Local storage for app state
- `flutter_screenutil`: Responsive design
- `google_fonts`: Typography
- `provider`: State management

## File Structure

```
lib/
├── core/
│   ├── router/          # Navigation and routing
│   ├── services/        # App initialization services
│   ├── theme/           # UI theming
│   └── widgets/         # Reusable UI components
├── feature/
│   ├── auth/            # Authentication feature
│   │   ├── data/        # Auth service
│   │   └── presentation/ # Auth UI pages
│   └── contacts/        # Contacts feature
└── main.dart           # App entry point
```

## Authentication States

- **Unauthenticated + No Welcome**: Show welcome page
- **Unauthenticated + Welcome Seen**: Show welcome page (can navigate to auth)
- **Authenticated**: Show contacts page (redirect from auth pages)
