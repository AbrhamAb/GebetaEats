# GebetaEats

**GebetaEats** is a comprehensive food delivery mobile application built with Flutter. It provides a seamless user experience for browsing restaurants, exploring categories, managing a cart, and tracking orders, featuring a robust state management system using BLoC.

## 🚀 Features

-   **User Authentication**: clear login and onboarding flow.
-   **Restaurant Discovery**: Browse a variety of restaurants and filter by categories (e.g., Fast Food).
-   **Detailed Menus**: View detailed restaurant information and explore dish categories.
-   **Shopping Cart**: Add items, manage quantities, and review your order.
-   **Checkout Process**: Streamlined checkout flow for placing orders.
-   **Order Tracking**: Real-time order status tracking.
-   **Profile Management**: Manage user settings and profile information.
-   **Responsive Design**: Built with `flutter_screenutil` for pixel-perfect UI across different device sizes.

## 🛠 Tech Stack

-   **Framework**: [Flutter](https://flutter.dev/) (Dart)
-   **State Management**: 
    -   [Flutter Bloc](https://pub.dev/packages/flutter_bloc) (Primary for feature logic)
    -   [Provider](https://pub.dev/packages/provider)
-   **Routing**: Named routes with Argument passing.
-   **Styling**: Custom theme with Google Fonts.
-   **Assets**: `cached_network_image` for efficient image loading, `iconsax` for modern icons.
-   **Local Storage**: `shared_preferences`.

## 📂 Project Structure

The project is structured to separate concerns between UI, State Management, and Data Models.

```
lib/
├── main.dart           # Entry point and BlocProvider setup
├── app.dart            # MaterialApp, Routing configurations, and Theme setup
├── app_state.dart      # Global app state scope
├── theme.dart          # Application-wide theme definitions
├── models/             # Data models (User, Restaurant, Order, Dish, etc.)
└── views/              # UI Screens and Feature-specific Blocs
    ├── auth/           # Login and Authentication screens
    ├── home/           # Home screen and Category listings
    ├── restaurant/     # Restaurant details and menu
    ├── cart/           # Cart management
    ├── checkout/       # Checkout process
    ├── orders/         # Order history and details
    ├── order_tracking/ # Order tracking screen
    ├── onboard/        # Onboarding flow
    └── profile/        # User profile settings
```

## 🚥 Getting Started

### Prerequisites

-   [Flutter SDK](https://docs.flutter.dev/get-started/install) installed on your machine.
-   An IDE (VS Code or Android Studio) with Flutter extensions.

### Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/your-username/gebeta_eats.git
    cd GebetaEats
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Run the application:**
    ```bash
    flutter run
    ```

## 📱 Navigation & Routes

The app uses named routes for navigation. Key routes defined in `lib/app.dart`:

-   `/`: Splash Screen
-   `/onboarding`: Onboarding Screen
-   `/login`: Login Screen
-   `/home`: Home Screen
-   `/restaurant`: Restaurant Details
-   `/cart`: Shopping Cart
-   `/checkout`: Checkout Screen
-   `/order-tracking`: Order Tracking

## 🧪 Development

This project uses `mock_data.dart` in the `models` folder to simulate backend data for development convenience. You can switch this with real API integration in the respective Repositories or Blocs.


