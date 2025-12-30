# Copilot / AI Agent Instructions for GebetaEats

Purpose
- Help contributors and AI assistants make small-to-medium code changes quickly and safely in this Flutter app.

Quick start (commands)
- Install deps: `flutter pub get`
- Run app: `flutter run -d <device>` (e.g. `-d windows` or `-d chrome`)
# Copilot / AI Agent Instructions for GebetaEats

Purpose
- Make small-to-medium edits quickly and safely by describing the project's structure, patterns, and developer workflows.

Quick start (commands)
- Install deps: `flutter pub get`
- Run app (desktop/web): `flutter run -d windows` or `flutter run -d chrome`
- Run tests: `flutter test`
- Build mobile: `flutter build apk` (Android) / `flutter build ios` (iOS)

Core architecture (big picture)
- Entry: `lib/main.dart` → `GebetaeatsApp` in `lib/app.dart`.
- Routing: single `_onGenerateRoute` in `lib/app.dart`. Named routes include `/`, `/onboarding`, `/home`, `/restaurant`, `/cart`.
- Views: feature-scoped UI under `lib/views/<feature>/` (e.g., `lib/views/restaurant/`).
- Models & data: `lib/models/` (see `mock_data.dart`, `restaurant_model.dart`, `dish.dart`). Mock data drives many screens.

State & patterns (what to follow)
- Global state: `AppState` in `lib/app_state.dart` (extends `ChangeNotifier`). UI accesses it via `AppStateScope`/`_AppStateProvider` used in `lib/app.dart`.
- Use `AppState` methods (`addDish(Dish)`, `decrementDish(Dish)`, `removeDish(Dish)`) instead of mutating internal maps directly; always call `notifyListeners()` via those APIs.
- Route arguments: models are passed through `RouteSettings.arguments` (example: `/restaurant` expects a `RestaurantModel`). Keep runtime casts local to the route handler.

UI, assets & theming
- Theme: centralized in `lib/theme.dart` — change global sizes/colors there.
- Images: app uses remote images in `lib/models/mock_data.dart`. No `assets:` entries exist in `pubspec.yaml`; if you add local assets, update `pubspec.yaml`.

Key files to inspect first
- `lib/app.dart` — routing and app wiring
- `lib/app_state.dart` — state APIs and mutations
- `lib/models/mock_data.dart` — sample content used across views
- `lib/theme.dart` — global styling
- `lib/views/` — feature UI implementations

Developer workflows & debugging
- Use VS Code with the Flutter extension for fast reloads and DevTools.
- Attach debugger: `flutter run --observatory-port=<port>` or use the IDE launch configs.
- Tests: `flutter test` runs unit/widget tests in `test/`.

Project-specific conventions
- Prefer `AppState` methods for cart changes; avoid direct map/list mutation in widgets.
- Pass whole model objects via `RouteSettings.arguments` rather than IDs; routes expect concrete types.
- Keep mock/sample data in `lib/models/mock_data.dart` for predictable UI during development.

Integration points / dependencies
- Notable packages visible in pubspec: `flutter_screenutil`, `cached_network_image`, `shared_preferences` (used for lightweight persistence).
- Native/platform code lives under `android/`, `ios/`, `windows/`, `macos/`, `linux/` — modify with caution for platform builds.

If you change code
- Update or add examples in `lib/models/mock_data.dart` so screens have sample content.
- When adding routes, update `_onGenerateRoute` in `lib/app.dart` and ensure callers pass correct `RouteSettings.arguments`.

Asking for feedback
- If anything here is unclear or you'd like a short example PR (add route, wire state in a view, or update theme), say which example and I'll implement it.

---
End of file.
