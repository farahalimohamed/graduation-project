import 'package:flutter/material.dart';

import '../../listview/dashboard.dart';
import '../../listview/doctors.dart';
import '../../nearby/hos.dart';
import '../../nearby/pharma.dart';

class HorizontalListPage extends StatefulWidget {
  // This widget is the root of your application.

  const HorizontalListPage({key});
  @override
  _HorizontalListPageState createState() => _HorizontalListPageState();
}

class _HorizontalListPageState extends State<HorizontalListPage> {
  List<Map> categories = [
    {'iconPath': 'assets/images/first-aid-box.png'},
    {'iconPath': 'assets/images/hospital.png'},
    {'iconPath': 'assets/images/drugstore.png'},
    {'iconPath': 'assets/images/online consultation.png'},
  ];
  List screens =[
    DashPage(),
    HospitalListScreen(),
    PharmacyListScreen(),
    Doctors(),
  ];
  List text = [
    'First-aid',
    'Hospitals',
    'Pharmacies',
    'Online\nConsultation'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, int index) {
            return Container(
              margin: EdgeInsets.only(right: 10,left: 10),
              child: Row(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => screens[index]));
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.only(top: 15),
                          decoration: BoxDecoration(
                              color: Color(0x9900227B),
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.asset(
                            categories[index]['iconPath'],
                            height: 45,
                            width: 45,
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text(
                          text[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold,),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
      ),
    );
  }
}