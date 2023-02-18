import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_google/screen_flow/fire_store_screen.dart';
import 'package:flutter/material.dart';

import 'auth_screens/email_password_login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(
      const Duration(seconds: 2),
      () {
        if (user.uid.isEmpty) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const EmailPasswordLoginScreen(),
            ),
            (route) => false,
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const FireStoreScreen(),
            ),
            (route) => false,
          );
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            FlutterLogo(
              size: 100,
              style: FlutterLogoStyle.markOnly,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Firebase',
              style: TextStyle(
                color: Colors.black,
                fontSize: 45,
              ),
            )
          ],
        ),
      ),
    );
  }
}
