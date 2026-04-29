import '../../domain/entities/user.dart';

/// Local data source for authentication mock.
///
/// Replace with Supabase Auth when connecting to backend.
class AuthLocalDataSource {
  static const _validEmail = 'admin@dkost.com';
  static const _validPassword = 'admin123';

  /// Simulates login API call.
  Future<User> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));

    if (email == _validEmail && password == _validPassword) {
      return const User(
        id: '1',
        name: 'Ahmad Sobirin',
        email: 'ahmadsobirin@gmail.com',
        phoneNumber: '0895400976472',
      );
    }

    throw Exception(
      'Email atau password salah. (Gunakan admin@dkost.com / admin123)',
    );
  }

  /// Simulates logout.
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
