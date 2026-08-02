# Exam App

Flutter mobile app for the Elevate exam platform. Built with clean architecture, feature-first modules, and BLoC for state management.

## Features

- **Authentication** — login and sign-up with secure token storage
- **Password recovery** — forgot password → email OTP verification → reset password
- **Session handling** — auth status check on launch with splash screen
- **Navigation** — declarative routing with auth-aware redirects

## Tech Stack

| Layer | Package |
| --- | --- |
| UI / state | Flutter, `flutter_bloc`, Freezed |
| Networking | Dio, Retrofit |
| DI | GetIt, Injectable |
| Routing | GoRouter |
| Storage | Flutter Secure Storage |
| Code gen | `build_runner`, `json_serializable`, `retrofit_generator`, `injectable_generator`, `freezed` |

## Architecture

Feature-first clean architecture. Each feature is isolated into layers:

```
feature/<name>/
├── api/           # Retrofit clients & remote data source impls
├── data/          # Models, repositories, data source contracts
├── domain/        # Entities, use cases, repository contracts
└── presentation/  # Cubits, views, widgets
```

Shared cross-cutting code lives under:

- `lib/core/` — theme, routing, widgets, storage, API constants, validators
- `lib/config/` — DI setup, base response/state helpers, app module

## Project Structure

```
lib/
├── main.dart
├── config/
│   ├── di/                 # GetIt + Injectable
│   ├── app_module/         # Dio & API client registration
│   ├── base_response/
│   └── base_state/
├── core/
│   ├── api/
│   ├── constants/
│   ├── resources/          # Theme, palette, text styles
│   ├── routing/
│   ├── storage/
│   ├── utils/
│   └── widgets/
└── feature/
    ├── auth/               # Login, sign-up, auth session
    ├── forgot_password/    # Forgot → verify OTP → reset
    └── home/
```

## Getting Started

### Prerequisites

- Flutter SDK `^3.11.5` ([install](https://docs.flutter.dev/get-started/install))
- A device, emulator, or browser target

### Setup

```bash
git clone <repo-url>
cd exam_app
flutter pub get
```

### Code generation

Regenerate Freezed, Injectable, Retrofit, and JSON serializers after model/DI/API changes:

```bash
dart run build_runner build --delete-conflicting-outputs
```

For watch mode during development:

```bash
dart run build_runner watch --delete-conflicting-outputs
```

### Run

```bash
flutter run
```

## Screens & Routes

| Route | Screen |
| --- | --- |
| `/login` | Login |
| `/signup` | Sign up |
| `/forgot-password` | Forgot password |
| `/verification` | Email OTP verification |
| `/reset-password` | Reset password |
| `/home` | Home |

## API

Base URL: `https://exam.elevateegy.com/api/v1/`

| Endpoint | Purpose |
| --- | --- |
| `auth/signin` | Login |
| `auth/signup` | Sign up |
| `auth/forgotPassword` | Request reset code |
| `auth/verifyResetCode` | Verify OTP |
| `auth/resetPassword` | Set new password |

Configured in `lib/core/api/api_constants.dart`.

## Assets

- Images: `assets/images/`
- Fonts: Inter (`assets/fonts/inter/`) — Regular, Medium, SemiBold, Bold
