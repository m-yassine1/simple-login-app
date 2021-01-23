import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:servme_login_app/model/user.dart';
import 'package:servme_login_app/repository/database.dart';
import 'package:servme_login_app/screen/authentication/sign_in.dart';
import 'package:servme_login_app/screen/home/home.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool isLoading = true;
  bool isAuthenticated = false;
  User user;
  AuthDatabase _authDatabase = AuthDatabase();

  @override
  Widget build(BuildContext context) {
    return isLoading ? getLoader() : (isAuthenticated ? Home(user.access_token) : SignIn());
  }

  Future getUser() async {
    UserEntity userEntity = (await _authDatabase.getUser());
    setState(() {
      isLoading = false;
      isAuthenticated = userEntity != null;
      if(isAuthenticated) {
        user = userEntity.toUser();
      }
    });
  }

  Widget getLoader() {
    getUser();
    return Container(
      color: Colors.green[100],
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.green,
          size: 50.0,
        ),
      ),
    );
  }
}
