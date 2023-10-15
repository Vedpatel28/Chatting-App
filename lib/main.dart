import 'package:chat_app_firebase/controller/first_time_login_controller.dart';
import 'package:chat_app_firebase/controller/profile_controller.dart';
import 'package:chat_app_firebase/controller/setting_controller.dart';
import 'package:chat_app_firebase/views/screens/add_contact_page.dart';
import 'package:chat_app_firebase/views/screens/chat_page.dart';
import 'package:chat_app_firebase/views/screens/home_page.dart';
import 'package:chat_app_firebase/views/screens/login_page.dart';
import 'package:chat_app_firebase/views/screens/profile_page.dart';
import 'package:chat_app_firebase/views/screens/sign_in_page.dart';
import 'package:chat_app_firebase/views/screens/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FirstTimeCheck firstTimeCheck = Get.put(FirstTimeCheck());

    ProfileController profileController = Get.put(ProfileController());
    final settingController controller = Get.put(settingController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: controller.models.theme.value
            ? Brightness.light
            : Brightness.dark,
      ),
      getPages: [
        GetPage(
          name: "/",
          page: () => firstTimeCheck.isOne ? LoginPage() : SplashPage(),
        ),
        GetPage(
          name: "/HomePage",
          page: () => HomePage(),
        ),
        GetPage(
          name: "/LoginPage",
          page: () => LoginPage(),
        ),
        GetPage(
          name: "/SignInPage",
          page: () => SignInPage(),
        ),
        GetPage(
          name: "/ChatPage",
          page: () => ChatPage(),
        ),
        GetPage(
          name: "/AddContacts",
          page: () => AddContactsPage(),
        ),
        GetPage(
          name: "/ProfilePage",
          page: () => ProfilePage(),
        ),
      ],
    );
  }
}
