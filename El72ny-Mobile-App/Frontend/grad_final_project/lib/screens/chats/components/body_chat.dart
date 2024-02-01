
import 'dart:async';
import 'dart:convert';

import '../../messages/chat_body.dart';
import '/models/Chat.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../constants.dart';
import 'chat_card.dart';

// const int PERIOD = 60 * 60; // perform activity every hour


class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadMoreChats();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _loadMoreChats();
    }
  }

  Future<void> _loadMoreChats() async {
    if (_isLoading) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    final doctorCount = DoctorList.doctorList.length;
    final response = await http.get(Uri.parse('${localhost}/api/Doctor/$userId?limit=10&offset=$doctorCount'));
    final val = response.body;
    final data = jsonDecode(val);
    // DoctorList.clearDoctor();
    DoctorList.addDoctor(data);
    setState(() {
      _isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(
              kDefaultPadding, 0, kDefaultPadding, kDefaultPadding),
          color: const Color(0xffD7DCE7),
        ),
        const SizedBox(height: 15,),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          height: 54,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 10),
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
                  controller: _searchController,
                  onChanged: (query) {
                    setState(() {
                      DoctorList.filterDoctor(query);
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: TextStyle(
                      color: kPrimaryColor.withOpacity(0.5),
                    ),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                   ),
                ),
              ),

            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            itemCount: DoctorList.doctorList.length + (_isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (_isLoading && index == DoctorList.doctorList.length) {
                return const Center(child: CircularProgressIndicator());
              }
              final doctor = DoctorList.doctorList[index];
              return ChatCard(
                  chat: Chat(
                    name: doctor['name'],
                    image: doctor['pic'],
                    isActive: doctor['online'],
                    specialization: doctor['specialization'],
                    id:doctor['user'],
                    // time: doctor['my_datetime_field'],
                  ),
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  ChatPage(
                          name: doctor['name'],
                          image: doctor['pic'],
                          id:doctor['user'],
                          widid: 2,
                        ),
                      ),
                    );
                  }
              );
            },
          ),
        ),
      ],
    );
  }
}

class DoctorList {
  static List<dynamic> _allDoctorList = [];
  static List<dynamic> _doctorList = [];

  static List<dynamic> get doctorList => _doctorList;

  static Future<void> getDoctor(int limit, int offset) async {

    final response = await http.get(Uri.parse('${localhost}/api/Doctor/$userId?limit=$limit&offset=$offset'));
    final val = response.body;
    final data = jsonDecode(val);
    _allDoctorList.addAll(data);
    _doctorList.addAll(data);
  }

  static void addDoctor(List<dynamic> data) {
    for (final doctor in data) {
      if (!_allDoctorList.any((d) => d['user'] == doctor['user'])) {
        _allDoctorList.add(doctor);
        _doctorList.add(doctor);
      }
    }
  }

  static void filterDoctor(String query) {
    if (query.isEmpty) {
      _doctorList = List.from(_allDoctorList);
    } else {
      _doctorList = _allDoctorList.where((doctor) => doctor['name'].toLowerCase().contains(query.toLowerCase())).toList();
    }
  }
  static void clearDoctorList() {
    _allDoctorList = [];
    _doctorList = [];
  }
}
