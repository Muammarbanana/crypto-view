import 'package:crypto_view/features/features.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const WatchlistPage());
      default:
        return MaterialPageRoute(builder: (_) => const WatchlistPage());
    }
  }
}
