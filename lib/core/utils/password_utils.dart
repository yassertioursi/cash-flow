import 'dart:convert';
import 'package:crypto/crypto.dart';

class PasswordUtils {

  static String hashPassword(String password, String email) {
    final saltedPassword = '$email:$password';
    final bytes = utf8.encode(saltedPassword);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  static bool verifyPassword(String password, String email, String storedHash) {
    final computedHash = hashPassword(password, email);
    return computedHash == storedHash;
  }
}
