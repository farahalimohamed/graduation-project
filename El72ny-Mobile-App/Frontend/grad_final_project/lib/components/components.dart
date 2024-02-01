import 'package:flutter/material.dart';
import 'package:grad_final_project/constants.dart';
import 'package:grad_final_project/screens/home/home_screen.dart';
import '../screens/doctor/online_consultation.dart';
import '../screens/listview/doctors.dart';


Widget buildDoctorList(DoctorModel doctor, BuildContext context) => Container(
  child: GestureDetector(
    onTap: () => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OnlineConsPage(doctor: doctor),
      ),
    ),
    child: Row(
      children: [
        CircleAvatar(
          backgroundImage:
          NetworkImage("${localhost}" + doctor.image),
          radius: 30,
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  doctor.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF344054),
                    fontSize: 15,
                  ),
                ),
                const SizedBox(width: 20,),
                doctor.online == true
                    ? Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.green[700],
                      radius: 3,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      "Online",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700],
                        fontSize: 14,
                      ),
                    ),
                  ],
                )
                    : SizedBox(),
              ],
            ),

            ///////////////////
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Container(
                  width: 120,
                  child: Text(
                    doctor.spec,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),

              ],
            ),
            const SizedBox(
              height: 5,
            ),

          ],
        ),
        const SizedBox(
          width: 35,
        ),

      ],
    ),
  ),
);


PreferredSizeWidget myappbar(
        {required String title, required BuildContext context}) =>
    AppBar(
      backgroundColor: Color(0xFFD7DCE7),
      centerTitle: true,
      elevation: 0.0,
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
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),

    );

Widget RegisterButton(
        {required String text,
        required VoidCallback func,
        required BuildContext context}) =>
    Container(
      width: 200,
      height: 55,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            blurRadius: 10,
            offset: Offset(1, 1),
            color: Colors.grey.withOpacity(0.5))
      ], color: Colors.white, borderRadius: BorderRadius.circular(60)),
      child: MaterialButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
              color: Color(0xff002984),
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
      ),
    );

Widget defultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required validate,
  required String text,
  required IconData icon,
  bool isPassword = false,
  bool isValidEmail = true,
}) =>
    TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: type,
      validator: validate,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        suffixIcon: Icon(
          icon,
          color: Colors.white,
          size: 27,
        ),
        labelText: text,
        labelStyle: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
