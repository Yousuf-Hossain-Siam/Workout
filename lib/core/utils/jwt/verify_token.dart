import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

/// Verifies if the JWT token is expired
/// Returns a message if expired, null if valid
bool verifyToken(String token) {
  try {
    final jwt = JWT.verify(token, SecretKey('secret passphrase'));
    return true;
  } on JWTExpiredException {
    return false;
  } on JWTException catch (ex) {
    return true;
  } catch (ex) {
    return true;
  }
}
