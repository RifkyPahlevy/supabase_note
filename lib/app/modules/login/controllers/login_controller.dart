import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supanote/app/routes/app_pages.dart';

class LoginController extends GetxController {
  TextEditingController nameC = TextEditingController();
  TextEditingController passC = TextEditingController();
  RxBool isHidden = true.obs;
  RxBool isLoading = false.obs;

  SupabaseClient client = Supabase.instance.client;

  Future<bool?> login() async {
    if (nameC.text.isNotEmpty && passC.text.isNotEmpty) {
      print("Login dijalankan");
      isLoading.value = true;
      GotrueSessionResponse res =
          await client.auth.signIn(email: nameC.text, password: passC.text);
      isLoading.value = false;

      if (res.error == null) {
        return true;
      } else {
        print("Login error");
        Get.snackbar("Error", res.error!.message);
      }
    }
    return null;
  }
}
