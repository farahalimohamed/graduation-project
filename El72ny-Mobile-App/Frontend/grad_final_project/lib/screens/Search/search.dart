import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../constants.dart';
import '../doctor/instructions.dart';
import '../doctor/online_consultation.dart';
import '../listview/doctors.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _query = '';
  List<dynamic> _results = [];
  bool _isPressed = false;
  int _selectedIndex = -1;

  Future<void> _search() async {
    if (_query.isEmpty) {
      setState(() {
        _results = [];
      });
    } else {
      final response = await http
          .get(Uri.parse('${localhost}/api/search?q=$_query'));

      if (response.statusCode == 200) {
        setState(() {
          _results = jsonDecode(response.body);
        });
      } else {
        throw Exception('Failed to load search results');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD7DCE7),
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: const Color(0xFFD7DCE7),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 3.0,
            left: 0.0,
            right: 0.0,
            child: Center(
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
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
                        onChanged: (value) async {
                          setState(() {
                            _query = value;
                          });

                          if (_query.isEmpty) {
                            setState(() {
                              _results = [];
                            });
                          } else {
                            await _search();

                            if (_results.isEmpty) {
                              setState(() {
                                _results = [];
                              });
                            }
                          }
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
          ),
          Padding(
            padding: EdgeInsets.only(top: 75.0),
            child: _query.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'How can I assist you?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: 250.0,
                    height: 250.0,
                    child: Image.asset('assets/images/searchhh.png'),
                  ),
                ],
              ),
            )
                : _results.isEmpty
                    ? _notfound()
                    : SingleChildScrollView(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Colors.grey),
                              color: Colors.white),
                          margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                          padding: EdgeInsets.all(10.0),
                          child: SizedBox(
                            height: 200.0,
                            child: ListView.builder(
                              shrinkWrap: false,
                              physics: BouncingScrollPhysics(),
                              itemCount: _results.length,
                              itemBuilder: (context, index) {
                                final result = _results[index];
                                if (result.containsKey('name') &&
                                    result.containsKey('specialization')) {
                                  // Display a doctor result
                                  return GestureDetector(
                                    onTapDown: (_) =>
                                        setState(() => _isPressed = true),
                                    onTapUp: (_) =>
                                        setState(() => _isPressed = false),
                                    onTap: () {
                                      setState(() {
                                        _selectedIndex = index;
                                      });

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => OnlineConsPage(
                                              doctor: DoctorModel(
                                            name: result['name'],
                                            spec: result['specialization'],
                                            image: result['pic'],
                                            id: result['id'],
                                            availability:result['availability'],
                                            online: result['online'],
                                            rating: result['rate'],
                                            popularityScore: result['rate']*10,
                                          )),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      color: index == _selectedIndex
                                          ? Colors.grey[200]
                                          : Colors.transparent,
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          radius: 20,
                                          backgroundImage: NetworkImage(
                                              '${localhost}/media/' +
                                                  result['pic']),
                                        ),
                                        title: Text(result['name']),
                                        subtitle:
                                            Text(result['specialization']),
                                      ),
                                    ),
                                  );
                                } else if (result.containsKey('name')) {
                                  // Display a first aid result
                                  return GestureDetector(
                                    onTapDown: (_) =>
                                        setState(() => _isPressed = true),
                                    onTapUp: (_) =>
                                        setState(() => _isPressed = false),
                                    onTap: () {
                                      setState(() {
                                        _selectedIndex = index;
                                      });
                                      if (result['name'] ==
                                          'Heart Attack - أزمه قلبيه') {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                InstPage(instId: 1),
                                          ),
                                        );
                                      } else if (result['name'] ==
                                          'choking - الأختناق') {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                InstPage(instId: 5),
                                          ),
                                        );
                                      } else if (result['name'] ==
                                          'Minor burns-حروق') {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                InstPage(instId: 23),
                                          ),
                                        );
                                      } else if (result['name'] ==
                                          'Major burns-حروق') {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                InstPage(instId: 19),
                                          ),
                                        );
                                      } else if (result['name'] ==
                                          'Allergies-حساسية') {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                InstPage(instId: 26),
                                          ),
                                        );
                                      } else if (result['name'] ==
                                          'Asthma-الربو') {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                InstPage(instId: 31),
                                          ),
                                        );
                                      }
                                    },
                                    child: Container(
                                      color: index == _selectedIndex
                                          ? Colors.grey[200]
                                          : Colors.transparent,
                                      child: ListTile(
                                        title: Text(result['name']),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ),
                        ),
                      ),
          ),
        ],
      ),
    );
  }

  _notfound() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: FutureBuilder(
          future: Future.delayed(Duration(milliseconds: 500)),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Result not found.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: 250.0,
                    height: 250.0,
                    child: Image.asset('assets/img/search_not_found.png'),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
