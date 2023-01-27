import 'dart:io';

import 'package:aplikasi_magang/api/apiservice.dart';
import 'package:aplikasi_magang/const/constant.dart';
import 'package:aplikasi_magang/model/intership_model.dart';
import 'package:aplikasi_magang/model/perusahaan_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shared_preferences/shared_preferences.dart';

class registerIntership extends StatefulWidget {
  Perusahaan profile;

  registerIntership({this.profile});
  @override
  _registerIntershipState createState() => _registerIntershipState();
}

class _registerIntershipState extends State<registerIntership> {
  bool _isLoading = false;
  final TextEditingController _namaperusahaan = TextEditingController();
  final TextEditingController _nim1 = TextEditingController();
  final TextEditingController _nim2 = TextEditingController();
  final TextEditingController _nim3 = TextEditingController();
  final TextEditingController _date1 = TextEditingController();
  final TextEditingController _date2 = TextEditingController();

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
    if (widget.profile != null) {
      _isFieldnamaperusahaanValid = true;
      _namaperusahaan.text = widget.profile.nama_industri;
      _isFieldnim1lValid = true;
      _nim1.text = nim;
    }
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
                  _buildTextFieldnamaperusahaan(),
                  _buildTextFieldnim1(),
                  _buildTextFieldnim2(),
                  _buildTextFieldnim3(),
                  _buildTextFieldDate1(),
                  _buildTextFieldDate2(),
                  _previewImage(),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    child: Text(
                      "Lampiran Gambar",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      _pickImage();
                    },
                    color: ColorPalette.hintColor,
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

  Widget _buildTextFieldnamaperusahaan() {
    return TextField(
      controller: _namaperusahaan,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorPalette.hintColor)),
        prefixIcon: Icon(
          Icons.home_work_rounded,
          color: ColorPalette.hintColor,
        ),
        labelStyle: TextStyle(color: ColorPalette.hintColor),
        labelText: "Nama Perusahaan",
        errorText:
            _isFieldnamaperusahaanValid == null || _isFieldnamaperusahaanValid
                ? null
                : "Nama Perusahaan Wajib",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldnamaperusahaanValid) {
          setState(() => _isFieldnamaperusahaanValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldnim1() {
    return TextField(
      controller: _nim1,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorPalette.hintColor)),
        prefixIcon: Icon(
          Icons.format_list_numbered_rounded,
          color: ColorPalette.hintColor,
        ),
        labelStyle: TextStyle(color: ColorPalette.hintColor),
        labelText: "NIM Ketua",
        errorText: _isFieldnim1lValid == null || _isFieldnim1lValid
            ? null
            : "NIM Ketua Dibutuhkan",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldnim1lValid) {
          setState(() => _isFieldnim1lValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldnim2() {
    return TextField(
      controller: _nim2,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorPalette.hintColor)),
        prefixIcon: Icon(
          Icons.format_list_numbered_rounded,
          color: ColorPalette.hintColor,
        ),
        labelStyle: TextStyle(color: ColorPalette.hintColor),
        labelText: "NIM Anggota 1",
        errorText: _isFieldnim2Valid == null || _isFieldnim2Valid
            ? null
            : "NIM Anggota 1 Dibutuhkan",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldnim2Valid) {
          setState(() => _isFieldnim2Valid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldnim3() {
    return TextField(
      controller: _nim3,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorPalette.hintColor)),
        prefixIcon: Icon(
          Icons.format_list_numbered_rounded,
          color: ColorPalette.hintColor,
        ),
        labelStyle: TextStyle(color: ColorPalette.hintColor),
        labelText: "NIM Anggota 2",
        errorText: _isFieldnim3Valid == null || _isFieldnim3Valid
            ? null
            : "NIM Anggota 2 Dibutuhkan",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldnim3Valid) {
          setState(() => _isFieldnim3Valid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldDate1() {
    return TextFormField(
      controller: _date1,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorPalette.hintColor)),
        prefixIcon: Icon(
          Icons.calendar_today,
          color: ColorPalette.hintColor,
        ),
        labelStyle: TextStyle(color: ColorPalette.hintColor),
        labelText: "Mulai",
        hintText: "Mulai Magang",
      ),
      onTap: () async {
        DateTime date = DateTime(1900);
        FocusScope.of(context).requestFocus(new FocusNode());

        date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100));

        _date1.text = date.toIso8601String();
      },
    );
  }

  Widget _buildTextFieldDate2() {
    return TextFormField(
      controller: _date2,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorPalette.hintColor)),
        prefixIcon: Icon(
          Icons.calendar_today,
          color: ColorPalette.hintColor,
        ),
        labelStyle: TextStyle(color: ColorPalette.hintColor),
        labelText: "Selesai",
        hintText: "Selesai Magang",
      ),
      onTap: () async {
        DateTime date = DateTime(1900);
        FocusScope.of(context).requestFocus(new FocusNode());

        date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100));

        _date2.text = date.toIso8601String();
      },
    );
  }

  Widget _previewImage() {
    if (_imageFile != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.file(
              File(_imageFile.path),
              width: 200,
              height: 200,
            ),
            SizedBox(
              height: 20,
              width: 20,
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0)),
              child: Text(
                "SUBMIT",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                _apiService.uploadImage(
                    _imageFile.path,
                    apiUrl,
                    _namaperusahaan.text,
                    _nim1.text,
                    _nim2.text,
                    _nim3.text,
                    _date1.text,
                    _date2.text);
                print(_imageFile.path);
              },
              color: ColorPalette.hintColor,
            ),
          ],
        ),
      );
    } else {
      return const Text(
        ' ',
        textAlign: TextAlign.center,
      );
    }
  }

  void _pickImage() async {
    try {
      final pickedFile = await _picker.getImage(source: ImageSource.gallery);
      setState(() {
        _imageFile = pickedFile;
      });
    } catch (e) {
      print("Image picker error " + e);
    }
  }
}
