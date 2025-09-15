import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/src/app/app.dart';

void main() {
  testWidgets('App renders correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const AstrologyApp());

    // Verify that the app bar title is displayed.
    expect(find.text('Astrology AI Assistant'), findsOneWidget);
  });
}
