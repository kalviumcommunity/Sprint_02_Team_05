import 'package:flutter_test/flutter_test.dart';

import 'package:loyalty_link/main.dart';

void main() {
  testWidgets('Welcome screen renders correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const LoyaltyLinkApp());

    // Verify the welcome text is shown.
    expect(find.text('Welcome to LoyaltyLink'), findsOneWidget);

    // Verify the Get Started button is shown.
    expect(find.text('Get Started'), findsOneWidget);

    // Tap the button and trigger a frame.
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    // After tapping, the text should toggle.
    expect(find.text('Welcome aboard! 🎉'), findsOneWidget);
    expect(find.text('Joined ✓'), findsOneWidget);
  });
}
