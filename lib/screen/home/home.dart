import 'package:flutter/material.dart';
import 'package:servme_login_app/screen/service/auth.dart';
import 'package:servme_login_app/shared/loading.dart';

class Home extends StatefulWidget {
  String access_token;

  Home(String access_token, {Key key}) : super(key: key) {
    this.access_token = access_token;
  }

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  bool loading = false;

  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;

    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('Welcome '),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: [
          FlatButton.icon(
              label: Text('logout'),
              icon: Icon(Icons.person),
              onPressed: () async {
                setState(() {
                  loading = true;
                });
                String accessToken = await _auth.signOut(widget.access_token == null ? data['accessToken'] : widget.access_token);
                if(accessToken == null) {
                  setState(() {
                    loading = false;
                  });
                } else {
                  Navigator.pushReplacementNamed(context, '/');
                }
              }),
        ],
      ),
    );
  }
}
