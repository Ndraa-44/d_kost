import 'package:equatable/equatable.dart';

/// Represents an authenticated user in the application.
///
/// This is a domain entity — it should contain only data fields
/// and remain independent from any framework or data source.
class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [id, name, email, phoneNumber];
}
