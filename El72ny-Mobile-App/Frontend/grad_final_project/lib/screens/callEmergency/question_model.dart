import 'dart:convert';

import 'package:flutter/material.dart';
import '../../constants.dart';
import '../home/home_screen.dart';
import '../doctor/instructions.dart';

import 'package:http/http.dart' as http;

import 'package:geolocator/geolocator.dart';

class Question {
  final String question;
  final List<String> choices;
  final List<int> nextQuestionIds;

  Question(this.question, this.choices, this.nextQuestionIds);
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  void initState() {
    super.initState();
  }

  ///////////////////addd for tracking///////////////

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
  }

  ////////////////connect to an ambulance////////////////////////

  Future<int> RequestAmb(double lat, double lng) async {
    Map data = {'uid': userId, 'lat': lat, 'lng': lng, 'ucase': casee};
    print("pleaseeeee wrk");
    final response = await http.post(
      Uri.parse('${localhost}/api/ambulance/'),
      body: jsonEncode(data),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response.statusCode;
  }

  ///////////////////////////////////////

  int count = 0;
  List<int> _answeredQuestionIds = [];
  final List<Question> _questions = [
    Question(
      "ماهي نوع الحالة؟",
      ["حادث سير", "اختناق", "أزمة قلبيه", "الحروق"],
      [1, 26, 4, 2], // Next question IDs for each choice
    ),
    //car accident///
    //id=1
    Question(
      "هل المصاب واعي؟",
      ["نعم", "لا"],
      [20, 5], // Next question IDs for each choice
    ),
    //burns//
    //id=2
    Question(
      "هل الحرق يشمل الوجه او المسالك الهوائيه او اليدين او القدمين وأو يغطي مساحه كبيرة من الجسم؟",
      ["نعم", "لا"],
      [27, 28], // Next question IDs for each choice
    ),
    //id=3
    Question(
      "هل يوجد نزيف؟",
      ["نعم", "لا"],
      [7, 8], // Next question IDs for each choice
    ),
    //id=4
    Question(
      "هل الحاله فاقده للوعي ؟",
      ["نعم", "لا"],
      [24, 25], // Next question IDs for each choice
    ),
    //id=5
    Question(
      "هل المصاب ينزف من الفم أو قام بالتقيؤ؟",
      ["نعم", "لا"],
      [21, 6], // Next question IDs for each choice
    ),
    //id=6
    Question(
      "هل المصاب لديه أي جروح مفتوحه ؟",
      ["نعم", "لا"],
      [22, 23], // Next question IDs for each choice
    ),
    Question(
      "هل يشعر بألم في الصدر أو ضيق تنفس أو دوخه وتعرق ؟",
      ["نعم", "لا"],
      [10, 25], // Next question IDs for each choice
    ),
    Question(
      "هل أستمر الألم  لأكثر من 15 دقيقه ؟ ؟",
      ["نعم استمر ", "لا فقط كان لمده قصيره"],
      [22, 25], // Next question IDs for each choice
    ),
  ];
  int _currentQuestionIndex = 0;
  bool _showSubmitButton = false;

  var instidd = 0;

  Future<void> _selectAnswer(int index) async {
    setState(() {
      ///////////////////////for request ambulance//////////////
      casee +=
          "${_questions[_currentQuestionIndex].question}: ${_questions[_currentQuestionIndex].choices[index]}";
      print(casee);
      /////////////////////////////////

      _answeredQuestionIds.add(_currentQuestionIndex);
      if (_currentQuestionIndex == _questions.length - 1) {
        _showSubmitButton = true;
      } else {
        _currentQuestionIndex =
            _questions[_currentQuestionIndex].nextQuestionIds[
                index]; // Get the next question ID based on the selected answer
      }

      if (_currentQuestionIndex == 20) {
        instidd = 12;
      } else if (_currentQuestionIndex == 21) {
        instidd = 16;
      } else if (_currentQuestionIndex == 22) {
        instidd = 17;
      } else if (_currentQuestionIndex == 23) {
        instidd = 13;
      } else if (_currentQuestionIndex == 24) {
        instidd = 18;
      } else if (_currentQuestionIndex == 25) {
        instidd = 1;
      } else if (_currentQuestionIndex == 26) {
        instidd = 5;
      } else if (_currentQuestionIndex == 27) {
        instidd = 19;
      } else if (_currentQuestionIndex == 28) {
        instidd = 23;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD7DCE7),
      body: _currentQuestionIndex < _questions.length
          ? SingleChildScrollView(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          color: Colors.black,
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          ),
                        ),
                        Spacer(),
                        const Text(
                          "Call Emergency",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        Spacer()
                      ],
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: Color(0xff566CA6),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        _questions[_currentQuestionIndex].question,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Column(
                      children: _questions[_currentQuestionIndex]
                          .choices
                          .asMap()
                          .entries
                          .map((entry) {
                        final index = entry.key;
                        final choice = entry.value;
                        bool isSelected = choice == _selectAnswer;
                        return Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          height: 48,
                          child: ElevatedButton(
                            child: Text(choice),
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              primary:
                                  isSelected ? Color(0xff566CA6) : Colors.white,
                              onPrimary:
                                  isSelected ? Colors.white : Colors.black,
                            ),
                            onPressed: () => _selectAnswer(index),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            )
          : FutureBuilder<void>(
              future: Future.delayed(Duration.zero).then((value) async {
                await fetchCurrentLocation();
                print("printt");
                int res = await RequestAmb(
                    _currentPosition.latitude, _currentPosition.longitude);
                if (res == 200) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => InstPage(
                        instId: instidd,
                        widtyp: 0,
                      ),
                    ),
                  );
                }
              }),
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                return Container(); // Placeholder widget
              },
            ),
    );
  }
}
