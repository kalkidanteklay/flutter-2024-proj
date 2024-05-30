import 'package:pets/signup/user%20model.dart';
import 'package:test/test.dart';
import 'package:equatable/equatable.dart';

void main() {
  group('User', () {
    test('supports value equality', () {
      expect(
        const User(
            fullName: 'Abebe',
            email: 'abe@example.com',
            password: 'password123'),
        const User(
            fullName: 'Abebe',
            email: 'abe@example.com',
            password: 'password123'),
      );
    });

    test('props contains the correct values', () {
      const user = User(
          fullName: 'Ababa',
          email: 'aba@example.com',
          password: 'securepassword');
      expect(user.props, ['Ababa', 'aba@example.com', 'securepassword']);
    });

    test('different users are not equal', () {
      const user1 = User(
          fullName: 'Alice', email: 'alice@example.com', password: 'pass1');
      const user2 =
          User(fullName: 'Bob', email: 'bob@example.com', password: 'pass2');
      expect(user1 == user2, isFalse);
    });

    test('same users with different passwords are not equal', () {
      const user1 = User(
          fullName: 'Charlie', email: 'charlie@example.com', password: 'pass1');
      const user2 = User(
          fullName: 'Charlie', email: 'charlie@example.com', password: 'pass2');
      expect(user1 == user2, isFalse);
    });
  });
}
