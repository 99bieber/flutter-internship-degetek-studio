import 'dart:io';

import 'package:aplikasi_magang/api/apiservice.dart';
import 'package:aplikasi_magang/const/constant.dart';
import 'package:aplikasi_magang/model/intership_dosen_model.dart';
import 'package:aplikasi_magang/model/intership_model.dart';
import 'package:aplikasi_magang/model/perusahaan_model.dart';
import 'package:aplikasi_magang/page/admin/menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shared_preferences/shared_preferences.dart';

class verifIntership extends StatefulWidget {
  Intershipdosen profile;

  verifIntership({this.profile});
  @override
  _verifIntershipState createState() => _verifIntershipState();
}

class _verifIntershipState extends State<verifIntership> {
  bool _isLoading = false;
  final TextEditingController _namaperusahaan = TextEditingController();
  final TextEditingController _nim1 = TextEditingController();
  final TextEditingController _nim2 = TextEditingController();
  final TextEditingController _nim3 = TextEditingController();
  final TextEditingController _date1 = TextEditingController();
  final TextEditingController _date2 = TextEditingController();
  final TextEditingController _dosen = TextEditingController();

  bool _isFieldnamaperusahaanValid;
  bool _isFieldnim1lValid;
  bool _isFieldnim2Valid;
  bool _isFieldnim3Valid;
  bool _isFieldDate1Valid;
  bool _isFieldDate2Valid;

  APIService _apiService = APIService();
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  Uri apiUrl = Uri.parse('https://0fbf00264d6c.ngrok.io/industri/daftar');

  String nim;
  Future<String> getUser1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nim = prefs.getString('nim') ?? "nim";
    });
  }

  Future<void> retriveLostData() async {
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file;
      });
    } else {
      print('Retrieve error ' + response.exception.code);
    }
  }

  @override
  void initState() {
    getUser1();
    if (widget.profile != null) {}
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.hintColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Daftar Magang"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // _buildTextFieldnamaperusahaan(),
                  // _buildTextFieldAlamat(),
                  // _buildTextFieldCP(),
                  _buildTextFieldDosen(),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    child: Text(
                      "Verifikasi",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      _apiService.verifIntershipdosen(
                          (widget.profile.id).toString(), _dosen.text);
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  LandingPageAdmin()),
                          (Route<dynamic> route) => false);
                    },
                    color: ColorPalette.hintColor,
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    child: Text(
                      "Tolak",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {},
                    color: Colors.red,
                  ),
                ],
              ),
            ),
            _isLoading
                ? Stack(
                    children: <Widget>[
                      Opacity(
                        opacity: 0.3,
                        child: ModalBarrier(
                          dismissible: false,
                          color: Colors.grey,
                        ),
                      ),
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFieldDosen() {
    return TextField(
      controller: _dosen,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorPalette.hintColor)),
        prefixIcon: Icon(
          Icons.person,
          color: ColorPalette.hintColor,
        ),
        labelStyle: TextStyle(color: ColorPalette.hintColor),
        labelText: "Dosen",
        errorText:
            _isFieldnamaperusahaanValid == null || _isFieldnamaperusahaanValid
                ? null
                : "Nama Dosen Wajib",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldnamaperusahaanValid) {
          setState(() => _isFieldnamaperusahaanValid = isFieldValid);
        }
      },
    );
  }
}
