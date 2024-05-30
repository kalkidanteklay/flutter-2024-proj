import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pets/signup%20and%20login/bloc.dart';
import 'package:pets/signup%20and%20login/events.dart';
import 'package:pets/signup%20and%20login/presentation.dart';
// import 'package:pets/signup/events.dart';
import 'package:pets/signup/states.dart';
import 'package:pets/signup/user%20model.dart';
import 'signup_page_test.mocks.dart';

// Mock classes
// class MockAuthBlocCustom extends MockBloc<AuthEvent, AuthState>
//     implements AuthBloc {}

@GenerateMocks(
  [AuthBloc],
  customMocks: [
    MockSpec<AuthBloc>(as: #MockAuthBlocCustom),
  ],
)
void main() {
  group('SignupPage', () {
    late MockAuthBlocCustom mockAuthBloc;

    setUp(() {
      mockAuthBloc = MockAuthBlocCustom();
    });

    testWidgets('renders SignupPage and interacts with form',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AuthBloc>(
            create: (context) => mockAuthBloc,
            child: const SignupPage(),
          ),
        ),
      );

      // Verify the presence of form fields and button
      expect(find.text("P E T P A L    A D O P T I O N"), findsOneWidget);
      expect(find.byType(MyTextfield), findsNWidgets(3));
      expect(find.text('Sign Up'), findsOneWidget);

      // Enter text into form fields
      await tester.enterText(
          find.widgetWithText(MyTextfield, 'Enter your full name'), 'John Doe');
      await tester.enterText(
          find.widgetWithText(MyTextfield, 'Enter your email'),
          'test@example.com');
      await tester.enterText(
          find.widgetWithText(MyTextfield, 'Enter your password'),
          'password123');

      // Tap the Sign Up button
      await tester.tap(find.text('Sign Up'));
      await tester.pump();

      // Verify that SignupRequested event was added
      final expectedUser = User(
          fullName: 'John Doe',
          email: 'test@example.com',
          password: 'password123');
      verify(mockAuthBloc.add(SignupRequested(user: expectedUser))).called(1);
    });

    testWidgets('shows SnackBar on AuthError', (WidgetTester tester) async {
      whenListen(
        mockAuthBloc,
        Stream<AuthState>.fromIterable([AuthError(message: 'Signup failed')]),
        initialState: AuthInitial(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AuthBloc>(
            create: (context) => mockAuthBloc,
            child: const SignupPage(),
          ),
        ),
      );

      // Tap the Sign Up button to trigger the listener
      await tester.tap(find.text('Sign Up'));
      await tester.pump();

      // Verify that the SnackBar is shown with the error message
      expect(find.text('Signup failed'), findsOneWidget);
    });
  });
}
