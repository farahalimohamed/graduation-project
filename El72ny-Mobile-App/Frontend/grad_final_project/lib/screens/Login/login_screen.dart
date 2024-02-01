import 'package:flutter/material.dart';
import 'components/login_form.dart';
import 'components/login_screen_top_image.dart';

class MobileLoginScreen extends StatelessWidget {
  final widid;
  final name;
  final image;
  final id;

  const MobileLoginScreen(
      {Key? key, this.widid, this.name, this.image, this.id})
      : super(key: key);

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
            const LoginScreenTopImage(),
            Row(
              children: [
                Spacer(),
                Expanded(
                  flex: 8,
                  child: LoginForm(
                    widid: widid,
                    name: name,
                    image: image,
                    id: id,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
