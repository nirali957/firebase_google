import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoginScreen extends StatefulWidget {
  const GoogleLoginScreen({Key? key}) : super(key: key);

  @override
  State<GoogleLoginScreen> createState() => _GoogleLoginScreenState();
}

class _GoogleLoginScreenState extends State<GoogleLoginScreen> {
  GoogleSignInAccount? currentUser;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

  bool isSignIn = false;
  bool google = false;

  @override
  void initState() {
    // TODO: implement initState
    successGoogle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () async {
                  await signInWithGoogle();

                  // debugPrint("Auth ----------->> ${auth.currentUser!.displayName}");
                },
                child: Container(
                  width: 200,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black,
                  ),
                  child: const Text(
                    'Sign in with Google',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ---- Social Google Login ------------>>>
  signInWithGoogle() {
    googleSignIn.signIn();
  }

  void successGoogle() {
    googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) async {
      currentUser = account;

      if (currentUser != null) {
        debugPrint('''
          Google Logged in!
          Google Id: ${currentUser!.id}
          Email: ${currentUser!.email};
          Name: ${currentUser!.displayName ?? ""};
          Profile Pic: ${currentUser!.photoUrl ?? ""};
      ''');

        final GoogleSignInAuthentication? googleAuth = await currentUser?.authentication;

        debugPrint("Google Auth accessToken ------------->>>${googleAuth!.accessToken}");
        debugPrint("Google Auth idToken ------------->>>${googleAuth.idToken}");

        OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        debugPrint("credential ------------->>>$credential");

        await auth.signInWithCredential(credential);

        await account!.clearAuthCache();
        await googleSignIn.disconnect();
        await googleSignIn.signOut();
        currentUser = null;
      }
    });
  }

  /*Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    debugPrint("Google Auth accessToken ------------->>>${googleAuth!.accessToken}");
    debugPrint("Google Auth idToken ------------->>>${googleAuth.idToken}");

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    debugPrint("credential ------------->>>$credential");

    googleSignIn.disconnect();

    // Once signed in, return the UserCredential
    return await auth.signInWithCredential(credential);
  }*/
}
