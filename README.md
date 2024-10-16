
# Crypto View App

A simple Flutter application that tracks cryptocurrency prices and provides live updates. The app displays real-time price data and a line chart for Ethereum (ETH-USD), along with a watchlist for other cryptocurrencies like Bitcoin (BTC-USD).

/App_screenshot.jpeg![image](https://github.com/user-attachments/assets/b252f1c7-240e-4d8d-8986-bf1cba916727)

## Features

- Live cryptocurrency price updates
- Line chart for visualizing the price trend of selected crypto (ETH-USD)
- Watchlist showing prices, changes, and percentage changes for various cryptocurrencies
- Light and dark theme toggle

## Requirements

- **Flutter version:** 3.24 or higher
- **Dart version:** 3.0.0 or higher
- **Development Tools:** Android Studio, Visual Studio Code, or any other preferred IDE
- **Platforms Supported:**
  - Android
  - iOS

## Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/crypto-view-app.git
cd crypto-view-app
```

### 2. Install Flutter Dependencies

Run the following command in the project root directory to install the required dependencies:

```bash
flutter pub get
```

### 3. Run the Application

You can run the app on your connected device or emulator with:

```bash
flutter run
```

For a specific platform (iOS or Android), you can specify the platform:

```bash
# For Android
flutter run -d android

# For iOS
flutter run -d ios
```

### 4. Building the Application

You can build the app for release with the following commands:

- **For Android:**

```bash
flutter build apk
```

- **For iOS:**

```bash
flutter build ios
```

### 5. Running and Building with Flavors

This app uses flavors to handle different environments (development, staging, production) using `very_good_cli`. You can run or build the app with a specific flavor by using the following commands:

- **Running with a Flavor:**

```bash
# For Android (development flavor)
flutter run --flavor development -t lib/main_development.dart

# For iOS (production flavor)
flutter run --flavor production -t lib/main_production.dart
```

- **Building with a Flavor:**

```bash
# For Android (staging flavor)
flutter build apk --flavor staging -t lib/main_staging.dart

# For iOS (production flavor)
flutter build ios --flavor production -t lib/main_production.dart
```

## Configuration

This app doesn't need to be configured further since it is only experimental app, and it doesn't need any environtment variable at all.

## Development Notes

- Ensure you have an active internet connection as the app fetches real-time data.
- The UI dynamically updates based on the fetched data.
- Use Flutter 3.24 for better compatibility and features.

## Troubleshooting

If you encounter issues while running the app, try the following:

- Make sure your Flutter environment is set up correctly. Run `flutter doctor` to check for potential issues.
- Ensure that you have the latest version of the app dependencies by running `flutter pub upgrade`.
