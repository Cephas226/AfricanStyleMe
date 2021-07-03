import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/widget/oval-right-clipper.dart';

import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'themes/app_theme.dart';

final Color active = Colors.black;
final Color primary =Colors.white;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppRoutes.DASHBOARD,
      getPages: AppPages.list,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
    );
  }
}
class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildDrawer();
  }
}

_buildDrawer() {

  final String image = "https://firebasestorage.googleapis.com/v0/b/yasms-efe24.appspot.com/o/11.jpg?alt=media&token=ddc4fb15-001d-402f-bcb8-7e8fa09643d0";
  return ClipPath(
    clipper: OvalRightBorderClipper(),
    child: Drawer(
      child: Container(
        padding: const EdgeInsets.only(left: 16.0, right: 40),
        decoration: BoxDecoration(
            color: primary, boxShadow: [BoxShadow(color: Colors.black45)]),
        width: 300,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.power_settings_new,
                      color: active,
                    ),
                    onPressed: () {},
                  ),
                ),
                Container(
                  height: 90,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          colors: [Colors.pink, Colors.deepPurple])),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(image),
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  "Cephas ZOUBGA",
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
                Text(
                  "@cephaszoubga",
                  style: TextStyle(color: active, fontSize: 16.0),
                ),
                SizedBox(height: 30.0),
                _buildRow(Icons.home, "Accueil"),
                _buildDivider(),
                _buildRow(Icons.bookmark, "Mes favoris"),
                _buildDivider(),
                _buildRow(Icons.email, "Nous contacter"),
                _buildDivider(),
                _buildRow(Icons.info_outline, "Aide"),
                _buildDivider(),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Divider _buildDivider() {
  return Divider(
    color: active,
  );
}

Widget _buildRow(IconData icon, String title) {
  final TextStyle tStyle = TextStyle(color: active, fontSize: 16.0);
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(children: [
      Icon(
        icon,
        color: active,
      ),
      SizedBox(width: 10.0),
      Text(
        title,
        style: tStyle,
      ),
    ]),
  );
}

/*DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Home'),
            tileColor: Get.currentRoute == '/home' ? Colors.grey[300] : null,
            onTap: () {
              print(Get.currentRoute);
              Get.back();
              Get.offNamed('/home');
            },
          ),
          ListTile(
            title: Text('Item 1'),
            tileColor: Get.currentRoute == '/page1' ? Colors.grey[300] : null,
            onTap: () {
              Get.back();
              Get.offNamed('/page1');
            },
          ),
          ListTile(
            title: Text('Item 2'),
            tileColor: Get.currentRoute == '/page2' ? Colors.grey[300] : null,
            onTap: () {
              Get.back();
              Get.offNamed('/page2');
            },
          ),*/