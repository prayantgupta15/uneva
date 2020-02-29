import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uneva/User.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:uneva/UserDetails.dart';

class noteDetails extends StatefulWidget {
  User user;

  noteDetails(this.user);

  @override
  _noteDetailsState createState() => _noteDetailsState(user);
}

class _noteDetailsState extends State<noteDetails> {
  User user;
  double screenWidth, screenHeight;

  _noteDetailsState(this.user);

  Future<UserDetails> _getUserDetails(User user) async {
    int id = user.other.pid;
    debugPrint("NOTES DETAISL:" + id.toString());
    var url = "http://dev.uneva.in/task_721/patient.php?id=";
    url = url + id.toString();
    var data = await (http.get(url));
    var jsonData;
    jsonData = json.decode(data.body);
    print(jsonData);
    UserDetails ud;
    ud = UserDetails.fromJSON(jsonData);
    print(ud.person_full_name);

    return ud;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return new FutureBuilder(
        future: _getUserDetails(user),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return ListView(
              children: <Widget>[
                Container(
                    //child: Text("Loading..")
                    ),
              ],
            );
          } else {
            return Scaffold(
                appBar: AppBar(
                  title: Text(snapshot.data.person_full_name,
                      style: TextStyle(fontSize: 18.0)),
                  actions: <Widget>[
                    Icon(
                      Icons.edit,
                      size: 20.0,
                    )
                  ],
                  automaticallyImplyLeading: false,
                ),
                body: Container(
                  color: Colors.white70,
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 120.0,
                        height: 120.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: snapshot.data.person_pic == null
                                    ? AssetImage('assets/images/dp.png')
                                    : NetworkImage(snapshot.data.person_pic),
                                fit: BoxFit.cover)),
                      ),
                      Container(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("PID"),
                                Text("Name"),
                                Text("Gender"),
                                Text("Age"),
                                Text("Phone"),
                                Text("S/O"),
                                Text("Address")
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  snapshot.data.person_pid,
                                  style: TextStyle(fontFamily: "Roboto"),
                                ),
                                Text(snapshot.data.person_full_name
                                    .toString()
                                    .toUpperCase()),
                                Text(snapshot.data.person_gender),
                                Text(snapshot.data.person_age),
                                Text(snapshot.data.person_phone),
                                Text(snapshot.data.person_relation),
                                Text(snapshot.data.person_address)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ));
          }
        });
  }
}
