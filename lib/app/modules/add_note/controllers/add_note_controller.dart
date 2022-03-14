import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddNoteController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController titleC = TextEditingController();
  TextEditingController descC = TextEditingController();

  SupabaseClient client = Supabase.instance.client;
  Future<bool?> addNote() async {
    if (titleC.text.isNotEmpty && descC.text.isNotEmpty) {
      isLoading.value = true;
      PostgrestResponse<dynamic> res =
          await client.from("users").select("id").match({
        "uid": client.auth.currentUser!.id,
      }).execute();

      int id = (res.data as List).first["id"];

      await client.from("notes").insert({
        "title": titleC.text,
        "desc": descC.text,
        "created_at": DateTime.now().toIso8601String(),
        "user_id": id
      }).execute();
      isLoading.value = false;
      return true;
    }
    return null;
  }
}
