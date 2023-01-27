import 'package:aplikasi_magang/api/apiservice.dart';
import 'package:aplikasi_magang/const/constant.dart';
import 'package:aplikasi_magang/const/shared_service.dart';
import 'package:aplikasi_magang/model/intership_model.dart';
import 'package:aplikasi_magang/model/logbook_model.dart';
import 'package:aplikasi_magang/model/perusahaan_model.dart';
import 'package:aplikasi_magang/page/admin/menu.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class verifiedcompanyFilterDemo extends StatefulWidget {
  verifiedcompanyFilterDemo() : super();

  final String title = "Filter List Demo";

  @override
  verifiedcompanyFilterDemoState createState() =>
      verifiedcompanyFilterDemoState();
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

class verifiedcompanyFilterDemoState extends State<verifiedcompanyFilterDemo> {
  final _debouncer = Debouncer(milliseconds: 100);
  List<Perusahaan> users = List();
  List<Perusahaan> filteredUsers = List();

  @override
  void initState() {
    super.initState();
    APIService.getPerusahaan1().then((perusahaanFromServer) {
      setState(() {
        users = perusahaanFromServer;
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
        actions: <Widget>[],
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
                    "Data Perusahaan",
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
                                hintText: "Search Nama Industri"),
                            onChanged: (string) {
                              _debouncer.run(() {
                                setState(() {
                                  filteredUsers = users
                                      .where((u) => (u.nama_industri
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
                Perusahaan profile = filteredUsers[index];
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
                            profile.nama_industri,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            profile.alamat.toLowerCase(),
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
                                              "Are you sure want to verified this company ${profile.nama_industri}?"),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text("Yes"),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pushReplacementNamed(
                                                        '/menuadmin');
                                                APIService.updatePrusahaan(
                                                        filteredUsers[index].id)
                                                    .then((isSuccess) {
                                                  if (isSuccess) {
                                                    setState(() {});
                                                    Scaffold.of(this.context)
                                                        .showSnackBar(SnackBar(
                                                            content: Text(
                                                                "Update Data Success")));
                                                  } else {
                                                    Scaffold.of(this.context)
                                                        .showSnackBar(SnackBar(
                                                            content: Text(
                                                                "Update data failed")));
                                                  }
                                                });
                                              },
                                            ),
                                            FlatButton(
                                              child: Text("No"),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pushAndRemoveUntil(
                                                        MaterialPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                LandingPageAdmin()),
                                                        (Route<dynamic>
                                                                route) =>
                                                            false);
                                              },
                                            )
                                          ],
                                        );
                                      });
                                },
                                child: Text(
                                  "Verified",
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
