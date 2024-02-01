import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grad_final_project/screens/settings/EditProfile.dart';

import 'package:http/http.dart' as http;

import '../../constants.dart';
import '../Login/login_screen.dart';
import '../chats/chats_screen.dart';
import '../home/home_screen.dart';
import 'setting_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //#TO get data from jsonfile
  Map<String, dynamic> profileData = {};
  String? imageUrl;

  Future<void> _fetchUserData() async {
    final response = await http
        .get(Uri.parse('${localhost}/api/profile/$userId?format=json'));
    if (response.statusCode == 200) {
      profileData = jsonDecode(response.body);

      //final data =response.body.split(',');
      setState(() {
        imageUrl = profileData['pic'];
      });
    } else {
      throw Exception('Failed to load user profile');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  TextStyle headingStyle = const TextStyle(
      fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black);

  @override
  Widget build(
    BuildContext context,
  ) {
    //final profileP=Provider.of<ProfileProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xFFD7DCE7),
      bottomNavigationBar: _Navbar3(),
      appBar: AppBar(
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
          "Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xFFD7DCE7),
        child: SingleChildScrollView(
          child: Container(
            color: Color(0xFFD7DCE7),
            padding: const EdgeInsets.all(12),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20), // Image border
                      child: SizedBox.fromSize(
                        size: const Size.fromRadius(48), // Image radius
                        child: Image.network(
                          '$localhost$imageUrl',
                          fit: BoxFit.cover,
                          width: 85,
                          height: 85,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Padding(
                        //right was 180
                        padding: EdgeInsets.only(left: 10, right: 90),
                        child: Text(
                          "Profile Details",
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        )),
                    // TextButton(
                    //
                    //   child: const Text(
                    //     'Edit',
                    //     style: TextStyle(
                    //         color: Color(0xFF00227B),
                    //         fontSize: 18,
                    //         fontWeight: FontWeight.w500),
                    //   ),
                    // )
                  ],
                ),
                // ListView.builder(
                //   itemCount: profileP.profiles.length,
                //   itemBuilder: (BuildContext context, int index) {
                //   return
                ListTile(
                  title: Text("Name",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      )),
                  trailing: Text(
                    '${profileData['name']}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),

                // const Divider(),
                // const ListTile(
                //   title: Text("Last Name",
                //       style: TextStyle(
                //         color: Colors.black,
                //         fontSize: 18,
                //       )),
                //   trailing: Text(
                //     'Ali',
                //     style: TextStyle(
                //       color: Colors.black,
                //       fontSize: 18,
                //     ),
                //   ),
                // ),
                const Divider(),
                ListTile(
                  title: Text("Date Of Birth",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      )),
                  trailing: Text(
                    '${profileData['birthdate']}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                const Divider(),
                ListTile(
                  title: Text("Gender",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      )),
                  trailing: Text(
                    '${profileData['gender']}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                const Divider(),
                ListTile(
                  title: Text("Blood Type",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      )),
                  trailing: Text(
                    '${profileData['blood_type']}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                const Divider(),
                ListTile(
                  title: Text("Medical Condition",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      )),
                  subtitle: Text(
                    '${profileData['medical_condition']}',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  // trailing: Text(
                  //   'Edit',
                  //   style: TextStyle(
                  //       color: Color(0xFF00227B),
                  //       fontSize: 18,
                  //       fontWeight: FontWeight.w500),
                  // ),
                ),
                const Divider(),
                ListTile(
                  title: Text("Weight",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      )),
                  subtitle: Text(
                    '${profileData['weight']}',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  // trailing: Text(
                  //   'Edit',
                  //   style: TextStyle(
                  //       color: Color(0xFF00227B),
                  //       fontSize: 18,
                  //       fontWeight: FontWeight.w500),
                  // ),
                ),
              ], //children elcolumn
            ),
          ),
        ),
      ),
    );
    //  ));
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
            color: Color(0xff566CA6),
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

//////////////
//hos(lat, lng, name)
//ambulance (hos, lat , lng, id, avail)
//requset
//front request => drop down menu(all available owned amb)
