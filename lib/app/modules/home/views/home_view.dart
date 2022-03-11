import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:supanote/app/routes/app_pages.dart';

import '../../../controllers/auth_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                await controller.logOut();
                await authC.reset();
                Get.offAllNamed(Routes.LOGIN);
              },
              icon: Icon(Icons.exit_to_app_outlined))
        ],
      ),
      body: Center(
        child: Text(
          'HomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
