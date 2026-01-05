# GebetaEats
GebetaEats is a Flutter food delivery experience that integrates with Supabase for auth and data. It includes onboarding, authentication, restaurant browsing, dish detail, cart/checkout, order history, favorites, and profile management.

## Features
- Email/password auth backed by Supabase
- Restaurant and menu browsing with Supabase-sourced data
- Cart, checkout, delivery fee calculation, and order placement
- Order history and lightweight delivery status progression
- Favorites for dishes and restaurants, saved addresses, and profile updates
- Responsive UI (flutter_screenutil), cached images, and Google Fonts styling

## Tech Stack
- Flutter (Dart 3.9+)
- State: Provider via custom `AppStateScope`
- Backend: Supabase (auth, Postgres tables, policies)
- UI libs: google_fonts, iconsax, flutter_screenutil, cached_network_image
- Persistence/utilities: shared_preferences, intl

## Project Structure
- lib/main.dart – app entry, initializes Supabase and wires state
- lib/app.dart – MaterialApp, routes, navigation
- lib/app_state.dart – single source of truth for cart, favorites, profile, restaurants, dishes, and orders
- lib/services/supabase_client.dart – Supabase init and all queries/mutations
- lib/models/ – data models (Restaurant, Dish, Order, mocks)
- lib/views/ – screens (splash, onboarding, auth, home, restaurant detail, cart, checkout, orders, profile)
- assets/icons/ – launcher icon source

3) Enable Row Level Security on all tables and add policies, for example:
- `users`, `orders`, `order_items`: allow authenticated users to read/insert/update their own rows (match `auth.uid()` on `user_id` or `id`).
- `restaurants`, `food_items`: allow read to authenticated users; restrict writes to admins as needed.

4) Configure credentials:
- The app currently initializes Supabase in [lib/services/supabase_client.dart](lib/services/supabase_client.dart). Replace the placeholder `url` and `anonKey` with your project values.
- For production, prefer injecting secrets via `--dart-define` or environment configuration instead of committing keys.

5) Seed data (optional): insert a few restaurants and food_items so the home and restaurant detail screens have content.

## Local Development
1) Prerequisites: Flutter 3.19+ SDK, Android Studio/Xcode tooling, a Supabase project with the schema above.
2) Install deps:
```bash
flutter pub get
```
3) Run (pick a device or emulator):
```bash
flutter run
```

## App Flow
- Splash → Onboarding → Login/Register → Home
- Home lists restaurants; selecting one opens Restaurant Detail with menu items.
- Add dishes to cart → Cart → Checkout → Order placed to Supabase (orders + order_items).
- Order History lists previous orders; lightweight status progression is time-based.
- Profile: update name/email/address; manage favorites and saved addresses.

## State & Data
- Global state lives in `AppState` (cart, favorites, addresses, user profile, restaurants, dishes, orders) and is exposed via `AppStateScope` (InheritedNotifier + Provider pattern).
- Supabase data access and auth live in `SupabaseService` (init, sign up/in/out, profile CRUD, restaurant/food queries, order placement, order fetch).
- Models map Supabase rows to UI-friendly objects (Restaurant, Dish) with safe defaults and basic formatting.

## Testing & Quality
- Run tests: `flutter test`
- Lints: `flutter_lints` is enabled via `analysis_options.yaml`.

## Assets & Icons
- App icon source: assets/icons/app_logo.png (configured in `flutter_icons`).
- Add additional assets under `assets/` and register them in `pubspec.yaml` if needed.

## Notes
- Do not commit production Supabase keys. Prefer environment-based injection.
- If you change table names/columns, update the mappings in `SupabaseService` and the model factories accordingly.
