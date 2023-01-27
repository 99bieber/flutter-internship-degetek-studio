import 'dart:convert';

import 'package:aplikasi_magang/api/apiservice.dart';
import 'package:aplikasi_magang/const/constant.dart';
import 'package:aplikasi_magang/const/shared_service.dart';
import 'package:aplikasi_magang/model/login_model.dart';
import 'package:aplikasi_magang/page/admin/home.dart';
import 'package:aplikasi_magang/page/admin/menu.dart';
import 'package:aplikasi_magang/page/user/home.dart';
import 'package:aplikasi_magang/page/user/home_notver.dart';
import 'package:aplikasi_magang/page/user/home_verProgress.dart';
import 'package:aplikasi_magang/page/user/menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _userController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool hidePassword = true;
  bool _isLoading = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  LoginRequestModel loginRequestModel;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    loginRequestModel = new LoginRequestModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(child: _uiSetup(context)));
  }

  signIn(String user, pass) async {
    final url = "https://0fbf00264d6c.ngrok.io";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {'username': user, 'password': pass};
    print(data);
    var jsonResponse = null;
    var userData = null;
    var profile = null;
    var status1 = null;
    var status_data = null;
    var response = await http.post("$url/login", body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      userData = (jsonResponse as Map<String, dynamic>)['posts'];
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        sharedPreferences.setString("role", userData['role']);
        sharedPreferences.setInt("id", userData['id']);
        sharedPreferences.setString("nim", userData['user']);
        var id = sharedPreferences.getInt("id");
        print("$id");
        if ("$id" != null) {
          var res2 = await http.get("$url/login/$id");
          if (res2.statusCode == 200) {
            profile = json.decode(res2.body);
          }
          sharedPreferences.setString("nama", profile['nama']);
          sharedPreferences.setInt("idmhs", profile['id']);
          var nama = sharedPreferences.getString("nama");
          print(nama);
        }
        var nim = sharedPreferences.getString('nim');
        var res3 = await http.get("$url/industri/status/$nim");
        if (res3.statusCode == 200) {
          status1 = json.decode(res3.body);
          // status_data = (status1 as Map<String, dynamic>)['posts'];
          if (status1 == "belum diterima") {
          } else {
            sharedPreferences.setString("status", status1['Status']);
            sharedPreferences.setString("dosen", status1['Dosen']);
          }
        }
        print(status1);
        var status2 = sharedPreferences.getString('status');
        print("status = $status2");
        var role = sharedPreferences.getString('role');
        print(role);
        if (role == "0") {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => LandingPageAdmin()),
              (Route<dynamic> route) => false);
        } else if (role == "1") {
          if (status2 == null) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) => HomenotverUser()),
                (Route<dynamic> route) => false);
          } else if (status2 == "0") {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) => HomeprogressUser()),
                (Route<dynamic> route) => false);
          } else if (status2 == "1") {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) => LandingPageUser()),
                (Route<dynamic> route) => false);
          }
        }
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }

  Widget _uiSetup(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  margin: EdgeInsets.symmetric(vertical: 85, horizontal: 20),
                  color: Colors.white,
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(20),
                  //   color: Colors.white,
                  //   boxShadow: [
                  //     BoxShadow(
                  //         color: Theme.of(context).hintColor.withOpacity(0.2),
                  //         offset: Offset(0, 10),
                  //         blurRadius: 20)
                  //   ],
                  // ),
                  child: Form(
                    key: globalFormKey,
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Login",
                          style: TextStyle(
                              color: ColorPalette.hintColor,
                              fontSize: 40,
                              fontWeight: FontWeight.w800,
                              height: 1),
                        ),
                        Image.asset(
                          "assets/images/member-banner-cartoon.png",
                          // width: 150.0,
                          // height: 150.0,
                        ),
                        SizedBox(height: 20),
                        new TextFormField(
                          controller: _userController,
                          decoration: new InputDecoration(
                            hintText: "NIM/NIP",
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: ColorPalette.hintColor)),
                            prefixIcon: Icon(
                              Icons.supervised_user_circle_outlined,
                              color: ColorPalette.hintColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        new TextFormField(
                          controller: _passwordController,
                          style: TextStyle(color: ColorPalette.hintColor),
                          keyboardType: TextInputType.text,
                          validator: (input) => input.length < 3
                              ? "Password should be more than 3 characters"
                              : null,
                          obscureText: hidePassword,
                          decoration: new InputDecoration(
                            hintText: "Password",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorPalette.hintColor
                                        .withOpacity(0.4))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: ColorPalette.hintColor)),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: ColorPalette.hintColor,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              color: ColorPalette.hintColor.withOpacity(0.4),
                              icon: Icon(hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        FlatButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 100),
                          onPressed: () async {
                            setState(() {
                              _isLoading = true;
                            });
                            signIn(
                                _userController.text, _passwordController.text);
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: ColorPalette.hintColor,
                          shape: StadiumBorder(),
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
