import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:supanote/app/controllers/auth_controller.dart';

import 'package:supanote/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LoginView'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: controller.nameC,
            decoration: InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Obx(() => TextField(
                controller: controller.passC,
                obscureText: controller.isHidden.value,
                decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                    suffix: IconButton(
                      onPressed: () => controller.isHidden.toggle(),
                      icon: Icon(Icons.remove_red_eye_outlined),
                    )),
              )),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                if (controller.isLoading.isFalse) {
                  bool? cek = await controller.login();
                  if (cek != null && cek == true) {
                    authC.autoLogout();
                    Get.offAllNamed(Routes.HOME);
                  }
                }
              },
              child: Obx(() => controller.isLoading.isFalse
                  ? Text("Login")
                  : CircularProgressIndicator())),
          SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () {
                Get.toNamed(Routes.REGISTER);
              },
              child: Text("Register")),
        ],
      ),
    );
  }
}
