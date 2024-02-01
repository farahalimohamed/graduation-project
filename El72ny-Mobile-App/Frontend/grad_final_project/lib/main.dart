import 'package:flutter/material.dart';
import 'package:grad_final_project/screens/settings/EditProfile.dart';
import 'package:grad_final_project/screens/splash/splash.dart';
import 'constants.dart';

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
        title: 'El72ny',
        theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          primaryColor: kPrimaryColor,
          textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Color(0xFFD7DCE7)
          ),
        ),
        home: Splash(),
        // home: ProfileEditPage(),
      ),

    );
  }
}
