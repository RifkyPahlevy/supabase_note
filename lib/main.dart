import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';

import 'app/controllers/auth_controller.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Supabase supabase = await Supabase.initialize(
      url: "https://jgpyhhjygrhfspdioyaq.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpncHloaGp5Z3JoZnNwZGlveWFxIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NDY5MDI5OTcsImV4cCI6MTk2MjQ3ODk5N30.cEMpZAoe4fqDKN4HQGqS0iWlHrrpu04Ra3POJS8JEO4");
  print(supabase.client.auth.session());

  Get.put(AuthController(), permanent: true);
  runApp(
    GetMaterialApp(
      title: "SupaNote",
      initialRoute:
          supabase.client.auth.currentUser == null ? Routes.LOGIN : Routes.HOME,
      getPages: AppPages.routes,
    ),
  );
}
