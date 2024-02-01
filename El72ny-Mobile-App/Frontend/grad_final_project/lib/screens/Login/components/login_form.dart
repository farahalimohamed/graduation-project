import 'package:flutter/material.dart';
import 'package:grad_final_project/screens/home/home_screen.dart';
import 'package:grad_final_project/screens/settings/changePassword.dart';
import '../../../components/already_have_an_account_acheck.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../constants.dart';
import '../../Signup/signup_screen.dart';
import '../../chats/chats_screen.dart';
import '../../messages/chat_body.dart';
import '../../settings/profile.dart';

class LoginForm extends StatefulWidget {
  final widid;
  final name;
  final image;
  final id;

  const LoginForm({Key? key, this.widid, this.name, this.image, this.id})
      : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  //ADDED
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

//////////////////////FOR BACK///////////
  late int res;

  Future<int> loggin(String username, String pass) async {
    Map data = {'username': username, 'password': pass};

    final response = await http.post(
      Uri.parse('$localhost/api/login/'),
      body: jsonEncode(data),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      userId = responseBody['user_id'];
      profileId = responseBody["profile"];
      // token = responseBody['token'];
      print('Logged in as user $userId');
      // print('tokennn: $token');
    } else {
      print(jsonDecode(response.body));
    }
    return response.statusCode;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: usernameController,
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
              hintText: "Your Username",
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangePasswordScreen()));
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
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
                if (!_formKey.currentState!.validate()) {
                  return;
                }
                res = await loggin(
                    usernameController.text, passwordController.text);
                print("INFOⓘ| res= $res");
                if (res == 200) {
                  if (widget.widid == 1) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatPage(
                                widid: 1,
                                name: widget.name,
                                image: widget.image,
                                id: widget.id)));
                  } else if (widget.widid == 2) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          //add home or actual chat page//
                          return ChatsScreen();
                        },
                      ),
                    );
                  } else if (widget.widid == 3) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  }
                } else if (res == 320) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please wait for the verification email.'),
                    ),
                  );
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Incorrect Username or Password'),
                    ),
                  );
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
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const MobileSignupScreen();
                  },
                ),
              );
            },
          ),
          SizedBox(
            height: 25,
          )
        ],
      ),
    );
  }
}
