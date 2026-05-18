import 'package:flutter/material.dart';

import 'screens/login_screen.dart';
import 'screens/store_selection_screen.dart';
import 'screens/testdrive_home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TestDriver',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1B3F7A)),
        useMaterial3: true,
      ),
      home: const AuthFlow(),
    );
  }
}

/// Keeps login and store screens separate files without circular imports.
class AuthFlow extends StatefulWidget {
  const AuthFlow({super.key});

  @override
  State<AuthFlow> createState() => _AuthFlowState();
}

class _AuthFlowState extends State<AuthFlow> {
  String? _displayName;
  StoreRecord? _checkedInStore;

  void _signOut() => setState(() {
    _displayName = null;
    _checkedInStore = null;
  });

  @override
  Widget build(BuildContext context) {
    final name = _displayName;
    if (name == null) {
      return LoginScreen(
        onAuthenticated: (displayName) =>
            setState(() => _displayName = displayName),
      );
    }
    final store = _checkedInStore;
    if (store != null) {
      return TestDriverHomeScreen(
        store: store,
        onSignOut: _signOut,
        onBackToStoreSelection: () => setState(() => _checkedInStore = null),
      );
    }
    return StoreSelectionScreen(
      displayName: name,
      onLogout: _signOut,
      onCheckedIn: (s) => setState(() => _checkedInStore = s),
    );
  }
}
