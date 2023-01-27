import 'package:aplikasi_magang/const/constant.dart';
import 'package:aplikasi_magang/page/admin/data_user.dart';
import 'package:aplikasi_magang/page/admin/home.dart';
import 'package:aplikasi_magang/page/admin/more.dart';
import 'package:aplikasi_magang/page/admin/verificated_company.dart';
import 'package:aplikasi_magang/page/admin/verificated_intership%20copy.dart';
import 'package:aplikasi_magang/page/user/data_perusahaan.dart';
import 'package:aplikasi_magang/page/user/home.dart';
import 'package:flutter/material.dart';

class LandingPageAdmin extends StatefulWidget {
  @override
  _LandingPageAdminState createState() => new _LandingPageAdminState();
}

class _LandingPageAdminState extends State<LandingPageAdmin> {
  int _bottomNavCurrentIndex = 0;
  List<Widget> _container = [
    new HomeAdmin(),
    new UserFilterDemo(),
    new verifiedcompanyFilterDemo(),
    new verifiedintershipFilterDemo(),
    new more(),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: _container[_bottomNavCurrentIndex],
        bottomNavigationBar: _buildBottomNavigation());
  }

  Widget _buildBottomNavigation() {
    return new BottomNavigationBar(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        setState(() {
          _bottomNavCurrentIndex = index;
        });
      },
      currentIndex: _bottomNavCurrentIndex,
      items: [
        BottomNavigationBarItem(
          activeIcon: new Icon(
            Icons.home,
            color: ColorPalette.hintColor,
          ),
          icon: new Icon(
            Icons.home_outlined,
            color: ColorPalette.hintColor,
          ),
          title: new Text(
            'Beranda',
            style: TextStyle(color: ColorPalette.hintColor),
          ),
        ),
        BottomNavigationBarItem(
          activeIcon: new Icon(
            Icons.supervised_user_circle_rounded,
            color: ColorPalette.hintColor,
          ),
          icon: new Icon(
            Icons.supervised_user_circle_outlined,
            color: ColorPalette.hintColor,
          ),
          title: new Text(
            'User',
            style: TextStyle(color: ColorPalette.hintColor),
          ),
        ),
        BottomNavigationBarItem(
          activeIcon: new Icon(
            Icons.home_work_rounded,
            color: ColorPalette.hintColor,
          ),
          icon: new Icon(
            Icons.home_work_outlined,
            color: ColorPalette.hintColor,
          ),
          title: new Text(
            'Company',
            style: TextStyle(color: ColorPalette.hintColor),
          ),
        ),
        BottomNavigationBarItem(
          activeIcon: new Icon(
            Icons.people_alt_rounded,
            color: ColorPalette.hintColor,
          ),
          icon: new Icon(
            Icons.people_alt_outlined,
            color: ColorPalette.hintColor,
          ),
          title: new Text(
            'Intership',
            style: TextStyle(color: ColorPalette.hintColor),
          ),
        ),
        BottomNavigationBarItem(
          activeIcon: new Icon(
            Icons.list_alt_outlined,
            color: ColorPalette.hintColor,
          ),
          icon: new Icon(
            Icons.list_alt_outlined,
            color: ColorPalette.hintColor,
          ),
          title: new Text(
            'Lainnya',
            style: TextStyle(color: ColorPalette.hintColor),
          ),
        ),
      ],
    );
  }
}
