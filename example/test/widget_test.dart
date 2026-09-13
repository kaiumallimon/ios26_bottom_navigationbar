import 'package:flutter_test/flutter_test.dart';
import 'package:ios26_bottom_navigationbar_example/main.dart';

void main() {
  testWidgets('IOS26DemoApp renders and navigates tabs', (WidgetTester tester) async {
    await tester.pumpWidget(const IOS26DemoApp());
    await tester.pumpAndSettle();

    expect(find.text('iOS 26 Navigation Bar'), findsOneWidget);
    expect(find.text('Home'), findsWidgets);
    expect(find.text('Pharmacy'), findsWidgets);

    // Tap on Pharmacy tab
    await tester.tap(find.text('Pharmacy'));
    await tester.pumpAndSettle();

    // Verify Pharmacy content is visible
    expect(find.text('Pharmacy'), findsWidgets);
  });
}
