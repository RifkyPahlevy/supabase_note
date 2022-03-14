import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supanote/app/data/models/notes_model.dart';

class HomeController extends GetxController {
  RxList allNotes = List<Notes>.empty().obs;
  SupabaseClient client = Supabase.instance.client;
  Future<void> getAllNotes() async {
    PostgrestResponse<dynamic> res = await client
        .from("users")
        .select("id")
        .match({"uid": client.auth.currentUser!.id}).execute();

    int id = (res.data as List).first["id"];

    PostgrestResponse<dynamic> notes =
        await client.from("notes").select().match({
      "user_id": id,
    }).execute();

    var dataNotes = Notes.fromJsonList((notes.data as List));

    allNotes(dataNotes);
    allNotes.refresh();
  }

  Future<void> deleteNote(int id) async {
    await client.from("notes").delete().match({
      "id": id,
    }).execute();
    getAllNotes();
  }
}
