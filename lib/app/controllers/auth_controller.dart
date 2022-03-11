import 'dart:async';

import 'package:get/get.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supanote/app/routes/app_pages.dart';

class AuthController extends GetxController {
  SupabaseClient client = Supabase.instance.client;
  Timer? authTimer;

  Future<void> autoLogout() async {
    if (authTimer != null) {
      authTimer!.cancel();
    } else {
      authTimer = Timer(Duration(seconds: 10), () async {
        await client.auth.signOut();
        Get.offAllNamed(Routes.LOGIN);
        print("Auto Logout Dijalankan");
      });
    }
  }

  Future<void> reset() async {
    if (authTimer != null) {
      authTimer!.cancel();
      authTimer = null;
    }
  }
}
