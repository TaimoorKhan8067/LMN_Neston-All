import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lmn_neston/screens/HomePage.dart';
import 'package:lmn_neston/screens/LoginPage%20.dart';
import 'package:lmn_neston/screens/MainScreen.dart';
import 'package:lmn_neston/screens/SignUp.dart';

import 'database/user_local_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await UserLocalData.init();
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: true,
        home: (UserLocalData.getUserUID == '')
            ? const SignUpPage()
            : const MainScreen(),
        routes: <String, WidgetBuilder>{
          LoginPage.routeName: (_) => const LoginPage(),
          HomePage.routeName: (_) => const HomePage(),
          SignUpPage.routeName: (_) => const SignUpPage(),
          MainScreen.routeName: (_) => const MainScreen(),
        },
      ),
    );
  }
}
