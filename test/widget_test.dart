import 'package:flutter_test/flutter_test.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:nova/main.dart';

void main() {
  testWidgets('Drawer navigation flow, calendar events, and home navigation', (WidgetTester tester) async {
    // Build the app and trigger a frame
    await tester.pumpWidget(const NovaApp());

    // Verify Home Screen content
    expect(find.text('Nova Assistant'), findsOneWidget);
    expect(find.text('Hello, I\'m Nova.'), findsOneWidget);
    expect(find.text('What can I do for you?'), findsOneWidget);

    // Step 1: Navigate to Nova UI Screen
    await tester.tap(find.text('What can I do for you?'));
    await tester.pumpAndSettle();

    // Verify Nova UI Screen is displayed
    expect(find.text('Nova UI'), findsOneWidget);
    expect(find.text('Welcome to Nova!'), findsOneWidget);

    // Step 2: Open the Drawer in Nova UI
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    // Verify Drawer contains Home and Calendar options
    expect(find.text('Home Screen'), findsOneWidget);
    expect(find.text('Calendar'), findsOneWidget);

    // Step 3: Navigate to Calendar Screen
    await tester.tap(find.text('Calendar'));
    await tester.pumpAndSettle();

    // Verify Calendar screen is displayed
    expect(find.text('Calendar UI'), findsOneWidget);
    expect(find.byType(TableCalendar), findsOneWidget);

    // Step 4: Test Drawer from Calendar Screen
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    // Drawer options still present on Calendar screen
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Calendar'), findsOneWidget);

    // Step 5: Add a Calendar Event
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Verify Add Event dialog appears
    expect(find.text('Add Event'), findsOneWidget);

    // Enter a new event and save
    await tester.enterText(find.byType(TextField), 'Test Event');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    // Verify the event is added to the list
    expect(find.text('Test Event'), findsOneWidget);

    // Step 6: Delete the Calendar Event
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pumpAndSettle();

    // Verify the event is removed
    expect(find.text('Test Event'), findsNothing);

    // Step 7: Open Drawer and Navigate Back to Home Screen
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();

    // Verify Home Screen is displayed again
    expect(find.text('Nova Assistant'), findsOneWidget);
    expect(find.text('Hello, I\'m Nova.'), findsOneWidget);
  });
}
