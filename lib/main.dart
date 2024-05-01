import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/app_export.dart';
import 'firebase_options.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await Firebase.initializeApp(
  //     options: const FirebaseOptions(
  //   apiKey: "AIzaSyBhvBPDv5I73uObRrcK_mEz5zdcmvZEQg0",
  //   authDomain: "readio-mm.firebaseapp.com",
  //   projectId: "readio-mm",
  //   messagingSenderId: "547451365319",
  //   appId: "1:547451365319:web:116382adbee631073e9be2",
  // ));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  ThemeHelper().changeTheme('primary');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          theme: theme,
          title: 'akar_hassan_abdalqadir_x23ec3003_s_application3',
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.initialRoute,
          routes: AppRoutes.routes,
        );
      },
    );
  }
}
