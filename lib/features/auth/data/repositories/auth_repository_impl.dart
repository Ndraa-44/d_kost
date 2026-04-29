import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';

/// Local implementation of [AuthRepository] using mock data.
class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource _dataSource;

  AuthRepositoryImpl({AuthLocalDataSource? dataSource})
      : _dataSource = dataSource ?? AuthLocalDataSource();

  @override
  Future<User> login(String email, String password) {
    return _dataSource.login(email, password);
  }

  @override
  Future<void> logout() {
    return _dataSource.logout();
  }
}
