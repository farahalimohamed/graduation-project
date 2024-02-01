import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grad_final_project/screens/home/home_screen.dart';
import '../../constants.dart';
import '../Login/login_screen.dart';
import '../chats/chats_screen.dart';
import '../chats/components/body_chat.dart';
import 'EditProfile.dart';
import 'changePassword.dart';
import 'profile.dart';
import 'package:http/http.dart' as http;

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextStyle headingStyle = const TextStyle(
      fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black);

  ///////////////added back///////////////////
  Future<void> LogOut() async {

    final response = await http.post(Uri.parse("$localhost/api/logout/"),
      body: jsonEncode({'uid': userId}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if(response.statusCode==200){
      userId = 0;
      profileId = 0;
      DoctorList.clearDoctorList();
      timer.cancel();
    }
  }

  Map<String, dynamic> profileData = {};

  Future<void> _fetchUserData() async {
    final response =
        await http.get(Uri.parse('$localhost/api/profile/$userId?format=json'));
    if (response.statusCode == 200) {
      profileData = jsonDecode(response.body);

      //final data =response.body.split(',');
      // setState(() {
      //   imageUrl = profileData['pic'];
      // });
    } else {
      throw Exception('Failed to load user profile');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD7DCE7),
      bottomNavigationBar: _Navbar3(),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD7DCE7),
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
          "Settings",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFFD7DCE7),
        child: SingleChildScrollView(
          child: Container(
            color: const Color(0xFFD7DCE7),
            padding: const EdgeInsets.all(12),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                ),
                userId != 0
                    ? Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ChangePasswordScreen()));
                            },
                            child: ListTile(
                              leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Container(
                                      color: const Color(0xFF00227B),
                                      height: 40,
                                      width: 40,
                                      child: const Icon(
                                        Icons.lock,
                                        color: Colors.white,
                                      ))),
                              title: const Text("Change Password"),
                              trailing: const Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                          const Divider(),
                        ],
                      )
                    : const SizedBox(),
                ListTile(
                  leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                          color: const Color(0xFF00227B),
                          height: 40,
                          width: 40,
                          child: const Icon(
                            Icons.notifications_rounded,
                            color: Colors.white,
                          ))),
                  title: const Text("Notifications"),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
                const Divider(),
                userId != 0
                    ? Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await _fetchUserData();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileEditPage(
                                    name: profileData['name'],
                                    bloodType: profileData['blood_type'],
                                    medCon: profileData['medical_condition'],
                                    weight: profileData['weight'],
                                    img: "$localhost"+profileData['pic']
                                  ),
                                ),
                              );
                            },
                            child: ListTile(
                              leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Container(
                                      color: const Color(0xFF00227B),
                                      height: 40,
                                      width: 40,
                                      child: const Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ))),
                              title: const Text("Edit profile"),
                              trailing: const Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                          const Divider(),
                        ],
                      )
                    : SizedBox(),
                userId != 0
                    ? Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              LogOut();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                              );
                            },
                            child: ListTile(
                              leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Container(
                                      color: const Color(0xFF00227B),
                                      height: 40,
                                      width: 40,
                                      child: const Icon(
                                        Icons.logout_rounded,
                                        color: Colors.white,
                                      ))),
                              title: const Text('Log Out'),
                              trailing: const Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                          const Divider(),
                        ],
                      )
                    : const SizedBox(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        "More options",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                const ListTile(
                  title: SizedBox(
                      child: Text(
                    "Languages",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  )),
                  trailing: Text(
                    "English",
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ),
                const Divider(),
              ], //children elcolumn
            ),
          ),
        ),
      ),
    );
  }

  Widget _Navbar3() {
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
            icon: const Icon(Icons.chat),
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
            icon: const Icon(Icons.settings),
            color: const Color(0xff566CA6),
            onPressed: () {
              setState(() {
                _selectedIndex = 2;
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
          ),
          IconButton(
            iconSize: 30.0,
            icon: const Icon(Icons.person),
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
