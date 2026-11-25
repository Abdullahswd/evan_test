import 'package:flutter_test/flutter_test.dart';
import 'package:evan/main.dart';

void main() {
  testWidgets('App smoke test builds WaslApp', (WidgetTester tester) async {
    await tester.pumpWidget(const WaslApp());
    expect(find.byType(WaslApp), findsOneWidget);
  });
}
