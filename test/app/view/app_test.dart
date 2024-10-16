import 'package:crypto_view/app/app.dart';
import 'package:crypto_view/features/watchlist/watchlist.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(WatchlistPage), findsOneWidget);
    });
  });
}
