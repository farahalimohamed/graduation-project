import 'package:flutter/material.dart';

import 'chats/chats_screen.dart';
import 'home/home_screen.dart';
import 'settings/profile.dart';
import 'settings/setting_page.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  int _selectedIndex = 0;

  // AppBar? getAppBarIfIsNecessary() {
  //   if (_selectedIndex == 0) {
  //     return null;
  //     //   (
  //     //   // backgroundColor: Color(0xffb2b8016),
  //     //   // automaticallyImplyLeading: false,
  //     //   // title: Text("Chats"),
  //     // );
  //   }
  //
  //   return null;
  // }

    @override
  Widget build(BuildContext context) {
    List screens =[
      HomeScreen(),
      ChatsScreen(),
      SettingsPage(),
      ProfilePage(),
    ];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        child: Scaffold(
          resizeToAvoidBottomInset: false,

          // appBar: getAppBarIfIsNecessary(),

          body: screens[_selectedIndex],

          // floatingActionButton: getFloatingButtonIfIsNecessary(),

          bottomNavigationBar: BottomNavigationBar
            (
            backgroundColor: Colors.white,
            selectedItemColor: Color(0xff00227B),
            unselectedItemColor: Colors.grey.shade600,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
            selectedFontSize: 14,
            unselectedFontSize: 14,
            type: BottomNavigationBarType.fixed,
            items:
            [
              BottomNavigationBarItem
                (
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem
                (
                icon: Icon(Icons.message_rounded),
                label: "Chats",
              ),
              BottomNavigationBarItem
                (
                icon: Icon(Icons.settings),
                label: "Settings",
              ),
              BottomNavigationBarItem
                (
                icon: Icon(Icons.person,),
                label: "Profile",
              ),
            ],

            currentIndex: _selectedIndex,
            onTap: (index)
            {
              setState(()
              {
                _selectedIndex=index;
              });
            },
          ),
        ),
      ),
    );
  }
}
