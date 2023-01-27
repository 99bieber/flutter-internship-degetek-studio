import 'package:aplikasi_magang/const/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class introPage extends StatefulWidget {
  @override
  _introPageState createState() => _introPageState();
}

class _introPageState extends State<introPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.hintColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    "SiMagang",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        height: 1),
                  ),
                ),
                Container(
                  child: Text(
                    "daftar magang",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w300,
                        height: 1),
                  ),
                ),
                Container(
                  child: Text(
                    "ONLINE",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        height: 1),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Container(
                  alignment: Alignment.bottomCenter,
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/images/member-banner-cartoon.png'),
                          fit: BoxFit.cover)),
                ),
                Positioned(
                  bottom: 50,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        openMainPage();
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                        child: Text(
                          'Continue..',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void openMainPage() {
    Navigator.pushNamed(context, '/login');
  }
}
