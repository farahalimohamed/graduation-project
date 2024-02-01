import 'package:flutter/material.dart';
import 'package:grad_final_project/screens/Login/login_screen.dart';
import '../constants.dart';
import '../screens/chats/chats_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/settings/profile.dart';
import '../screens/settings/setting_page.dart';

class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.only(
        left: kDefaultPadding * 2,
        right: kDefaultPadding * 2,
        bottom: kDefaultPadding,
      ),
      height: 80,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(26),
          topRight: Radius.circular(26),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -10),
            blurRadius: 35,
            color: Colors.black.withOpacity(0.38),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
            color: _selectedIndex == 0
                ? Color(0xff566CA6)
                : Colors.grey.withOpacity(0.7),
            onPressed: () {
              setState(() {
                _selectedIndex = 0;
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.chat),
            color: _selectedIndex == 1
                ? Color(0xff566CA6)
                : Colors.grey.withOpacity(0.7),
            onPressed: () {
              setState(() {
                _selectedIndex = 1;
              });
              if (userId == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MobileLoginScreen(
                      widid: 2,
                    ),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChatsScreen(),
                  ),
                );
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            color: _selectedIndex == 2
                ? Color(0xff566CA6)
                : Colors.grey.withOpacity(0.7),
            onPressed: () {
              setState(() {
                _selectedIndex = 2;
              });

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            color: _selectedIndex == 3
                ? Color(0xff566CA6)
                : Colors.grey.withOpacity(0.7),
            onPressed: () {
              setState(() {
                _selectedIndex = 3;
              });
              if (userId == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MobileLoginScreen(
                      widid: 3,
                    ),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
