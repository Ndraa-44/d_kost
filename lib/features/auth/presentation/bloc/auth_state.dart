import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';

/// Base class for all authentication states.
sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Initial state — user has not attempted login.
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Login is in progress.
class AuthLoading extends AuthState {
  const AuthLoading();
}

/// User is authenticated successfully.
class AuthAuthenticated extends AuthState {
  final User user;

  const AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

/// Authentication failed with an error message.
class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
