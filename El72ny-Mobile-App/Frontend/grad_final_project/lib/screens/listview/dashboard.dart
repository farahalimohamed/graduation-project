import 'package:flutter/material.dart';

import '../../constants.dart';
import '../Login/login_screen.dart';
import '../chats/chats_screen.dart';
import '../doctor/instructions.dart';
import '../home/home_screen.dart';
import '../settings/profile.dart';
import '../settings/setting_page.dart';

class DashPage extends StatefulWidget {
  const DashPage({Key? key}) : super(key: key);

  @override
  State<DashPage> createState() => _DashPageState();
}

class _DashPageState extends State<DashPage> {
  TextStyle headingStyle = const TextStyle(
      fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    List firstaid = [
      {'iconPath': 'assets/images/heartbeat.png'},
      {'iconPath': 'assets/images/swallowed.png'},
      {'iconPath': 'assets/images/burns.png'},
      {'iconPath': 'assets/images/burns.png'},
      {'iconPath': 'assets/images/allergic shock.png'},
      {'iconPath': 'assets/images/asthma.png'},
      {'iconPath': 'assets/images/stings.png'},
      {'iconPath': 'assets/images/bleeding.png'},
      {'iconPath': 'assets/images/hypoglycemia.png'},
      {'iconPath': 'assets/images/shock.png'},


    ];
    List name = [
      {'name': 'Heart Attack', 'instidd': 1},
      {'name': 'Choking', 'instidd': 5},
      {'name': 'Minor burns', 'instidd': 23},
      {'name': 'Major burns', 'instidd': 19},
      {'name': 'Allergies', 'instidd': 26},
      {'name': 'Asthma', 'instidd': 31},
      {'name': 'Bites and Stings', 'instidd': 35},
      {'name': 'Nosebleed', 'instidd': 38},
      {'name': 'Severebleed', 'instidd': 42},
      {'name': 'Shock', 'instidd': 46},

    ];

    return Scaffold(
      backgroundColor: Color(0xFFD7DCE7),
      bottomNavigationBar: _Navbar1(),
      appBar: AppBar(
        backgroundColor: Color(0xFFD7DCE7),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          ),
        ),
        elevation: 0,
        title: const Text(
          "First-aid",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 12),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: firstaid.length,
            itemBuilder: (context, index) {
              return Column(children: [
                Container(
                  margin:
                  EdgeInsets.only(bottom: 13, top: 0, left: 15, right: 15),
                  child: SizedBox(
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              InstPage(instId: name[index]['instidd'], widtyp: 1,),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF667AB0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        shadowColor: Colors.blueAccent,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(25),
                                child: Image.asset(
                                  firstaid[index]['iconPath'],
                                  height: 5,
                                  width: 5,
                                ),
                              ),
                            ),
                            SizedBox(width: 6),
                            Text(
                              name[index]['name'],
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ]);
            }),
      ),
    );
  }

  Widget _Navbar1() {
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
            color: Colors.grey.withOpacity(0.7),
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
                      widid: 2,
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
