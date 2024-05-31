import 'package:pets/signup/user%20model.dart';
import 'package:test/test.dart';

void main() {
  group('User', () {
    test('Two users with the same properties are equal', () {
      final user1 = User(
        fullName: 'abebe a',
        email: 'abebe@example.com',
        password: 'password123',
      );

      final user2 = User(
        fullName: 'abebe a',
        email: 'abebe@example.com',
        password: 'password123',
      );

      expect(user1, equals(user2));
    });

    test('hashCode returns the same value for equal objects', () {
      final user1 = User(
        fullName: 'abebe a',
        email: 'abebe@example.com',
        password: 'password123',
      );
      final user2 = User(
        fullName: 'abebe a',
        email: 'abebe@example.com',
        password: 'password123',
      );

      expect(user1.hashCode, equals(user2.hashCode));
    });

    test('toString returns a meaningful representation', () {
      final user = User(
        fullName: 'abebe',
        email: 'abebe@example.com',
        password: 'password123',
      );

      expect(
          user.toString(),
          equals(
              'User(fullName: abebe, email: abebe@example.com, password: password123)'));
    });
  });
}
