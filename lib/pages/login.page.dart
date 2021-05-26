import 'package:demo/pages/home.page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sign_button/sign_button.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final auth = FirebaseAuth.instance;
  var firestore = FirebaseFirestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    Widget myFirebaseForm() {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/nba_logo.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SignInButton(
                  buttonType: ButtonType.google,
                  imagePosition: ImagePosition.left,
                  buttonSize: ButtonSize.large,
                  btnTextColor: Colors.black,
                  btnColor: Colors.white,
                  width: 230,
                  btnText: 'Login with google',
                  onPressed: () async {
                    try {
                      final GoogleSignInAccount googleSignInAccount =
                          await googleSignIn.signIn();
                      final GoogleSignInAuthentication
                          googleSignInAuthentication =
                          await googleSignInAccount.authentication;

                      final AuthCredential credential =
                          GoogleAuthProvider.credential(
                        accessToken: googleSignInAuthentication.accessToken,
                        idToken: googleSignInAuthentication.idToken,
                      );
                      var user = await auth.signInWithCredential(credential);

                      var userDocument = await firestore
                          .collection('users')
                          .where('email', isEqualTo: user.user.email)
                          .get();

                      if (userDocument.docs.isEmpty) {
                        firestore
                            .collection('users')
                            .add({'email': user.user.email}).then((value) => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Home(),
                                    ),
                                  )
                                });
                      } else {
                        Navigator.of(context).pushNamed('/home');
                      }
                    } catch (e) {
                      print("Error on signin with google " + e);
                    }
                  }),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        automaticallyImplyLeading: false,
      ),
      body: myFirebaseForm(),
    );
  }
}
