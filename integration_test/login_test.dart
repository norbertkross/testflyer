import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:testflyer/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App Login', () {
    /// Uses the same [ValueKey]s as production widgets (`email_field`, etc.).
    testWidgets('should login with valid credentials (keys)', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      final emailField = find.byKey(const ValueKey('email_field'));
      final passwordField = find.byKey(const ValueKey('password_field'));
      final submitButton = find.byKey(const ValueKey('submit_button'));

      await tester.tap(emailField);
      await tester.pumpAndSettle();
      await tester.enterText(emailField, 'vroom@drivers_inc.com');
      await tester.pumpAndSettle();

      await tester.tap(passwordField);
      await tester.pumpAndSettle();
      await tester.enterText(passwordField, '@Password123');
      await tester.pumpAndSettle();

      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();

      await tester.tap(submitButton);
      await tester.pump(const Duration(milliseconds: 900));
      await tester.pumpAndSettle();

      expect(find.byKey(const ValueKey('welcome_header')), findsOneWidget);
      expect(find.byKey(const ValueKey('store_dropdown_selector')), findsOneWidget);
    });

    /// [kDemoStores] includes e.g. **Driver Site** (`driver-site`). Each run starts fresh.
    testWidgets(
      'should select Driver Site and reach home after check-in',
      (tester) async {
        app.main();
        await tester.pumpAndSettle();

        await tester.enterText(
          find.byKey(const ValueKey('email_field')),
          'vroom@drivers_inc.com',
        );
        await tester.enterText(
          find.byKey(const ValueKey('password_field')),
          '@Password123',
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const ValueKey('submit_button')));
        await tester.pump(const Duration(milliseconds: 900));
        await tester.pumpAndSettle();

        expect(find.byKey(const ValueKey('store_dropdown_selector')), findsOneWidget);

        await tester.tap(find.byKey(const ValueKey('store_dropdown_selector')));
        await tester.pumpAndSettle();

        // Menu item subtitle is the unique store code.
        await tester.tap(find.text('driver-site').last);
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const ValueKey('checkin_action_button')));
        await tester.pumpAndSettle();

        expect(find.byKey(const ValueKey('home_nav_home')), findsOneWidget);
        expect(find.byKey(const ValueKey('home_nav_account')), findsOneWidget);
        expect(find.textContaining('Driver Site'), findsWidgets);
      },
    );
  });
}
