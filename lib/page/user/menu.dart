import 'package:aplikasi_magang/const/constant.dart';
import 'package:aplikasi_magang/page/admin/home.dart';
import 'package:aplikasi_magang/page/user/data_logbook.dart';
import 'package:aplikasi_magang/page/user/data_perusahaan.dart';
import 'package:aplikasi_magang/page/user/home.dart';
import 'package:aplikasi_magang/page/user/log_book.dart';
import 'package:flutter/material.dart';

class LandingPageUser extends StatefulWidget {
  @override
  _LandingPageUserState createState() => new _LandingPageUserState();
}

class _LandingPageUserState extends State<LandingPageUser> {
  int _bottomNavCurrentIndex = 0;
  String status = null;
  List<Widget> _container = [
    new HomeUser(),
    new LogbookFilterDemo(),
    // new logbook(),
  ];
  // void page() {
  //   if (status == null) {
  //     _container = [
  //       new HomeUser(),
  //       new PerusahaanFilterDemo(),
  //       new logbook(),
  //     ];
  //   } else {}
  // }

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
            Icons.book,
            color: ColorPalette.hintColor,
          ),
          icon: new Icon(
            Icons.book_outlined,
            color: Colors.grey,
          ),
          title: new Text(
            'LogBook',
            style: TextStyle(color: ColorPalette.hintColor),
          ),
        ),
      ],
    );
  }
}
