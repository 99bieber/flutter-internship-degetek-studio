import 'package:aplikasi_magang/api/apiservice.dart';
import 'package:aplikasi_magang/const/constant.dart';
import 'package:aplikasi_magang/page/loginPage.dart';
import 'package:aplikasi_magang/page/user/data_perusahaan.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeUser extends StatefulWidget {
  @override
  _HomeUserState createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {
  APIService apiService;
  BuildContext context;
  String nama;
  String nim;
  String status;
  String dosen;
  Future<String> getUser1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nama = prefs.getString('nama') ?? "nama";
      nim = prefs.getString('nim') ?? "nim";
      status = prefs.getString('status') ?? 'Kosong';
      dosen = prefs.getString('dosen') ?? 'kosong';
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
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          logout();
        },
        icon: Icon(Icons.account_circle),
        label: Text("Logout"),
        backgroundColor: ColorPalette.hintColor,
      ),
      body: Column(children: [
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
                Text(
                  "Dosen Pembimbing :",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'circe',
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  "$dosen",
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
