import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:testflyer/main.dart';

void main() {
  testWidgets('auth flow reaches keyed home after check-in', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byKey(const ValueKey('email_field')), findsOneWidget);
    expect(find.byKey(const ValueKey('password_field')), findsOneWidget);

    await tester.enterText(
      find.byKey(const ValueKey('email_field')),
      'norbert@example.com',
    );
    await tester.enterText(
      find.byKey(const ValueKey('password_field')),
      'demo123',
    );
    await tester.tap(find.byKey(const ValueKey('submit_button')));
    await tester.pump();
    expect(find.byKey(const ValueKey('login_loader')), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 800));

    expect(find.byKey(const ValueKey('welcome_header')), findsOneWidget);
    expect(find.byKey(const ValueKey('current_date_display')), findsOneWidget);
    expect(
      find.byKey(const ValueKey('store_dropdown_selector')),
      findsOneWidget,
    );
    expect(find.byKey(const ValueKey('checkin_action_button')), findsOneWidget);
    expect(find.byKey(const ValueKey('logout_action_button')), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('checkin_action_button')));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('home_nav_home')), findsOneWidget);
    expect(find.byKey(const ValueKey('home_nav_account')), findsOneWidget);
    expect(find.byKey(const ValueKey('home_sign_out_button')), findsOneWidget);
  });
}
