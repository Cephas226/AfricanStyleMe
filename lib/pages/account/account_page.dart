import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/pages/account/account_controller.dart';

void main() {
  runApp(GetMaterialApp(
    navigatorKey: Get.key,
    initialRoute: '/home',
    getPages: [
      GetPage(
        name: '/home',
        page: () => AccountPage(),
        binding: HomeBinding(),
      ),
      GetPage(
        name: '/page1',
        page: () => Page1(),
        binding: Page1Binding(),
      ),
      GetPage(
        name: '/page2',
        page: () => Page2(),
        binding: Page2Binding(),
      ),
    ],
  ));
}

class MainDrawr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
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
          ),
        ],
      ),
    );
  }
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController(), permanent: true);
  }
}

class AccountPage extends GetView<AccountController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("APP DRAWER")),
      body: Center(
        child: Text('Home'),
      ),
      drawer: MainDrawr(),
    );
  }
}

class HomeController extends GetxController {
  @override
  void onInit() {
    print('>>> HomeController init');
    super.onInit();
  }

  @override
  void onReady() {
    print('>>> HomeController ready');
    super.onReady();
  }
}

class Page1Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Page1Controller());
  }
}

class Page1 extends GetView<Page1Controller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page 1')),
      drawer: MainDrawr(),
      body: Center(
        child: Text(controller.title),
      ),
    );
  }
}

class Page1Controller extends GetxController {
  final title = 'Page 1';

  @override
  void onInit() {
    print('>>> Page1Controller init');
    super.onInit();
  }

  @override
  void onReady() {
    print('>>> Page1Controller ready');
    super.onReady();
  }

  @override
  void onClose() {
    print('>>> Page1Controller close');
    super.onClose();
  }
}

class Page2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Page2Controller());
  }
}

class Page2 extends GetView<Page2Controller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page 2')),
      drawer: MainDrawr(),
      body: Center(
        child: Text(controller.title),
      ),
    );
  }
}

class Page2Controller extends GetxController {
  final title = 'Page 2';

  @override
  void onInit() {
    print('>>> Page2Controller init');
    super.onInit();
  }

  @override
  void onReady() {
    print('>>> Page2Controller ready');
    super.onReady();
  }

  @override
  void onClose() {
    print('>>> Page2Controller close');
    super.onClose();
  }
}