import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/pages/account/account_controller.dart';
import 'package:getx_app/widget/orientation/portrait_player_widget.dart';


class AccountPage extends GetView<AccountController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : buildPortrait(),
    );
  }

  Widget buildPortrait() => PortraitPlayerWidget();

  /*Widget buildButton({
    @required String text,
    @required VoidCallback onClicked,
  }) =>
      Center(
        child: TextButton(
          child: Text(
            text,
            style: TextStyle(fontSize: 24),
          ),
          onPressed: onClicked,
        ),
      );

  void goToLandscape(BuildContext context) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => LandscapePlayerPage()));*/
}