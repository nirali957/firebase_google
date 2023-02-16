import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailPasswordSignInScreen extends StatefulWidget {
  const EmailPasswordSignInScreen({Key? key}) : super(key: key);

  @override
  State<EmailPasswordSignInScreen> createState() => _EmailPasswordSignInScreenState();
}

class _EmailPasswordSignInScreenState extends State<EmailPasswordSignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Enter Email",
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.black87),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: "Enter password",
                  labelText: "password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.black87),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  userSignIn();
                },
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(const Size(220, 50)),
                ),
                child: const Text("Sign In"),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Already have a account",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  userSignIn() async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      debugPrint("currentUser --------- ${auth.currentUser}");
      if (!auth.currentUser!.emailVerified) {
        debugPrint("Send Email ---- ");
        await auth.currentUser!.sendEmailVerification();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      }
    } catch (e) {
      debugPrint("------>> $e");
    }
  }
}
