import "package:flutter/material.dart";
import 'package:getx_app/model/user_modelx.dart';
import 'package:getx_app/pages/favoris/user_detail.dart';
import 'package:getx_app/widget/details.dart';
import 'package:getx_app/widget/photohero.dart';

class User extends StatelessWidget {
  final UserModel _user;

  User(this._user);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetail(_user))),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
        Expanded(child:PhotoHero(
          photo: _user.avatar,
          width: 400.0,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return Scaffold(
                    body: Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.topLeft,
                      child: ModelPage(),
                    ),
                  );
                }
            ));
          },
        )),
          ],
        ),
      ),
    );
  }
}