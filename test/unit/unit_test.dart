import 'package:flutter_test/flutter_test.dart';

import 'package:testflyer/auth/login_helpers.dart';

void main() {
  group('isAcceptedDemoLoginPassword', () {
    test('returns true for every allow-listed password', () {
      expect(isAcceptedDemoLoginPassword('demo123'), isTrue);
      expect(isAcceptedDemoLoginPassword('PreparePrevent'), isTrue);
      expect(isAcceptedDemoLoginPassword('@Password123'), isTrue);
    });

    test('returns false for wrong or empty passwords', () {
      expect(isAcceptedDemoLoginPassword('wrong'), isFalse);
      expect(isAcceptedDemoLoginPassword(''), isFalse);
    });

    test('does not trim — must match list entry exactly', () {
      expect(isAcceptedDemoLoginPassword(' demo123'), isFalse);
      expect(isAcceptedDemoLoginPassword('demo123 '), isFalse);
    });
  });

  group('displayNameFromEmail', () {
    test('capitalizes local part before @', () {
      expect(displayNameFromEmail('norbert@example.com'), 'Norbert');
    });

    test('handles leading and trailing whitespace on email', () {
      expect(displayNameFromEmail('  amy@shop.test '), 'Amy');
    });

    test('returns User when local part empty', () {
      expect(displayNameFromEmail('@only.domain'), 'User');
      expect(displayNameFromEmail(''), 'User');
      expect(displayNameFromEmail('   '), 'User');
    });

    test('handles single-character local part', () {
      expect(displayNameFromEmail('x@test.dev'), 'X');
    });
  });
}
