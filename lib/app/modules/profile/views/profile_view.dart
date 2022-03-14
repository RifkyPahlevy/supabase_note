import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:supanote/app/controllers/auth_controller.dart';
import 'package:supanote/app/routes/app_pages.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ProfileView'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                await controller.logOut();
                await authC.reset();
                Get.offAllNamed(Routes.LOGIN);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: FutureBuilder(
        future: controller.getProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(padding: EdgeInsets.all(20), children: [
            TextField(
              controller: controller.nameC,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              readOnly: true,
              controller: controller.emailC,
              decoration: InputDecoration(
                labelText: 'Email',
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
            Text("Last Login"),
            SizedBox(
              height: 7,
            ),
            Obx(() => Text("${controller.lastLogin}")),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (controller.isLoading.isFalse) {
                    await controller.updateProfile();

                    if (controller.passC.text.isNotEmpty) {
                      await controller.logOut();
                      authC.reset();
                      Get.offAllNamed(Routes.LOGIN);
                    }
                  }
                },
                child: Obx(() => Text(controller.isLoading.isFalse
                    ? "Update Profile"
                    : "Loading..."))),
          ]);
        },
      ),
    );
  }
}
