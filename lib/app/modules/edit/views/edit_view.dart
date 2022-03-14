import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:supanote/app/modules/home/controllers/home_controller.dart';

import '../../../data/models/notes_model.dart';
import '../controllers/edit_controller.dart';

class EditView extends GetView<EditController> {
  Notes note = Get.arguments;
  final homeC = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    controller.titleC.text = note.title!;
    controller.descC.text = note.desc!;
    return Scaffold(
      appBar: AppBar(
        title: Text('EditView'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: controller.titleC,
            autocorrect: false,
            decoration: InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: controller.descC,
            autocorrect: false,
            decoration: InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                if (controller.isLoading.isFalse) {
                  bool? res = await controller.editNote(note.id!);
                  if (res == true) {
                    homeC.getAllNotes();
                    Get.back();
                  }
                }
              },
              child: Obx(() => Text(
                  controller.isLoading.isFalse ? "Edit Note" : "Loading...")))
        ],
      ),
    );
  }
}
