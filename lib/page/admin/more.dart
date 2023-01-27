import 'package:aplikasi_magang/const/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class more extends StatefulWidget {
  @override
  _moreState createState() => _moreState();
}

class _moreState extends State<more> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.hintColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Lainnya"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0)),
                  child: Text(
                    "Intership Progress",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {},
                  color: ColorPalette.hintColor,
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0)),
                  child: Text(
                    "Intership Done",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {},
                  color: ColorPalette.hintColor,
                ),
              ],
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0)),
              child: Text(
                "Logout",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                await preferences.clear().then(
                      (_) =>
                          Navigator.of(context).pushReplacementNamed('/login'),
                    );
              },
              color: ColorPalette.hintColor,
            ),
          ],
        ),
      ),
    );
  }
}
