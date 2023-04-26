abstract class AuthEvent {}

class AppStartEvent extends AuthEvent {}

class AuthGoogleLoginEvent extends AuthEvent {}

class AuthGoogleLogoutEvent extends AuthEvent {}
