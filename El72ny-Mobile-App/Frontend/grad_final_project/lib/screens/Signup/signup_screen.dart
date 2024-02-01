import 'package:flutter/material.dart';
import '../Signup/components/Signup_form.dart';
import '../Login/components/login_screen_top_image.dart';

class MobileSignupScreen extends StatelessWidget {
  const MobileSignupScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff566CA6),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xff566CA6),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Color.fromARGB(255, 255, 255, 255),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Column(
            //   children: [
            //     Row(
            //       children: const [
            //         Spacer(),
            //         Expanded(
            //           flex: 8,
            //           child: Image(
            //             image: AssetImage("assets/images/login2.png"),
            //           ),
            //         ),
            //         Spacer(),
            //       ],
            //     ),
            //     const SizedBox(height: 15),
            //   ],
            // ),
            Row(
              children: const [
                Spacer(),
                Expanded(
                  flex: 8,
                  child: SignUpForm(),
                ),
                Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
