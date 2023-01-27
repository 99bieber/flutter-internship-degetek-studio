import 'dart:convert';

import 'package:aplikasi_magang/api/apiservice.dart';
import 'package:aplikasi_magang/const/constant.dart';
import 'package:aplikasi_magang/page/loginPage.dart';
import 'package:aplikasi_magang/page/user/data_perusahaan.dart';
import 'package:aplikasi_magang/page/user/home_verProgress.dart';
import 'package:aplikasi_magang/page/user/menu.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomenotverUser extends StatefulWidget {
  @override
  _HomenotverUserState createState() => _HomenotverUserState();
}

class _HomenotverUserState extends State<HomenotverUser> {
  APIService apiService;
  BuildContext context;
  String nama;
  String nim;
  String status;
  Future<String> getUser1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nama = prefs.getString('nama') ?? "nama";
      nim = prefs.getString('nim') ?? "nim";
      status = prefs.getString('status') ?? 'Kosong';
    });
  }

  @override
  void initState() {
    super.initState();
    apiService = APIService();
    getUser1();
  }

  @override
  // Widget build(BuildContext context) {
  //   if (status == null) {
  //     new Container();
  //   }
  // }

  Widget build(BuildContext context) {
    setState(() => this.context = context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Dashboard",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: ColorPalette.hintColor,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: () async {
              var url = "https://0fbf00264d6c.ngrok.io";
              var status1 = null;
              SharedPreferences prefs = await SharedPreferences.getInstance();
              var nim = prefs.getString("nim");
              var res3 = await http.get("$url/industri/status/$nim");
              if (res3.statusCode == 200) {
                status1 = json.decode(res3.body);
                // status_data = (status1 as Map<String, dynamic>)['posts'];
                if (status1 == "belum diterima") {
                } else {
                  prefs.setString("status", status1['Status']);
                }
              }
              var status = prefs.getString('status');
              print("masuk");

              if (status == '0') {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => HomeprogressUser()),
                    (Route<dynamic> route) => false);
              } else if (status == '1') {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => LandingPageUser()),
                    (Route<dynamic> route) => false);
              }
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          logout();
        },
        icon: Icon(Icons.exit_to_app),
        label: Text("Logout"),
        backgroundColor: ColorPalette.hintColor,
      ),
      body: Column(children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.15,
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
                  "$nama",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'circe',
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  "$nim",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'circe',
                    color: Colors.white,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(padding: EdgeInsets.all(20.0)),
        Text(
          "Anda Belum Diterima Magang",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'circe',
            color: ColorPalette.hintColor,
            fontWeight: FontWeight.w900,
          ),
        ),
        Text(
          "Daftar Dibawah ini",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'circe',
            color: ColorPalette.hintColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0)),
          child: Text(
            "Daftar Magang",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PerusahaanFilterDemo()),
            );
          },
          color: ColorPalette.hintColor,
        ),
      ]),
    );
  }

  Widget profileView() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(30, 50, 30, 30),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
          child: Column(
            children: <Widget>[],
          ),
        ),
      ],
    );
  }

  void logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => new LoginPage()),
    );
  }
}
