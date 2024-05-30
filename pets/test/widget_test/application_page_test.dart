import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pets/adoption_application/presentation.dart';

void main() {
  testWidgets('ApplicationPage displays form fields and submit button',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ApplicationPage(userId: 'user_456', token: 'dummy_token'),
      ),
    );

    // Verify that the form fields are present
    expect(find.text('Full Name'), findsOneWidget);
    expect(find.text('Address'), findsOneWidget);
    expect(find.text('Phone Number'), findsOneWidget);
    expect(find.text('Type of Pet'), findsOneWidget);
    expect(find.text('Gender'), findsOneWidget);
    expect(find.text('Age Range'), findsOneWidget);
    expect(find.text('Previous Pet Ownership Experience'), findsOneWidget);

    // Verify that the submit button is present
    expect(find.text('Submit'), findsOneWidget);
  });
}
