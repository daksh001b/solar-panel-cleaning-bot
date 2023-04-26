import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_panel_cleaning_bot/Pages/bot_list.dart';
import 'package:solar_panel_cleaning_bot/blocs/bloc/auth.dart';
import 'package:solar_panel_cleaning_bot/elements/loading.dart';
import 'Pages/login_page.dart';
import 'firebase_options.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('${bloc.runtimeType} $error $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}

void main() async {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  WidgetsFlutterBinding.ensureInitialized();
  runApp(BlocProvider(
    create: (context) => AuthBloc()..add(AppStartEvent()),
    child: Home(),
  ));
}

class Home extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solar Panel Cleaning Bot',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticatedState) {
            return BotList();
          }
          if (state is AuthUnauthenticatedState) {
            return Login();
          }
          if (state is AuthLoadingState) {
            return Scaffold(body: Loading());
          }
          return Scaffold(body: Loading());
        },
      ),
      // home: StreamBuilder<User?>(
      //     stream: FirebaseAuth.instance.authStateChanges(),
      //     builder: (BuildContext context, AsyncSnapshot snapshot) {
      //       if (snapshot.hasError) {
      //         return Text(snapshot.error.toString());
      //       }
      //       if (snapshot.connectionState == ConnectionState.active) {
      //         if (snapshot.data == null) {
      //           return Login();
      //         } else {
      //           return BotList();
      //           //return BotStatus();
      //         }
      //       }
      //       return Center(child: CircularProgressIndicator());
      //     }
      //     //}
      //     ),
      // routes: {
      //   //'/': (context) => BotStatus(),
      //   '/': (context) => Login(),
      // },
    );
  }
}
