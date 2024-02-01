import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../../constants.dart';
import '../../callEmergency/question_model.dart';
import 'package:http/http.dart' as http;

class CallEmergency extends StatefulWidget {
  CallEmergency({Key? key}) : super(key: key);

  @override
  State<CallEmergency> createState() => _CallEmergencyState();
}

class _CallEmergencyState extends State<CallEmergency> {
  Position? currentPosition1;

  Future<void> fetchCurrentLocation() async {
    // bool serviceEnabled;
    // LocationPermission permission;

    // serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   // Location services are disabled
    //   return;
    // }
    //
    // permission = await Geolocator.checkPermission();
    // if (permission == LocationPermission.deniedForever) {
    //   // Location permissions are permanently denied
    //   return;
    // }
    //
    // if (permission == LocationPermission.denied) {
    //   // Location permissions are denied, ask for permissions
    //   permission = await Geolocator.requestPermission();
    //   if (permission != LocationPermission.whileInUse &&
    //       permission != LocationPermission.always) {
    //     // Permissions are denied
    //     return;
    //   }
    // }

    // Fetch the current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print("position $position");
    setState(() {
      currentPosition1 = position;
      print("currrentLoc $currentPosition1");
    });
  }

  ///////////////BACK TRACKING FUNC///////////////////
  Future<int> connectAmb(String uid, double lat, double lng) async {
    Map data = {'uid': uid, 'lat': lat, 'lng': lng};

    final response = await http.post(
      Uri.parse('${localhost}/api/ambulance/'),
      body: jsonEncode(data),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      print(responseBody["ambid"]);
      ambId = responseBody["ambid"];
    } else {
      print('Error tracking: ${response.statusCode}');
    }
    return response.statusCode;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 10,
        top: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomLeft,
          colors: [
            Color(0x33D9D9D9),
            Color(0xA600227B),
          ],
        ),
      ),
      height: 150,
      margin: const EdgeInsets.only(left: 20, top: 0, right: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Image.asset(
            'assets/images/ambulance.png',
            width: 150,
            height: 150,
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: FloatingActionButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                backgroundColor: Colors.white,
                onPressed: () async {
                  print("pressed");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Call Emergency',
                  style: TextStyle(
                      color: Color(0xff00227B),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SF Pro Text',
                      fontSize: 13.0),
                )),
          )
        ],
      ),
    );
  }
}
