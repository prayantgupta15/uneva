import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uneva/noteDetail.dart';
import 'package:uneva/User.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class notelist extends StatefulWidget {
  @override
  _notelistState createState() => _notelistState();
}

class _notelistState extends State<notelist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ECHO-ALL', style: TextStyle(fontSize: 18.0)),
      ),
      body: Stack(
        children: <Widget>[
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Waiting: 5",
                    style: TextStyle(fontSize: 14.0),
                  )
                ],
              )),
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Completed: 4",
                    style: TextStyle(fontSize: 14.0),
                  )
                ],
              )),
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Total: 9",
                    style: TextStyle(fontSize: 14.0),
                  )
                ],
              )),
            ],
          )),
          getNoteListView(),
        ],
      ),
    );
  }

  int ctr = 0;

  Widget getNoteListView() {
    return Container(
      padding: EdgeInsets.only(top: 15.0),
      child: FutureBuilder(
        future: _getUsers(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(child: Text("Loading..."));
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 4.0,
                    child: (ListTile(
                      title: Text(snapshot.data[index].name),
                      subtitle: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(snapshot.data[index].description)
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(snapshot.data[index].createdAt)
                              ],
                            ),
                          )
                        ],
                      ),
                      leading: Text(
                        snapshot.data[index].tokenName,
                        style: TextStyle(color: Colors.red, fontSize: 30.0),
                      ),
                      trailing: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Icon(
                            Icons.more_vert,
                            //color: (snapshot.data[index].status ==1 ? (Colors.green): (Colors.red )),
                          ),
                          Icon(
                            Icons.check_circle,
                            color: (snapshot.data[index].status == 1
                                ? (Colors.green)
                                : (Colors.red)),
                          ),
                        ],
                      ),
                      onTap: () {
                        debugPrint(snapshot.data[index].other.pid.toString());
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return noteDetails(snapshot.data[index]);
                        }));
                      },
                    )),
                  );
                });
          }
        },
      ),
    );
  }

  Future<List<User>> _getUsers() async {
    var data = await (http.get("http://dev.uneva.in/task_721/list.php"));
    var jsonData = json.decode(data.body);

    List<User> users = [];

    for (var i in jsonData) {
      users.add(User.fromJSON(i));
    }

    users.sort((a, b) => a.tokenNumber.compareTo(b.tokenNumber));
    print(users.length);

    //debugPrint(jsonData);
    return users;
  }
}
