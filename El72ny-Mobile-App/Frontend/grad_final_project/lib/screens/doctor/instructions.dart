import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grad_final_project/constants.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';

import '../Login/login_screen.dart';
import '../chats/chats_screen.dart';
import '../home/home_screen.dart';
import '../settings/profile.dart';
import '../settings/setting_page.dart';
import '../track/navigation_screen.dart';

class InstPage extends StatefulWidget {
  var instId;
  var widtyp;

  InstPage({this.instId, this.widtyp});

  @override
  State<InstPage> createState() => _InstPageState();
}

class _InstPageState extends State<InstPage> {
  Map<String, dynamic> instData = {};
  VideoPlayerController? controller;
  bool isButtonVisible = true;

////////////////////////check connection/////////////////////////
  late Position _currentPosition;

  Future<void> fetchCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return;
      }
    }

    _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    ///////////back update loc///////////
    Map data = {
      'user_id': "$userId",
      'Lat': _currentPosition.latitude,
      'Lng': _currentPosition.longitude
    };
    final response = await http.post(
      Uri.parse('${localhost}/api/updateUserLoc/'),
      body: jsonEncode(data),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.statusCode);
  }

  Future<void> checkConnection() async {
    Map data = {"uid": userId};
    final request = await http.post(
      Uri.parse('${localhost}/api/checkConnection/'),
      body: jsonEncode(data),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (request.statusCode == 200) {
      final responseBody = jsonDecode(request.body);
      ambId = responseBody['ambid'];
    }
  }

  void _updateData(Timer timer) async {
    if (ambId == 0) {
      await checkConnection();
    } else {
      await fetchCurrentLocation();
    }
  }

  ////////////get ambulance location//////////////////
  Future<LatLng> getAmbulanceLoc() async {
    final response = await http.get(
      Uri.parse('${localhost}/api/getConnection/$ambId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print("a333 ${response.statusCode}");
    final responseBody = jsonDecode(response.body);
    double ambLat = double.parse(responseBody['ambloc']['lat']);
    print(ambLat);
    double ambLng = double.parse(responseBody['ambloc']['lng']);
    return LatLng(ambLat, ambLng);
  }

/////////////////////////////////////////////////////////////
  Future<void> fetchinstData() async {
    if (widget.instId == 4 ||
        widget.instId == 11 ||
        widget.instId == 12 ||
        widget.instId == 25 ||
        widget.instId == 16 ||
        widget.instId == 17 ||
        widget.instId == 15 ||
        widget.instId == 18 ||
        widget.instId == 30 ||
        widget.instId == 31 ||
        widget.instId == 37 ||
        widget.instId == 41 ||
        widget.instId == 45 ||
        widget.instId == 50) {
      isButtonVisible = false;
    }
    final response = await http.get(
        Uri.parse('${localhost}/api/firstaid/${widget.instId}?format=json'));
    if (response.statusCode == 200) {
      instData = jsonDecode(utf8.decode(response.bodyBytes));
///////////////////////////////////must change ip/////////////////////////////
      setState(() {
        controller =
            VideoPlayerController.network('${localhost}' + instData['video'])
              ..initialize().then((_) {
                controller!.play();
                controller!.setLooping(true);
              });
      });
    } else {
      throw Exception('Failed to load user profile');
    }
  }

  @override
  void dispose() {
    controller?.pause();
    controller?.dispose();
    super.dispose();
  }

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    fetchinstData();
    if (casee != '') {
      _timer = Timer.periodic(const Duration(seconds: 5), _updateData);
    }
  }

  TextStyle headingStyle = const TextStyle(
      fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD7DCE7),
      bottomNavigationBar: _Navbar1(),
      appBar: AppBar(
        backgroundColor: Color(0xFFD7DCE7),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () {
              controller?.dispose();
              if (widget.widtyp == 1) {
                Navigator.pop(context);
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              }
            }),
        elevation: 0,
        title: const Text(
          "First-aid instructions",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: controller == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                //height: 80,
                color: Color(0xFFD7DCE7),
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    casee != ''
                        ? Align(
                            alignment: Alignment.topRight,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                elevation: 5,
                                shadowColor: Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () async {
                                print("pressed");
                                if (ambId != 0) {
                                  controller?.dispose();
                                  await fetchCurrentLocation();
                                  LatLng ambLoc = await getAmbulanceLoc();
                                  if (_currentPosition != null) {
                                    _timer.cancel();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AmbulanceScreen(
                                          ambulanceloc: ambLoc,
                                        ),
                                      ),
                                    );
                                  }
                                }
                              },
                              child: Container(
                                width: 190,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Color(0xff566CA6),
                                    ),
                                    Text(
                                      'Track Ambulance',
                                      style: TextStyle(
                                        color: Color(0xff566CA6),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, top: 8),
                      child: Text(
                        '${instData['name']}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 30),
                      child: Container(
                          padding: EdgeInsets.only(
                              top: 10.0, bottom: 10.0, left: 5, right: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Color(0xff566CA6),
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: const Offset(
                                  3.0,
                                  3.0,
                                ),
                                blurRadius: 10.0,
                                spreadRadius: 2.0,
                              ), //BoxShadow
                              BoxShadow(
                                color: Colors.white,
                                offset: const Offset(0.0, 0.0),
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                              ), //BoxShadow
                            ],
                          ),
                          width: double.infinity,
                          height: 200,
                          child: AspectRatio(
                            aspectRatio: controller!.value.aspectRatio,
                            child: VideoPlayer(controller!),
                          )),
                    ),
                    Row(
                      children: [
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 5.0,
                                  right: 5.0,
                                  top: 35.0,
                                  bottom: 15.0),
                              child: Center(
                                child: Text(
                                  instData['Description'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 10, bottom: 35, top: 0),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: Text(
                              instData['stepNum'],
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: isButtonVisible,
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.only(top: 15.0),
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          InstPage(instId: widget.instId + 1, widtyp: 1,),
                                    ));
                              },
                              child: Text('Next'),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(150.0, 40.0),
                                shape: const StadiumBorder(),
                                primary: const Color(0xff566CA6),
                                onPrimary: Colors.white,
                              )),
                        ),
                      ),
                    ),
                  ], //children elcolumn
                ),
              ),
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
