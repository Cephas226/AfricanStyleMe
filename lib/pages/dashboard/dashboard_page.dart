import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/pages/account/account_page.dart';
import 'package:getx_app/pages/alerts/alerts_page.dart';
import 'package:getx_app/pages/home/home_page.dart';
import 'package:getx_app/model/user_model.dart';
import 'package:getx_app/pages/news/new_page.dart';

import '../../main.dart';
import 'dashboard_controller.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: controller.tabIndex,
              children: [
                HomePage(),
                CategoriesPage(),
                FavorisPage(),
                AccountPage(),
              ],
            ),
          ),
          drawer: MainDrawer(),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.black,
            selectedItemColor: Colors.indigoAccent,
            onTap: controller.changeTabIndex,
            currentIndex: controller.tabIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 0,
            items: [
              _bottomNavigationBarItem(
                icon: CupertinoIcons.home,
                label: 'Accueil',
              ),
              _bottomNavigationBarItem(
                icon: Icons.list,
                label: 'Catégories',
              ),
              _bottomNavigationBarItem(
                icon: CupertinoIcons.heart,
                label: 'Favoris',
              ),
              _bottomNavigationBarItem(
                icon: CupertinoIcons.person,
                label: 'Account',
              ),
            ],
          ),
        );
      },
    );
  }

  _bottomNavigationBarItem({IconData icon, String label}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
