import 'package:flutter/material.dart';
import 'package:servme_login_app/screen/authentication/sign_in.dart';
import 'package:servme_login_app/screen/home/home.dart';
import 'package:servme_login_app/screen/wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => Wrapper(),
        '/signIn': (context) => SignIn(),
        '/home': (context) => Home(null),
      }
    );
  }
}
