import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

class ProfileController extends GetxController {
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  RxBool isHidden = false.obs;

  RxString lastLogin = "-".obs;
  RxBool isLoading = false.obs;

  SupabaseClient client = Supabase.instance.client;

  Future<void> logOut() async {
    client.auth.signOut();
  }

  Future<void> getProfile() async {
    var res = await client
        .from("users")
        .select("nama,email")
        .match({"uid": client.auth.currentUser!.id}).execute();

    Map<String, dynamic> data =
        (res.data as List).first as Map<String, dynamic>;
    nameC.text = data["nama"];
    emailC.text = data["email"];

    lastLogin.value = DateFormat.yMMMEd()
        .add_jms()
        .format(DateTime.parse(client.auth.currentUser!.lastSignInAt!));
  }

  Future<void> updateProfile() async {
    isLoading.value = true;
    if (nameC.text.isNotEmpty) {
      await client.from("users").update({
        "nama": nameC.text,
      }).match({"uid": client.auth.currentUser!.id}).execute();

      if (passC.text.isNotEmpty) {
        if (passC.text.length > 6) {
          try {
            print(passC.text);
            await client.auth.api.updateUser(
              client.auth.currentSession!.accessToken,
              UserAttributes(password: passC.text),
            );
          } catch (e) {
            Get.snackbar("Terjadi Kesalahan", "$e");
            print(e);
          }
        } else {
          Get.snackbar("Alert", "Password kurang dari 6 karakter");
        }
        isLoading.value = false;
      }
    }
  }
}
