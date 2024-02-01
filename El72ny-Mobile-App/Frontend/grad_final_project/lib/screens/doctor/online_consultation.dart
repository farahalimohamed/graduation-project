import 'package:flutter/material.dart';
import 'package:grad_final_project/screens/Login/login_screen.dart';
import 'package:grad_final_project/screens/messages/chat_body.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../constants.dart';
import '../listview/doctors.dart';

class OnlineConsPage extends StatefulWidget {
  final DoctorModel doctor;

  const OnlineConsPage({Key? key, required this.doctor}) : super(key: key);

  @override
  State<OnlineConsPage> createState() => _OnlineConsPageState();
}

class _OnlineConsPageState extends State<OnlineConsPage> {
  TextStyle headingStyle = const TextStyle(
      fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff566CA6),
      appBar: AppBar(
        backgroundColor: Color(0xff566CA6),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Doctors(),
            ),
          ),
        ),
        elevation: 0,
        title: const Text(
          "Online Consultations",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xff566CA6),
        child: SingleChildScrollView(
          child: Container(
            color: const Color(0xff566CA6),
            padding: const EdgeInsets.all(0),
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //container elText
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 50, 20, 20),
                  child: Column(
                    children: [
                      const Text(
                        'Available Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        " From   ${widget.doctor.availability}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
//column elbox elabyad

                Column(
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        height: 600,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.elliptical(50, 50),
                              topRight: Radius.elliptical(50, 50)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 20.0,
                                offset: Offset(0, 1)),
                          ],
                        ),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Divider(
                                height: 0,
                                thickness: 5,
                                indent: 150,
                                endIndent: 150,
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 40, 0, 10),
                              child: ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: SizedBox.fromSize(
                                    size: Size.fromRadius(48),
                                    child: Image.network(
                                        "${localhost}" + widget.doctor.image),
                                  ),
                                ),
                                title: Text(
                                  widget.doctor.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                  ),
                                ),
                                subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Text(widget.doctor.spec),
                                      //Text('3+ yrs Experience'),
                                    ]),
                              ),
                            ),
                            // kda eldoc info khlas
                            const SizedBox(height: 20),

                            const Divider(
                              height: 0,
                              thickness: 1.2,
                              indent: 100,
                              endIndent: 100,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "Rate the Doctor ?",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xff566CA6)),
                                  ),
                                ),
                                Container(
                                  width: 320,
                                  height: 65,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(31, 141, 138, 138),
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                      color: Color.fromARGB(31, 141, 138, 138),
                                      width: 0,
                                    ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: RatingBar.builder(
                                      initialRating: 0,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 4.0),
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 18,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _showAddReviewDialog(context);
                                  },
                                  child: const Text(
                                    '+ Add Reviews',
                                    style: TextStyle(
                                        color: Color(0xff566CA6),
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                SizedBox(
                                  width: 240,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      print(userId);
                                      if (userId == 0) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MobileLoginScreen(
                                                        widid: 1,
                                                        name:
                                                            widget.doctor.name,
                                                        image: "${localhost}" +
                                                            widget.doctor.image,
                                                        id: widget.doctor.id)));
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => ChatPage(
                                                    widid: 2,
                                                    name: widget.doctor.name,
                                                    image: "${localhost}" +
                                                        widget.doctor.image,
                                                    id: widget.doctor.id)));
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xFF667AB0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      shadowColor: Colors.blueAccent,
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Icon(Icons.chat_rounded),
                                        ),
                                        SizedBox(width: 4),
                                        Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                            'Chat with Doctor',
                                            style: TextStyle(
                                              fontSize: 17,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ], //children elcolumn
            ),
          ),
        ),
      ),
    );
  }

  List<String> _reviews = [];

  void _showAddReviewDialog(BuildContext context) {
    String review = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tell us about your opinion in the doctor'),
          content: TextField(
            onChanged: (value) {
              review = value;
            },
            decoration: InputDecoration(
              hintText: 'Enter your review',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: Color(0xff566CA6)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Submit',
                  style: TextStyle(
                      color: Color(0xff566CA6), fontWeight: FontWeight.w600)),
              onPressed: () {
                setState(() {
                  _reviews.add(review);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
