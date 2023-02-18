import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({Key? key}) : super(key: key);

  @override
  State<FireStoreScreen> createState() => _FireStoreScreenState();
}

class _FireStoreScreenState extends State<FireStoreScreen> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(
                  const Size(150, 50),
                ),
              ),
              onPressed: () {
                sendData();
              },
              child: const Text(
                'send data',
                style: TextStyle(fontSize: 25),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(
                  const Size(150, 50),
                ),
              ),
              onPressed: () {
                addData();
              },
              child: const Text(
                'Add Student data',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  sendData() {
    CollectionReference users = firebaseFirestore.collection('users');

    return users
        .doc('first')
        .set({
          'name': 'abc',
          'company': 'qyz',
          'age': 45,
        })
        .then((value) => debugPrint('user Added'))
        .catchError((error) => debugPrint('failed to add:$error'));
  }

  addData() {
    CollectionReference student = firebaseFirestore.collection('student');

    return
        // student
        //   .add({
        //     'name': 'om',
        //     'surname': 'shah',
        //     'age': 16,
        //     'PR': 89,
        //     'grade': 'A1',
        //     'work': [1, 2, 3, 4, 5],
        //   })
        //   .then((value) => debugPrint("student Added"))
        //   .catchError((error) => debugPrint("Failed to add user: $error"));

        student
            .doc('class c')
            .set({
              'name': 'man',
              'surname': 'shah',
              'age': 16,
              'PR': 89,
              'grade': 'A1',
            })
            .then((value) => debugPrint('Student Added'))
            .catchError((error) => debugPrint('some error to add:$error'));
  }
}
