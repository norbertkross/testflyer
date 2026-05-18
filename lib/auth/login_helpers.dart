import 'valid_passwords.dart';

bool isAcceptedDemoLoginPassword(String password) {
  return kValidLoginPasswords.contains(password);
}

String displayNameFromEmail(String email) {
  final local = email.trim().split('@').first;
  if (local.isEmpty) return 'User';
  return local[0].toUpperCase() + local.substring(1);
}
