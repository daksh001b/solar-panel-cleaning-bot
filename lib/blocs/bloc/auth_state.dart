abstract class AuthState {}

class AuthUnintializedState extends AuthState {}

class AuthAuthenticatedState extends AuthState {
  final String? uid;
  final String? email;
  final String? displayName;
  AuthAuthenticatedState({
    required this.uid,
    required this.email,
    required this.displayName,
  });
}

class AuthUnauthenticatedState extends AuthState {}

class AuthLoadingState extends AuthState {}
