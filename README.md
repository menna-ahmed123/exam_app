# Exam App

Flutter mobile app for the [Elevate](https://exam.elevateegy.com) online exam platform. Browse subjects, take timed exams, review answers, and track local history — built with clean architecture, Cubit + Freezed, and feature-first modules.

## Features

### Authentication
- Login and sign-up with secure token storage (`token` header)
- Password recovery: forgot password → email OTP → reset password
- Auth-aware splash and route redirects on launch

### Exam flow
- **Explore** — browse subjects with search
- **Subject exams** — available exams from the API + local attempt history
- **Instructions** — exam rules before starting
- **Taking exam** — countdown timer, progress, single/multi choice, Back / Next / Finish, timeout dialog
- **Score** — percentage ring, correct / incorrect counts, Show results / Start again
- **Answers review** — per-question highlighting (selected vs correct), independent of global pass/fail
- **Results tab** — local history grouped by subject

### App shell
- Bottom navigation: Explore · Result · Profile
- Declarative GoRouter navigation with typed `extra` args

## Tech Stack

| Concern | Package |
| --- | --- |
| UI / state | Flutter, `flutter_bloc`, Freezed |
| Networking | Dio, Retrofit |
| DI | GetIt, Injectable |
| Routing | GoRouter |
| Storage | Flutter Secure Storage |
| Code gen | `build_runner`, `json_serializable`, `retrofit_generator`, `injectable_generator`, `freezed` |
| Misc | `intl`, `url_launcher`, `flutter_native_splash`, `flutter_launcher_icons` |

## Architecture

Feature-first clean architecture. Each feature is isolated into layers:

```
feature/<name>/
├── api/           # Retrofit clients & remote data source impls
├── data/          # Models, repositories, data source contracts
├── domain/        # Entities, use cases, repository contracts
└── presentation/  # Cubits, views, widgets
```

Shared cross-cutting code:

| Path | Role |
| --- | --- |
| `lib/core/` | Theme, routing, widgets, storage, API constants, validators |
| `lib/config/` | DI setup, Dio module, base response / state helpers |

State pattern: Cubit + Freezed events/states, with a shared `BaseState<T>` for loading / data / error.

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
│   ├── api/                # Interceptor, constants
│   ├── constants/
│   ├── resources/          # Theme, AppPalette, text styles
│   ├── routing/
│   ├── storage/
│   ├── utils/
│   └── widgets/
└── feature/
    ├── auth/               # Login, sign-up, session
    ├── forgot_password/    # Forgot → verify OTP → reset
    └── exam/
        ├── api/
        ├── data/           # Remote + local history
        ├── domain/
        └── presentation/
            ├── explore/
            ├── subject_exams/
            ├── instructions/
            ├── taking_exam/
            ├── score/
            ├── answers/
            └── history/
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

Regenerate Freezed, Injectable, Retrofit, and JSON serializers after model / DI / API changes:

```bash
dart run build_runner build
```

Watch mode during development:

```bash
dart run build_runner watch
```

### Run

```bash
flutter run
```

### Tests

```bash
flutter test
```

## Screens & Routes

| Route | Screen |
| --- | --- |
| `/login` | Login |
| `/signup` | Sign up |
| `/forgot-password` | Forgot password |
| `/verification` | Email OTP verification |
| `/reset-password` | Reset password |
| `/home` | Home (Explore / Result / Profile) |
| `/subject-exams` | Exams for a subject |
| `/exam-instructions` | Pre-exam instructions |
| `/taking-exam` | Live exam session |
| `/exam-score` | Score summary |
| `/exam-answers` | Per-question answers review |

## Exam user flow

```text
Explore subjects
    → Subject exams
        → Instructions
            → Taking exam (timer + answers)
                → Score
                    → Show results (answers review)
                    → or Start again
```

Answers review coloring (per option, per question):

| Condition | Color |
| --- | --- |
| Option is correct (selected or not) | Green (`AppPalette.success` / `correctBackground`) |
| Option is selected and incorrect | Red (`AppPalette.error` / `incorrectBackground`) |
| Otherwise | Default (`optionBackground`) |

Local history is stored securely under `exam_history` and does not block navigation to the score screen if save fails.

## API

Base URL: `https://exam.elevateegy.com/api/v1/`

Auth uses the `token` header (not `Bearer`). See `lib/core/api/auth_interceptor.dart`.

| Endpoint | Purpose |
| --- | --- |
| `auth/signin` | Login |
| `auth/signup` | Sign up |
| `auth/forgotPassword` | Request reset code |
| `auth/verifyResetCode` | Verify OTP |
| `auth/resetPassword` | Set new password |
| `subjects` | List subjects |
| `exams` | List exams (optional `subject` query) |
| `exams/:id` | Exam by id |
| `questions?exam=` | Questions for an exam |
| `questions/check` | Submit answers and score |

Configured in `lib/core/api/api_constants.dart`.

Postman docs: [Elevate Exam API](https://documenter.getpostman.com/view/5709532/2sAXxMfYUf)

## Assets

- Images: `assets/images/`
- Fonts: Inter (`assets/fonts/inter/`) — Regular, Medium, SemiBold, Bold

## Conventions

- Prefer feature modules over dumping logic in `core/`
- Reuse `AppPalette`, `AppTextStyles`, and shared widgets — no hardcoded one-off colors for exam feedback
- Keep Cubit business logic out of widgets; pass typed route `extra` args (`ExamSessionArgs`, `ExamScoreArgs`, `ExamHistoryEntity`)
- After changing Freezed / Injectable / Retrofit / JSON models, re-run `build_runner`
