import 'package:flutter/material.dart';
import 'package:log_in/Login/vistas/number.dart';
import 'package:otp/otp.dart';
import 'package:provider/provider.dart';

import 'Login/auth.dart';
import 'Login/vistas/Login.dart';
import 'Login/vistas/home.dart';
import 'Login/vistas/otp.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}


class _AppState extends State<App> {
 final otp = OTP.generateTOTPCodeString(
      'JBSWY3DPEHPK3PXP', DateTime.now().millisecondsSinceEpoch);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthService.instance(),
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          // Rutas
        },
        debugShowCheckedModeBanner: false,
        title: 'Firebase Auth con Provider',
        home: Consumer(
          builder: (context, AuthService authService, _) {
            switch (authService.status) {
              case AuthStatus.Uninitialized:
                return Text('Cargando');
              case AuthStatus.Authenticated:
                return Home();
              case AuthStatus.Authenticating:
                return SignIn();
              case AuthStatus.Unauthenticated:
                return SignIn();
            }
            return null;
          },
        )
      ),
    );
  }
}

