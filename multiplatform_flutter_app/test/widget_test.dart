// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:multiplatform_flutter_app/main.dart';

void main() {
  testWidgets('TextField input and display test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our TextField is present with the correct label.
    expect(find.text('Enter your name'), findsOneWidget);

    // Verify that the app title is correct.
    expect(find.text('TextField Demo'), findsOneWidget);

    // Verify that the button is present.
    expect(find.text('Show Entered Text'), findsOneWidget);

    // Enter text into the TextField.
    await tester.enterText(find.byType(TextField), 'John Doe');

    // Tap the button to show entered text.
    await tester.tap(find.text('Show Entered Text'));
    await tester.pump();

    // Verify that a SnackBar appears with the entered text.
    expect(find.text('You entered: John Doe'), findsOneWidget);
  });

  testWidgets('TextField widget structure test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that we have a TextField.
    expect(find.byType(TextField), findsOneWidget);

    // Verify that we have an ElevatedButton.
    expect(find.byType(ElevatedButton), findsOneWidget);

    // Verify that we have a Scaffold.
    expect(find.byType(Scaffold), findsOneWidget);

    // Verify that we have an AppBar.
    expect(find.byType(AppBar), findsOneWidget);

    // Verify that we have a Column for layout.
    expect(find.byType(Column), findsOneWidget);
  });

  testWidgets('TextField keyboard submission test', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Enter text into the TextField.
    await tester.enterText(find.byType(TextField), 'Test User');

    // Simulate pressing the "Done" key on the keyboard.
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();

    // Verify that a SnackBar appears with the entered text.
    expect(find.text('You entered: Test User'), findsOneWidget);
  });
}
