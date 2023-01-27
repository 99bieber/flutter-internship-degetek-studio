import 'package:aplikasi_magang/api/apiservice.dart';
import 'package:aplikasi_magang/const/constant.dart';
import 'package:aplikasi_magang/const/shared_service.dart';
import 'package:aplikasi_magang/model/user_model.dart';
import 'package:aplikasi_magang/page/admin/edit_user.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class UserFilterDemo extends StatefulWidget {
  UserFilterDemo() : super();

  final String title = "Filter List Demo";

  @override
  UserFilterDemoState createState() => UserFilterDemoState();
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class UserFilterDemoState extends State<UserFilterDemo> {
  final _debouncer = Debouncer(milliseconds: 100);
  List<User> users = List();
  List<User> filteredUsers = List();

  @override
  void initState() {
    super.initState();
    APIService.getUser().then((usersFromServer) {
      setState(() {
        users = usersFromServer;
        filteredUsers = users;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ColorPalette.hintColor,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/adduser');
            },
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: ColorPalette.hintColor,
                borderRadius: new BorderRadius.only(
                  bottomLeft: const Radius.circular(20.0),
                  bottomRight: const Radius.circular(20.0),
                )),
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Data User",
                    style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'circe',
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  Expanded(child: Container()),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.search,
                            color: ColorPalette.hintColor,
                            size: 20,
                          ),
                          onPressed: () {},
                        ),
                        Expanded(
                          child: TextField(
                            style: TextStyle(fontSize: 18, fontFamily: 'circe'),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search NIM/NAMA"),
                            onChanged: (string) {
                              _debouncer.run(() {
                                setState(() {
                                  filteredUsers = users
                                      .where((u) => (u.name
                                              .toLowerCase()
                                              .contains(string.toLowerCase()) ||
                                          u.email
                                              .toLowerCase()
                                              .contains(string.toLowerCase())))
                                      .toList();
                                });
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: filteredUsers.length,
              itemBuilder: (BuildContext context, int index) {
                User profile = filteredUsers[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            profile.name,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            profile.email.toLowerCase(),
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("Warning"),
                                          content: Text(
                                              "Are you sure want to delete data profile ${profile.name}?"),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text("Yes"),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pushReplacementNamed(
                                                        '/datauser');
                                                APIService.deleteProfile(
                                                        filteredUsers[index].id)
                                                    .then((isSuccess) {
                                                  if (isSuccess) {
                                                    setState(() {});
                                                    Scaffold.of(this.context)
                                                        .showSnackBar(SnackBar(
                                                            content: Text(
                                                                "Delete data success")));
                                                  } else {
                                                    Scaffold.of(this.context)
                                                        .showSnackBar(SnackBar(
                                                            content: Text(
                                                                "Delete data failed")));
                                                  }
                                                });
                                              },
                                            ),
                                            FlatButton(
                                              child: Text("No"),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pushReplacementNamed(
                                                        '/datauser');
                                              },
                                            )
                                          ],
                                        );
                                      });
                                },
                                child: Text(
                                  "Delete",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                              FlatButton(
                                onPressed: () async {
                                  print(profile);
                                  var result = await Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return FormAddScreen(profile: profile);
                                  }));
                                  if (result != null) {
                                    setState(() {});
                                  }
                                },
                                child: Text(
                                  "Edit",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
