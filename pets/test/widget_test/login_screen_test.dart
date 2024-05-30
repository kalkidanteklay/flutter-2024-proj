import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:pets/login/login%20bloc.dart';
import 'package:pets/login/presentation.dart';
import 'package:pets/login/states.dart';
import 'package:pets/login/events.dart';

// Mock classes
class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

void main() {
  group('LoginScreen', () {
    late MockAuthBloc mockAuthBloc;

    setUp(() {
      mockAuthBloc = MockAuthBloc();
    });

    testWidgets('shows SnackBar on AuthError', (WidgetTester tester) async {
      whenListen(
        mockAuthBloc,
        Stream<AuthState>.fromIterable(
            [AuthError(message: 'Invalid email or password')]),
        initialState: AuthInitial(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AuthBloc>(
            create: (context) => mockAuthBloc,
            child: LoginScreen(),
          ),
        ),
      );

      // Tap the login button to trigger the listener
      await tester.tap(find.text('Log in'));
      await tester.pump();

      // Verify that the SnackBar is shown with the error message
      expect(find.text('Invalid email or password'), findsOneWidget);
    });
  });
}
