import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeController extends GetxController {
  SupabaseClient client = Supabase.instance.client;
  Future<void> logOut() async {
    client.auth.signOut();
  }
}
