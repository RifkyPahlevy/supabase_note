import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:supanote/app/routes/app_pages.dart';

import '../../../controllers/auth_controller.dart';
import '../../../data/models/notes_model.dart';
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
          // IconButton(
          //     onPressed: () async {
          //       await controller.logOut();
          //       await authC.reset();
          //       Get.offAllNamed(Routes.LOGIN);
          //     },
          //     icon: Icon(Icons.exit_to_app_outlined))

          IconButton(
              onPressed: () => Get.toNamed(Routes.PROFILE),
              icon: Icon(Icons.person))
        ],
      ),
      body: FutureBuilder(
          future: controller.getAllNotes(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Obx(() => controller.allNotes.length == 0
                ? Center(
                    child: Text("Tidak ada data brouu"),
                  )
                : ListView.builder(
                    itemCount: controller.allNotes.length,
                    itemBuilder: (context, index) {
                      Notes note = controller.allNotes[index];
                      return ListTile(
                        onTap: () => Get.toNamed(Routes.EDIT, arguments: note),
                        title: Text("${note.title}"),
                        subtitle: Text('${note.desc}'),
                        leading: CircleAvatar(
                          child: Text('${note.id}'),
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              controller.deleteNote(note.id!);
                            },
                            icon: Icon(Icons.delete)),
                      );
                    },
                  ));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.ADD_NOTE),
        child: Icon(Icons.add),
      ),
    );
  }
}
