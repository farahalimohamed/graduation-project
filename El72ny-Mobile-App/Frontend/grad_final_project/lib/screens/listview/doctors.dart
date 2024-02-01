import 'dart:convert';

import 'package:flutter/material.dart';
import '../../components/components.dart';
import '../../constants.dart';
import 'package:http/http.dart' as http;

import '../chats/chats_screen.dart';
import '../home/home_screen.dart';
import '../settings/profile.dart';
import '../settings/setting_page.dart';

class DoctorModel {
  final int id;
  final String name;
  final String spec;
  final String availability;
  final image;
  final bool online;

  double rating;
  double popularityScore;

  DoctorModel(
      {required this.id,
      required this.name,
      required this.spec,
      required this.availability,
      required this.image,
      required this.online,
      required this.rating,
      required this.popularityScore});

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
        id: json['user'],
        name: json['name'],
        spec: json['specialization'],
        availability: json['availability'],
        image: json['pic'],
        online: json['online'],
        rating: json['rate'],
        popularityScore: json['rate'] * 10);
  }
}

class Doctors extends StatefulWidget {
  const Doctors({super.key});

  @override
  State<Doctors> createState() => _DoctorsState();
}

class _DoctorsState extends State<Doctors> {
  @override
  void initState() {
    super.initState();
    getAllDoctors();
  }

  Future<void> getAllDoctors() async {
    final response = await http.get(
      Uri.parse('${localhost}/api/doctors/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final obj = (json.decode(response.body) as List)
        .map((itemJson) => DoctorModel.fromJson(itemJson))
        .toList();
    setState(() {
      doctors = obj;
      doctors.sort((a, b) => a.name.compareTo(b.name));
    });
  }

  void searchDoctor(String query) {
    if (query.isNotEmpty) {
      setState(() {
        doctors = doctors
            .where((doctor) =>
                doctor.name.toLowerCase().contains(query.toLowerCase()) ||
                doctor.spec.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        getAllDoctors();
      });
    }
  }

  void sortDoctors() {
    setState(() {
      if (isfiltered == true) {
        filtering = '''All Doctors  ''';
        doctors.sort((a, b) => a.name.compareTo(b.name));
        isfiltered = false;
      } else {
        filtering = 'Most Popular';
        doctors.sort((a, b) => b.popularityScore.compareTo(a.popularityScore));
        isfiltered = true;
      }
    });
  }

  List<DoctorModel> doctors = [];
  String filtering = '''All Doctors  ''';
  bool isfiltered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD7DCE7),
      bottomNavigationBar: _Navbar1(),
      appBar: myappbar(title: "Doctors", context: context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            children: [
              const SizedBox(
                height: 7,
              ),
              // searchformfield(),
              Center(
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  height: 54,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 10),
                        blurRadius: 50,
                        color: kPrimaryColor.withOpacity(0.23),
                      ),
                    ],
                  ),
                  child: Row(
                    children: <Widget>[
                      Image.asset("assets/icons/Search.png"),
                      Expanded(
                        child: TextField(
                          onChanged: (query) {
                            searchDoctor(query);
                          },
                          decoration: InputDecoration(
                            hintText: "Search",
                            hintStyle: TextStyle(
                              color: kPrimaryColor.withOpacity(0.5),
                            ),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            // surffix isn't working properly  with SVG
                            // thats why we use row
                            // suffixIcon: SvgPicture.asset("assets/icons/search.svg"),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    filtering,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(
                    width: 100,
                  ),
                  IconButton(
                    onPressed: () {
                      sortDoctors();
                    },
                    icon: Icon(
                      Icons.filter_list,
                      color: Color(0xff002984),
                    ),
                  ),
                  const Text(
                    "Filter",
                    style: TextStyle(
                        color: Color(0xff002984),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 500,
                child: Flexible(
                  fit: FlexFit.loose,
                  child: ListView.separated(
                    // shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) =>
                        buildDoctorList(doctors[index], context),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 25,
                    ),
                    itemCount: doctors.length,
                  ),
                ),
              ),
            ],
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChatsScreen(),
                ),
              );
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
