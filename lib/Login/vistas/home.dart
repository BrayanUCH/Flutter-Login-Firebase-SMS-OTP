import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      body: Center(

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.login_sharp,
                  size: 30,
                  color: Colors.black,
                ),
                Text(
                  "Cerrar Sesión ${authService.user.displayName}",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                )
              ],
            ),
            onPressed: () {
              authService.signOut();
            },
          ),
        ),
      ),
    );
  }
}