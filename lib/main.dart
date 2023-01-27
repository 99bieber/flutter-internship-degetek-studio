import 'dart:convert';

import 'package:aplikasi_magang/model/logbook_model.dart';
import 'package:aplikasi_magang/page/admin/add_data_user.dart';
import 'package:aplikasi_magang/page/admin/data_user.dart';
import 'package:aplikasi_magang/page/admin/home.dart';
import 'package:aplikasi_magang/page/admin/menu.dart';
import 'package:aplikasi_magang/page/introPage.dart';
import 'package:aplikasi_magang/page/loginPage.dart';
import 'package:aplikasi_magang/page/user/add_perusahaan.dart';
import 'package:aplikasi_magang/page/user/data_perusahaan.dart';
import 'package:aplikasi_magang/page/user/home.dart';
import 'package:aplikasi_magang/page/user/home_notver.dart';
import 'package:aplikasi_magang/page/user/home_verProgress.dart';
import 'package:aplikasi_magang/page/user/log_book.dart';
import 'package:aplikasi_magang/page/user/menu.dart';
import 'package:aplikasi_magang/page/user/register_intership.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Widget _defaulthome;
void main() async {
  var url = "https://0fbf00264d6c.ngrok.io";
  var status1 = null;
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var role = prefs.getString('role');
  var status = prefs.getString('status');
  var nim = prefs.getString('nim');
  var res3 = await http.get("$url/industri/status/$nim");
  if (res3.statusCode == 200) {
    status1 = json.decode(res3.body);
    // status_data = (status1 as Map<String, dynamic>)['posts'];
    if (status1 == "belum diterima") {
    } else {
      prefs.setString("status", status1['Status']);
    }
  }
  var status2 = prefs.getString('status');
  print(role);
  print(status);

  if (role == "0") {
    _defaulthome = LandingPageAdmin();
  } else if (role == "1") {
    if (status2 == null) {
      _defaulthome = HomenotverUser();
    } else if (status2 == '0') {
      _defaulthome = HomeprogressUser();
    } else if (status2 == '1') {
      _defaulthome = LandingPageUser();
    }
  } else {
    _defaulthome = introPage();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: _defaulthome,
        routes: <String, WidgetBuilder>{
          '/intro': (BuildContext context) => new introPage(),
          '/login': (BuildContext context) => new LoginPage(),
          '/homeadmin': (BuildContext context) => new HomeAdmin(),
          '/homeuser': (BuildContext context) => new HomeUser(),
          '/homeusernover': (BuildContext context) => new HomenotverUser(),
          '/dataperusahaan': (BuildContext context) =>
              new PerusahaanFilterDemo(),
          '/datauser': (BuildContext context) => new UserFilterDemo(),
          '/adduser': (BuildContext context) => new EmployeeAdd(),
          '/daftarmagang': (BuildContext context) => new registerIntership(),
          '/createperusahaan': (BuildContext context) => new createPerusahaan(),
          '/menuuser': (BuildContext context) => new LandingPageUser(),
          '/menuadmin': (BuildContext context) => new LandingPageAdmin(),
          '/addlogbook': (BuildContext context) => new logBook(),
        });
  }
}
