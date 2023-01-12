import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:way_to_fit/src/presentation/screens/auth_screen.dart';

import 'firebase_options.dart';
import 'src/injector.dart';
import 'src/presentation/screens/main_screen.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDependencies();

  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Widget home;

    return FutureBuilder(
        future: Future.value(FirebaseAuth.instance.currentUser),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            User user = snapshot.data;
            home = const MainScreen();
          } else {
            home = const AuthScreen();
          }

          return MaterialApp(
            home: home,
            theme: ThemeData(
                // colorSchemeSeed: const Color(0xFF000000),
                // colorSchemeSeed: Colors.black,
                // primarySwatch: primaryBlack,
                useMaterial3: true,
                splashFactory: NoSplash.splashFactory),
            darkTheme: ThemeData.dark(),
            builder: EasyLoading.init(),
          );
        });
  }
}
