import 'package:aplikasi_magang/api/apiservice.dart';
import 'package:aplikasi_magang/const/constant.dart';
import 'package:aplikasi_magang/page/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeAdmin extends StatefulWidget {
  @override
  _HomeAdminState createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  APIService apiService;
  BuildContext context;
  String nama;
  String email;
  Future<String> getUser1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nama = prefs.getString('nama') ?? "nama";
    });
  }

  @override
  void initState() {
    super.initState();
    apiService = APIService();
    getUser1();
  }

  @override
  Widget build(BuildContext context) {
    setState(() => this.context = context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: ColorPalette.hintColor,
        elevation: 0,
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () async {
      //     logout();
      //   },
      //   icon: Icon(Icons.account_circle),
      //   label: Text("Logout"),
      //   backgroundColor: Colors.red,
      // ),
      body: Column(children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
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
                  "Hello, $nama",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'circe',
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                // Text(
                //   "Dashboard",
                //   style: TextStyle(
                //       fontSize: 30,
                //       fontFamily: 'circe',
                //       fontWeight: FontWeight.w700,
                //       color: Colors.white),
                // ),
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
        Expanded(
            child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Hai, Admin"),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                ),
              )
            ],
          ),
        ))
      ],
    );
  }

  void logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear().then(
          (_) => Navigator.of(context).pushReplacementNamed('/login'),
        );
  }
}
