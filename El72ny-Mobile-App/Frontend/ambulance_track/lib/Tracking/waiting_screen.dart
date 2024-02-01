import 'package:flutter/material.dart';

class Waiting_Screen extends StatelessWidget {
  const Waiting_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('No requests yet!', style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.black54,
            ),
            ),
            SizedBox(height: 20.0,),
            Container(
              width: 200.0,
              height: 200.0,
              child:
              Image.asset('assets/img/wait.png'),
            ),
          ],
        ),
      ),
    );
  }
}
