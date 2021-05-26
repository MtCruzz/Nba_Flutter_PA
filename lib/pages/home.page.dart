import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/pages/player.page.dart';
import 'package:demo/widgets/button.widget.dart';
import 'package:demo/widgets/textform.widget.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final auth = FirebaseAuth.instance;
  final inputController = TextEditingController();

  String name;

  @override
  void initState() {
    super.initState();
    this.getMostSearchPlayerFromApi();
  }

  Future<void> getMostSearchPlayerFromApi() async {
    var localName = '';
    var localCount = 0;

    var firestore = FirebaseFirestore.instance;

    var user = auth.currentUser;

    var userDocument = await firestore
        .collection('users')
        .where('email', isEqualTo: user.email)
        .get();

    firestore
        .collection('users/' + userDocument.docs[0].id + '/searches')
        .get()
        .then((value) {
      value.docs.forEach((e) {
        if (e.data()['count'] > localCount) {
          localName = e.data()['name'];
          localCount = e.data()['count'];
        }
      });
      setState(() {
        name = localName;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget favoritePlayer() {
      if (name?.isEmpty ?? true) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "You don't have a one yet",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ],
        );
      }
      var nameSplit = name.split(' ');
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
          Image.network(
            'https://nba-players.herokuapp.com/players/${nameSplit[1]}/${nameSplit[0]}',
            width: 130,
            height: 130,
          )
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('NBA Players'),
        automaticallyImplyLeading: false,
        actions: [
          FloatingActionButton(
            backgroundColor: Colors.blue[900],
            onPressed: () {
              auth.signOut();

              Navigator.of(context).pushNamed('/');
            },
            child: Icon(Icons.logout),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/nba_logo.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: TextForm(
                  controller: inputController,
                  hintText: 'PLAYER NAME',
                ),
              ),
              Container(
                child: Button(
                  onPress: () {
                    String playerName = inputController.text;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlayerPage(
                          playerName: playerName,
                        ),
                      ),
                    );
                    setState(() {
                      inputController.text = "";
                    });
                  },
                  title: 'SEARCH',
                ),
                margin: EdgeInsets.only(top: 20),
                width: 290,
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlayerPage(
                        playerName: name,
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[900],
                    border: Border.all(color: Colors.white),
                  ),
                  margin: EdgeInsets.only(top: 30),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          "Favorite player",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        favoritePlayer()
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
