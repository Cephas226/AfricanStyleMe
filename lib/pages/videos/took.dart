import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getx_app/pages/videos/trending.dart';


class TokPage extends StatefulWidget {
  @override
  _TokPageState createState() => _TokPageState();
}

class _TokPageState extends State<TokPage> {
  int currentIndex = 0;
  PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: <Widget>[
          Center(
            child: Trending(),
          ),
        ],
        onPageChanged: (int index) {
          setState(
                () {
              currentIndex = index;
            },
          );
        },
      ),
    );
  }
}