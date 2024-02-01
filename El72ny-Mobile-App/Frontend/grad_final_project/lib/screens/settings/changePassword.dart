import 'package:flutter/material.dart';
import 'package:grad_final_project/constants.dart';
import 'package:http/http.dart' as http;

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  String _newPassword = '';
  String _confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff566CA6),
      appBar: AppBar(
        backgroundColor: Color(0xff566CA6),
        // title: const Text('Set a new Password'),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Color.fromARGB(255, 255, 255, 255),
          onPressed: () => Navigator.pop(context),
        ),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Image(image: AssetImage("assets/images/lock.png"),width: 100,height: 100,),
            Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      cursorColor: Colors.white,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: 'UserName',
                        // hintText: 'Enter your UserName',
                        labelStyle: TextStyle(color: Colors.white),
                        // hintStyle: TextStyle(color: Colors.white)
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(15),
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your UserName';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        uname = value!;
                      },
                    ),
                    TextFormField(
                      cursorColor: Colors.white,
                      obscureText: true,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: 'New Password',
                        labelStyle: TextStyle(color: Colors.white),
                        // hintText: 'Enter your new password',

                        // hintStyle: TextStyle(color: Colors.white)
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(15),
                          child: Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your new password';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _newPassword = value!;
                      },

                    ),

                    TextFormField(
                      cursorColor: Colors.white,
                      obscureText: true,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(color: Colors.white),
                        // hintText: 'Confirm your new password',
                        // hintStyle: TextStyle(color: Colors.white)
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(15),
                          child: Icon(
                            Icons.check_circle,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your new password';
                        }
                        if (_confirmPassword != _newPassword) {
                          return 'New password and confirm password do not match';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _confirmPassword = value!;
                      },
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: const Color(0xff566CA6),
                        backgroundColor: Colors.white,
                        textStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
                        padding:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      ),
                      child: const Text('Chanage Password'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          _changePassword();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  var uname;
  Future<void> _changePassword() async {
    final response = await http.post(
      Uri.parse('$localhost/api/ChangePassword/'),
      body: {
        'uname': uname, // Replace with the user's ID
        'pass': _newPassword,
      },
    );
    if (response.statusCode == 200) {
      showDialog(

        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Password Changed'),
            content: const Text('Your password has been changed successfully.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK',style: TextStyle(color: Color(0xff566CA6),fontWeight: FontWeight.w800),),

                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
        context: context,
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(
                'An error occurred while changing your password. Please try again.'),
            actions: <Widget>[
              // FlatButton(
              //   child: Text('OK'),
              //   onPressed: () {
              //     Navigator.of(context).pop();
              //   },
              // ),
            ],
          );
        },
      );
    }
  }
}