import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/models/player.dart';
import 'package:demo/widgets/headerinfo.widget.dart';
import 'package:demo/widgets/statslinefourinfos.widget.dart';
import 'package:demo/widgets/statslinethreeinfos.widget.dart';
import 'package:demo/widgets/statslinetwoinfos.widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({Key key, this.playerName}) : super(key: key);

  final String playerName;

  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  Player player;
  String firstName;
  String lastName;

  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    this.getPlayerFromAPI();
  }

  Future<void> updateAnalyticsData(Player p) async {
    var firestore = FirebaseFirestore.instance;
    var name = p.name.trim();

    var user = auth.currentUser;

    var userDocument = await firestore
        .collection('users')
        .where('email', isEqualTo: user.email)
        .get();

    firestore
        .collection('users/' + userDocument.docs[0].id + '/searches')
        .doc(name)
        .get()
        .then((value) => {
              if (value.exists)
                {
                  firestore
                      .collection(
                          'users/' + userDocument.docs[0].id + '/searches')
                      .doc(name)
                      .update({"count": ++value.data()["count"]})
                }
              else
                {
                  firestore
                      .collection(
                          'users/' + userDocument.docs[0].id + '/searches')
                      .doc(name)
                      .set({"name": p.name, "count": 1})
                }
            });
  }

  Future<void> getPlayerFromAPI() async {
    try {
      final playerS = widget.playerName.split(' ');
      final response = await http.get(Uri.https('nba-players.herokuapp.com',
          'players-stats/${playerS[1]}/${playerS[0]}'));

      if (response.statusCode == 200) {
        final p = Player.fromJson(jsonDecode(response.body));
        this.updateAnalyticsData(p);
        final splitedName = p.name.split(' ');
        setState(() {
          player = p;

          firstName = splitedName[0];
          lastName = splitedName[1];
        });
      } else {
        setState(() {
          player = new Player();
        });
      }
    } catch (e) {
      setState(() {
        player = new Player(name: '');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (player == null) return Container(child: CircularProgressIndicator());

    if (player.name.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text("${widget.playerName}"),
        ),
        body: Center(
          child: Text("Player '${widget.playerName}' not found"),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pushNamed('/home'),
        ),
        title: Text('$firstName $lastName'),
      ),
      body: ListView(
        children: [
          HeaderInfo(
            firstName: firstName,
            lastName: lastName,
            teamName: player?.teamName,
          ),
          StatsLineFourInfos(
            firstInfoName: 'MPG',
            firstInfoValue: player?.mpg ?? '',
            secondInfoName: 'PPG',
            secondInfoValue: player?.ppg ?? '',
            thirdInfoName: 'APG',
            thirdInfoValue: player?.apg ?? '',
            fourthInfoName: 'RPG',
            fourthInfoValue: player?.rpg ?? '',
          ),
          StatsLineThreeInfos(
            firstInfoName: 'FGA',
            firstInfoValue: player?.fga ?? '',
            secondInfoName: 'FGM',
            secondInfoValue: player?.fgm ?? '',
            thirdInfoName: 'FGP',
            thirdInfoValue: player?.fgp ?? '',
          ),
          StatsLineFourInfos(
            firstInfoName: 'TPA',
            firstInfoValue: player?.tpa ?? '',
            secondInfoName: 'TPM',
            secondInfoValue: player?.tpm ?? '',
            thirdInfoName: 'TPP',
            thirdInfoValue: player?.tpp ?? '',
            fourthInfoName: 'FTP',
            fourthInfoValue: player?.ftp ?? '',
          ),
          StatsLineTwoInfos(
            firstInfoName: 'OR',
            firstInfoValue: player?.or ?? '',
            secondInfoName: 'DR',
            secondInfoValue: player?.dr ?? '',
          ),
          StatsLineThreeInfos(
            firstInfoName: 'SPG',
            firstInfoValue: player?.stl ?? '',
            secondInfoName: 'BPG',
            secondInfoValue: player?.blk ?? '',
            thirdInfoName: 'TPG',
            thirdInfoValue: player?.to ?? '',
          ),
        ],
      ),
    );
  }
}
