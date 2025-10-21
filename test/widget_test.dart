import 'package:flutter_test/flutter_test.dart';
import 'package:post_delivery/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PostDeliveryApp());

    // Verify that the app launches successfully
    expect(find.text('Post Delivery'), findsOneWidget);
    
    // Verify navigation bar exists
    expect(find.text('หน้าหลัก'), findsOneWidget);
    expect(find.text('ติดตามพัสดุ'), findsOneWidget);
    expect(find.text('รับพัสดุ'), findsOneWidget);
  });

  testWidgets('Home screen displays services', (WidgetTester tester) async {
    await tester.pumpWidget(const PostDeliveryApp());

    // Verify service cards are displayed
    expect(find.text('จองส่งพัสดุ'), findsOneWidget);
    expect(find.text('ติดตามพัสดุ'), findsWidgets);
    expect(find.text('รับพัสดุ'), findsWidgets);
  });

  testWidgets('Navigation between tabs works', (WidgetTester tester) async {
    await tester.pumpWidget(const PostDeliveryApp());

    // Tap on tracking tab
    await tester.tap(find.text('ติดตามพัสดุ').first);
    await tester.pumpAndSettle();

    // Verify tracking screen is shown
    expect(find.text('ค้นหาพัสดุของคุณ'), findsOneWidget);

    // Tap on receiving tab
    await tester.tap(find.text('รับพัสดุ').first);
    await tester.pumpAndSettle();

    // Verify receiving screen is shown
    expect(find.text('พัสดุของคุณ'), findsOneWidget);
  });
}
