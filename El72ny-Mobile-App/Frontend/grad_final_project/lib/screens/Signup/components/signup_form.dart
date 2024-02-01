import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:grad_final_project/screens/home/home_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';
import 'package:http/http.dart' as http;

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  void _submitForm() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      // Save the form data
      form.save();
      // Process the form data
    }
  }

  File? _ProfilePic;

  void _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      _ProfilePic = File(pickedFile!.path);
    });
  }

  //ADDED
  DateTime selectedDate = DateTime.now();

  TextEditingController fnameController = TextEditingController();
  TextEditingController UnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController specializationController = TextEditingController();
  TextEditingController availabilityController = TextEditingController();
  TextEditingController allergiesController = TextEditingController();
  TextEditingController medicalController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  DateTime date = DateTime(2023, 3, 18);
  List<String> typ = ['Male', 'Female'];
  String selectedtyp = 'Male';
  List<String> bloodtype = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  String? selectedtype = 'A+';
  List<String> items = ['User', 'Doctor'];
  String? selectedItem = 'User';

  ////////////
  late int res;
  late File _imgFile = File('example.png');

  Future<int> signUp(
    String fullName,
    String username,
    String pass,
    String email,
    String phoneNumber,
    String bDate,
    int isDoc,
    String specialization,
    String availability,
    String gender,
    String bloodtype,
    String allergies,
    String medicalCondition,
    String weight,
  ) async {
    Map data = {
      "name": fullName,
      "username": username,
      "password": pass,
      "email": email,
      "phone_number": phoneNumber,
      "birthdate": bDate,
      "is_doctor": isDoc,
      "specialization": specialization,
      "availability": availability,
      "gender": gender,
      "blood_type": bloodtype,
      "allergies": allergies,
      "medical_condition": medicalCondition,
      "weight": weight,
    };
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$localhost/api/signup/'),
    );
    data.forEach((key, value) {
      request.fields[key] = value.toString();
    });
    request.files.add(
      await http.MultipartFile.fromPath('pic', _ProfilePic!.path),
    );
    if (isDoc == 1) {
      request.files.add(
        await http.MultipartFile.fromPath('doctorId', _imgFile.path),
      );
    }
    request.headers.addAll(
      {'Content-Type': 'multipart/form-data'},
    );

    var response = await request.send();

    return response.statusCode;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              _ProfilePic != null
                  ? CircleAvatar(
                      radius: 80, backgroundImage: FileImage(_ProfilePic!))
                  : CircleAvatar(
                      radius: 80,
                      backgroundImage: NetworkImage(
                          'https://static.vecteezy.com/system/resources/previews/002/896/807/original/female-doctor-using-her-digital-tablet-free-vector.jpg'),
                    ),
              Positioned(
                bottom: -5,
                right: 4,
                child: IconButton(
                  icon: Icon(
                    Icons.camera_alt,
                    color: Colors.grey,
                    size: 35.0,
                  ),
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
          TextFormField(
            controller: fnameController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: Colors.white,
            onSaved: (email) {},
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your full name';
              }
              return null;
            },
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              hintText: "Full Name",
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
              controller: UnameController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: Colors.white,
              onSaved: (email) {},
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your username';
                }
                return null;
              },
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                hintText: "UserName",
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
          ),
          //email
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: Colors.white,
            onSaved: (email) {},
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email address';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              hintText: "Email",
              hintStyle: TextStyle(color: Colors.white),
              prefixIcon: Padding(
                padding: EdgeInsets.all(15),
                child: Icon(
                  Icons.email_outlined,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          //Password
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: TextFormField(
              controller: passwordController,
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: Colors.white,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                }
                if (value.length < 8) {
                  return 'Password must be at least 8 characters';
                }
                if (!RegExp(r'^(?=.*?[!@#\$&*~_]).+$').hasMatch(value)) {
                  return 'Password must contain at least one special character';
                }
                // if(!RegExp(r'^(?=.*[A-Z])$').hasMatch(value))
                // {
                //   return 'Password must contain at least one Upper case';
                //
                // }
                return null;
              },
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                hintText: "Password",
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
          //phone
          TextFormField(
            controller: phoneController,
            textInputAction: TextInputAction.done,
            cursorColor: Colors.white,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              if (!RegExp(r'^[0-9]{11}$').hasMatch(value)) {
                return 'Please enter a valid phone number';
              }
              return null;
            },
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              hintText: "Phone Number",
              hintStyle: TextStyle(color: Colors.white),
              prefixIcon: Padding(
                padding: EdgeInsets.all(15),
                child: Icon(
                  Icons.phone,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),

          Center(
            child: Row(
              children: [
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Blood Type",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.white),
                      ),
                    ),
                    // bloodtype
                    DropdownButton<String>(
                      value: selectedtype,
                      items: bloodtype
                          .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(item,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400))))
                          .toList(),
                      onChanged: (item) => setState(() => selectedtype = item),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Gender",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.white),
                      ),
                    ),
                    //gender
                    DropdownButton<String>(
                      value: selectedtyp,
                      items: typ
                          .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(item,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400))))
                          .toList(),
                      onChanged: (item) => setState(() => selectedtyp = item!),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      //user type
                      child: Text(
                        "User Type",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.white),
                      ),
                    ),
                    DropdownButton<String>(
                        value: selectedItem,
                        items: items
                            .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(item,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400))))
                            .toList(),
                        onChanged: (item) => setState(() {
                              selectedItem = item;
                              if (item == 'Doctor') {
                                Alert(
                                    context: context,
                                    title: "Doctors' section",
                                    content: Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              //medicalID
                                              Text(
                                                "Your medical ID",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: 25,
                                              ),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.white,
                                                  backgroundColor:
                                                      Color(0xff566CA6),
                                                  shape: const StadiumBorder(),
                                                ),
                                                onPressed: () async {
                                                  final result =
                                                      await FilePicker.platform
                                                          .pickFiles(
                                                              type: FileType
                                                                  .image);
                                                  if (result == null) {
                                                    return;
                                                  } else {
                                                    setState(() {
                                                      _imgFile = File(result
                                                          .files.single.path!);
                                                      print(_imgFile);
                                                    });
                                                  }
                                                },
                                                child: Text('Select'),
                                              ),
                                            ],
                                          ),
                                          //specialization
                                          TextField(
                                            decoration: InputDecoration(
                                              labelText: 'Specialization',
                                            ),
                                            controller:
                                                specializationController,
                                          ),
                                          //availability
                                          TextField(
                                            decoration: InputDecoration(
                                              labelText: 'Work hours',
                                            ),
                                            controller: availabilityController,
                                          ),
                                        ],
                                      ),
                                    ),
                                    buttons: [
                                      DialogButton(
                                        color: Color(0xff566CA6),
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text(
                                          "Submit",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                      )
                                    ]).show();
                              } else if (item == 'User') {
                                Alert(
                                    context: context,
                                    title: "Additional info",
                                    content: Column(
                                      children: <Widget>[
                                        //medical history
                                        TextField(
                                          decoration: const InputDecoration(
                                            labelText: 'Medical History',
                                          ),
                                          controller: medicalController,
                                        ),
                                        //allergies
                                        TextField(
                                          decoration: InputDecoration(
                                            labelText: 'Allergies',
                                          ),
                                          controller: allergiesController,
                                        ),
                                        TextField(
                                          decoration: InputDecoration(
                                            labelText: 'Weight',
                                          ),
                                          controller: weightController,
                                        ),
                                      ],
                                    ),
                                    buttons: [
                                      DialogButton(
                                        color: Color(0xff566CA6),
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text(
                                          "Submit",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                      )
                                    ]).show();
                              }
                            }),
                        icon: const Icon(
                          Icons.arrow_drop_down_outlined,
                          color: Colors.white,
                          size: 25,
                        )),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 15,
          ),

          Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ),
                onPressed: () async {
                  DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: date,
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100));
                  // if 'cancle' =>null
                  if (newDate == null) return;
                  // if 'ok' =>DateTime
                  setState(() => date = newDate);
                },
                child: const Text(
                  'Birth-Date',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                '${date.year}/${date.month}/${date.day}',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ],
          ),

          const SizedBox(height: 25),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            ),
            onPressed: () async {
              int is_doc = 0;
              if (selectedItem != "User") {
                is_doc = 1;
              }
              res = await signUp(
                fnameController.text,
                UnameController.text,
                passwordController.text,
                emailController.text,
                phoneController.text,
                '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
                is_doc,
                specializationController.text,
                availabilityController.text,
                selectedtyp,
                selectedtype!,
                allergiesController.text,
                medicalController.text,
                weightController.text,
              );
              print("INFOⓘ| res= ${res}");
              if (res == 200) {
                if (is_doc == 1) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('please wait for the verification email'),
                    ),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return HomeScreen();
                      },
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return MobileLoginScreen();
                      },
                    ),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Username or Email already exists.'),
                  ),
                );
              }
            },
            child: Text(
              "Sign Up".toUpperCase(),
              style: const TextStyle(
                  color: Color(0xff566CA6), fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 15),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const MobileLoginScreen();
                  },
                ),
              );
            },
          ),
          const SizedBox(
            height: 25,
          )
        ],
      ),
    );
  }
}
