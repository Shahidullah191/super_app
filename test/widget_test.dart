// Fix: update test to use SuperApp instead of old MyApp boilerplate
import 'package:flutter_test/flutter_test.dart';
import 'package:super_app/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const SuperApp());
    expect(find.byType(SuperApp), findsOneWidget);
  });
}
