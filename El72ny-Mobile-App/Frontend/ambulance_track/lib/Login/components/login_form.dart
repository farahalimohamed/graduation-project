import 'package:ambulance_track/Tracking/waiting_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../constants.dart';
import '../../Tracking/navigation_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  //ADDED
  TextEditingController passwordController = TextEditingController();
  TextEditingController idController = TextEditingController();

//////////////////////FOR BACK///////////
//   late int res;
//
  Future<int> loggin(String id, String pass) async {
    Map data = {'id': id, 'password': pass};

    final response = await http.post(
      Uri.parse('${localhost}ambLogin/'),
      body: jsonEncode(data),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      ambId = responseBody['ambId'];
      print('Logged in as amb $ambId');
    } else {
      print('Error logging in: ${response.statusCode}');
    }
    return response.statusCode;
  }

  var exists = false;

  ////////////get connection/////////////////
  Future<LatLng> getConnection() async {
    final response = await http.get(
      Uri.parse('${localhost}getConnection/$ambId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print("a333 ${response.statusCode}");
    final responseBody = jsonDecode(response.body);
    if (responseBody['exists'] == 1) {
      print("existsssss");
      exists = true;
      print("1:$exists");
      print(responseBody['userloc']['lat']);

      double userlat = double.parse(responseBody['userloc']['lat']);
      double userlng = double.parse(responseBody['userloc']['lng']);
      return LatLng(userlat, userlng);
    }
    return const LatLng(0, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: idController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your user name';
              }
              return null;
            },
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            cursorColor: Colors.white,
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              hintText: "Your Ambulance ID",
              hintStyle: TextStyle(color: Colors.white),
              prefixIcon: Padding(
                padding: EdgeInsets.all(15),
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: TextFormField(
              controller: passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: Colors.white,
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                hintText: "Your password",
                hintStyle: TextStyle(color: Colors.white),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(15),
                  child: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              onPressed: () async {
                int res =
                    await loggin(idController.text, passwordController.text);
                print("INFOⓘ| res= $res");
                if (res == 200) {
                  LatLng userLoc = await getConnection();
                  // await getConnection();
                  print("2:$exists");
                  if (exists == true) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AmbulanceScreen(
                                  userloc: userLoc,
                                )));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Waiting_Screen()));
                  }
                }
              },
              child: Text(
                "Login".toUpperCase(),
                style: const TextStyle(
                    color: Color(0xff566CA6), fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
