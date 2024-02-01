
import 'package:flutter/material.dart';

import 'Login/login_screen.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'El72nyyy-Ambulance',
        // home: Notfound_Screen(),
        home: MobileLoginScreen(),
        // home: show(),
      ),
    );
  }
}
