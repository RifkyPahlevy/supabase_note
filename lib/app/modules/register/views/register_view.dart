import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RegisterView'),
        centerTitle: true,
      ),
      body: ListView(padding: EdgeInsets.all(20), children: [
        TextField(
          controller: controller.nameC,
          decoration: InputDecoration(
            labelText: 'Name',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20),
        TextField(
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
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () {
              if (controller.isLoading.isFalse) {
                controller.signUp();
              }
            },
            child: Obx(() => Text(
                controller.isLoading.isFalse ? "Register" : "Loading..."))),
      ]),
    );
  }
}
