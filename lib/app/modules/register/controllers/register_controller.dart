import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supanote/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  RxBool isHidden = false.obs;
  RxBool isLoading = false.obs;
  SupabaseClient client = Supabase.instance.client;

  void signUp() async {
    if (nameC.text.isNotEmpty &&
        passC.text.isNotEmpty &&
        emailC.text.isNotEmpty) {
      isLoading.value = true;
      GotrueSessionResponse res =
          await client.auth.signUp(emailC.text, passC.text);
      isLoading.value = false;
      if (res.error == null) {
        print(res.data);
        print(res.user);
        print(res.rawData);

        //insert ke table user
        await client.from("users").insert({
          "nama": nameC.text,
          "email": emailC.text,
          "uid": res.user!.id,
          "created_at": DateTime.now().toIso8601String(),
        }).execute();

        Get.offAllNamed(Routes.HOME);

        //menggunakan fitur email verifikasi
        // Get.defaultDialog(
        //     title: "Verifikasi Email",
        //     middleText: "Silahkan verifikasi email anda",
        //     actions: [
        //       TextButton(
        //           onPressed: () {
        //             Get.back();
        //             Get.back();
        //           },
        //           child: Text("OK")),
        //     ]);
      } else {
        Get.snackbar("Register", res.error!.message);
      }
    } else {
      Get.snackbar("Terjadi Kesalahan", "Email atau Password belum diisi !");
    }
  }
}
