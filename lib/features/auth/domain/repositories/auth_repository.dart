import '../entities/user.dart';

/// Contract for authentication data access.
///
/// Swap implementation to connect to Supabase Auth.
abstract class AuthRepository {
  /// Attempts to log in with [email] and [password].
  /// Returns [User] on success, throws on failure.
  Future<User> login(String email, String password);

  /// Logs out the current user.
  Future<void> logout();
}
