import 'package:bloc/bloc.dart';
import 'package:solar_panel_cleaning_bot/functionality/auth.dart';

import 'auth.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthUnintializedState()) {
    AuthService authService = AuthService();
    on<AppStartEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        final displayName = await authService.getDisplayName();
        final email = await authService.getEmail();
        final uId = await authService.getUserId();
        if (displayName != null && email != null && uId != null) {
          emit(AuthAuthenticatedState(
            email: email,
            displayName: displayName,
            uid: uId,
          ));
        } else {
          emit(AuthUnauthenticatedState());
        }
      } catch (e) {
        emit(AuthUnauthenticatedState());
      }
    });

    on<AuthGoogleLoginEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        Map<String, String> userDetails = await authService.googleSignIn();
        print(userDetails['displayName']);
        await authService.saveDisplayName(userDetails["displayName"]);
        await authService.saveEmail(userDetails["email"]);
        await authService.saveUserId(userDetails["uid"]);
        emit(
          AuthAuthenticatedState(
            uid: userDetails["uid"],
            displayName: userDetails["displayName"],
            email: userDetails["email"],
          ),
        );
      } catch (e) {
        print("-----------------error---------------------");
        print(e);
        emit(AuthUnauthenticatedState());
      }
    });

    on<AuthGoogleLogoutEvent>((event, emit) async {
      emit(AuthLoadingState());
      await authService.signOut();
      await authService.deleteSecureStorage();
      emit(AuthUnauthenticatedState());
    });
  }
}
