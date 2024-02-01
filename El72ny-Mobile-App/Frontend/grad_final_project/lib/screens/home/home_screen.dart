import 'package:flutter/material.dart';
import '../../components/bottom_nav_bar.dart';
import '../../constants.dart';
import '../Login/login_screen.dart';
import '../Search/search.dart';
import '../chats/chats_screen.dart';
import '../settings/profile.dart';
import '../settings/setting_page.dart';
import 'components/body.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: Body(),
      bottomNavigationBar: _Navbar1(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Color(0x33D9D9D9),
      elevation: 0.0,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRect(
              child:
              Image.asset(
                'assets/img/logo_light_blue.png',
                width: 85.0,
                height: 85.0,
                fit: BoxFit.fitWidth,
              ),
            ),
            Spacer(),
            IconButton(
              // icon: const Icon(
              //   Icons.search,
              //   size: 35,
              //   color: Colors.black,
              // ),
              icon: Image.asset("assets/icons/Search.png"),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchPage(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _Navbar1(){
    int _selectedIndex = 0;
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
            iconSize: 35.0,
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
            iconSize: 30.0,
            icon: Icon(Icons.chat),
            color: Colors.grey.withOpacity(0.7),
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
            iconSize: 30.0,
            icon: Icon(Icons.settings),
            color: Colors.grey.withOpacity(0.7),
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
            iconSize: 30.0,
            icon: Icon(Icons.person),
            color: Colors.grey.withOpacity(0.7),
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
