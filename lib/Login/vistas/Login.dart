import 'package:flutter/material.dart';
import 'package:log_in/Login/vistas/home.dart';
import 'package:otp/otp.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../auth.dart';
import 'number.dart';

class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController controllerUser;
  TextEditingController controllerPassword;
  final otp = OTP.generateTOTPCodeString(
      'JBSWY3DPEHPK3PXP', DateTime.now().millisecondsSinceEpoch);
  @override
  void initState() {
    super.initState();
    controllerPassword = new TextEditingController();
    controllerUser = new TextEditingController();
  }

  @override
  void dispose() {
    controllerPassword.dispose();
    controllerUser.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: size.height * 1,
        width: size.width * 1,
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Padding(
                  padding: const EdgeInsets.all(50),
                  child: CircleAvatar(
                    radius: 50,
                    child: IconButton(
                      iconSize: 80,
                      icon: const Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      onPressed: () => setState(() {
                        controllerPassword.clear();
                        controllerUser.clear();
                      }),
                    ),
                  ),
                ),
              ]),

              //User input
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(50, 10, 50, 5),
                child: TextField(
                    //maxLength: 20,
                    controller: controllerUser,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                        ),
                        labelText: 'User',
                        icon: Icon(Icons.person))),
              ),

              //Password input
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(50, 10, 50, 5),
                child: TextField(
                    maxLength: 8,
                    controller: controllerPassword,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                        ),
                        //hintText: "ss",
                        labelText: 'Password',
                        icon: Icon(Icons.lock))),
              ),

              //forgot the password
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(150, 0, 50, 5),
                child: TextButton(
                  onPressed: () => print("password" +
                      controllerPassword.text +
                      "Usuer" +
                      controllerUser.text),
                  child: const Text(
                    "Forgot the password? Click here",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),

              //Button Login
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(100, 10, 100, 10),
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
                        " Login",
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      )
                    ],
                  ),
                  onPressed: () {
                    bool t = false;
                    String msg = "Acceso no permitido";
                    Color color = Colors.red;
                    String usr = "";
                    /*Fluttertoast.showToast(
                        msg: msg,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: color,
                        textColor: Colors.white,
                        fontSize: 16.0);*/
                  },
                ),
              ),

              Divider(
                height: 11,
              ),

              //Button Register
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(50, 10, 50, 10),
                child: TextButton(
                  onPressed: () => print("Register"),
                  child: const Text(
                    "Sign up",
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                ),
              ),

              //divicion
              Divider(
                height: 1,
              ),

              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(50, 10, 50, 10),
                child: ElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        FontAwesomeIcons.google,
                        size: 30,
                        color: Colors.red,
                      ),
                      Text(
                        " Sign in with Google",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )
                    ],
                  ),
                  onPressed: () async {
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                      builder: (context) => HomeWidget(code: otp),
                    ))
                        .then((value) async {
                      if (value == true) {
                        await authService.googleSignIn();
                      }
                    });
                  },
                ),
              ),

              //divicion
              Divider(
                height: 5,
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
