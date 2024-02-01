import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:grad_final_project/screens/home/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../../constants.dart';

class ProfileEditPage extends StatefulWidget {
  String name, bloodType, medCon, weight, img;
  ProfileEditPage({super.key, required this.name, required this.bloodType, required this.medCon, required this.weight, required this.img});
  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  TextStyle headingStyle = const TextStyle(
      fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black);

  final _formKey = GlobalKey<FormState>();

  Future<void> UpdateProfile() async{
    final response= await http.post(
      Uri.parse('$localhost/api/updateprofile/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "uid":userId,
        "name":widget.name,
        "weight":widget.weight,
        "medCon":widget.medCon,
        "bt":widget.bloodType
      })
    );
    if(response.statusCode==200){
      print("changed");
    }
  }

  File? _ProfilePic;

  void _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD7DCE7),
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
          "Edit Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          color: const Color(0xFFD7DCE7),
          child: SingleChildScrollView(
            child: Container(
              color: const Color(0xFFD7DCE7),
              padding: const EdgeInsets.all(12),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        _ProfilePic != null
                            ? CircleAvatar(
                            radius: 80, backgroundImage: FileImage(_ProfilePic!))
                            : CircleAvatar(
                          radius: 80,
                          backgroundImage: NetworkImage(
                              widget.img,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: IconButton(
                            icon: Icon(Icons.camera_alt),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return SafeArea(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        // ListTile(
                                        //   leading: Icon(Icons.camera_alt),
                                        //   title: Text('Take a picture'),
                                        //   onTap: () {
                                        //     Navigator.of(context).pop();
                                        //     _pickImage(ImageSource.camera);
                                        //   },
                                        // ),
                                        ListTile(
                                          leading: Icon(Icons.photo_library),
                                          title: Text('Choose from gallery'),
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            _pickImage(ImageSource.gallery);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                      labelStyle: TextStyle(color: Colors.black, fontSize: 18),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                    ),
                    initialValue: widget.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      widget.name = value!;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Blood Type',
                      labelStyle: TextStyle(color: Colors.black, fontSize: 18),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                    ),
                    initialValue: widget.bloodType,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your blood type';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      widget.bloodType = value!;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Medical Condition',
                      labelStyle: TextStyle(color: Colors.black, fontSize: 18),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                    ),
                    initialValue: widget.medCon,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your medical condition';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      widget.medCon = value!;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Weight',
                      labelStyle: TextStyle(color: Colors.black, fontSize: 18),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                    ),
                    initialValue: widget.weight,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your weight';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      widget.weight = value!;
                    },
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          await UpdateProfile();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Profile updated')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: kPrimaryColor,
                        minimumSize: const Size(200, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
