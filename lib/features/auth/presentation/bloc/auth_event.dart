import 'package:equatable/equatable.dart';

/// Base class for all authentication events.
sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Triggered when the user submits login credentials.
class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

/// Triggered when the user requests to log out.
class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}
