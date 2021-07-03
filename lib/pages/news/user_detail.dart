import "package:flutter/material.dart";
import 'package:getx_app/model/user_model.dart';

class UserDetail extends StatelessWidget {
  final UserModel _user;

  UserDetail(this._user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_user.name),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),
              child: Hero(
                tag: "avatar_" + _user.id.toString(),
                child: CircleAvatar(
                  radius: 100,
                  backgroundImage: NetworkImage(_user.avatar),
                ),
              ),
            ),
            Text(_user.name,
              style: TextStyle(
                  fontSize: 22
              ),
            ),
          ],
        ),
      ),
    );
  }
}

