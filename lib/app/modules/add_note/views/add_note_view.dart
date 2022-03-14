import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:supanote/app/modules/home/controllers/home_controller.dart';

import '../controllers/add_note_controller.dart';

class AddNoteView extends GetView<AddNoteController> {
  final homeC = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AddNoteView'),
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
                  bool? res = await controller.addNote();
                  if (res == true) {
                    homeC.getAllNotes();
                    Get.back();
                  }
                }
              },
              child: Obx(() => Text(
                  controller.isLoading.isFalse ? "Add Note" : "Loading...")))
        ],
      ),
    );
  }
}
