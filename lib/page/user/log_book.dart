import 'dart:io';

import 'package:aplikasi_magang/api/apiservice.dart';
import 'package:aplikasi_magang/const/constant.dart';
import 'package:aplikasi_magang/model/intership_model.dart';
import 'package:aplikasi_magang/model/logbook_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shared_preferences/shared_preferences.dart';

class logBook extends StatefulWidget {
  logbook profile;

  logBook({this.profile});
  @override
  _logBookState createState() => _logBookState();
}

class _logBookState extends State<logBook> {
  bool _isLoading = false;
  final TextEditingController _date = TextEditingController();
  final TextEditingController _kegiatan = TextEditingController();
  final TextEditingController _kendala = TextEditingController();
  final TextEditingController _solusi = TextEditingController();
  var id;
  bool _isFieldDateValid;
  bool _isFieldkegiatanlValid;
  bool _isFieldkendalaValid;
  bool _isFieldsolusiValid;

  APIService _apiService = APIService();
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  String url = 'https://0fbf00264d6c.ngrok.io/logbook/';
  Uri apiUrl = Uri.parse('https://0fbf00264d6c.ngrok.io/logbook/');

  String nim;
  Future<String> getUser1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nim = prefs.getString('nim') ?? "nim";
      id = prefs.getInt('idmhs');
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
      _isFieldDateValid = true;
      _date.text = widget.profile.date;
      _isFieldkegiatanlValid = true;
      _kegiatan.text = widget.profile.kegiatan;
      _isFieldkendalaValid = true;
      _kendala.text = widget.profile.kendala;
      _isFieldsolusiValid = true;
      _solusi.text = widget.profile.solusi;
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.hintColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Tambah Logbook"),
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
                  _buildTextFieldDate(),
                  _buildTextFieldkegiatan(),
                  _buildTextFieldkendala(),
                  _buildTextFieldsolusi(),
                  _previewImage(),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    child: Text(
                      "Lampiran",
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _pickImage,
      //   tooltip: 'Pick Image from gallery',
      //   child: Icon(Icons.photo_library),
      // ),
    );
  }

  Widget _buildTextFieldDate() {
    return TextFormField(
      controller: _date,
      decoration: InputDecoration(
        labelText: "Tanggal Kegiatan",
        hintText: "Ex. Insert your dob",
      ),
      onTap: () async {
        DateTime date = DateTime(1900);
        FocusScope.of(context).requestFocus(new FocusNode());

        date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100));

        _date.text = date.toIso8601String();
      },
    );
  }

  // Widget _buildTextFieldnamaperusahaan() {
  //   return TextField(
  //     controller: _namaperusahaan,
  //     keyboardType: TextInputType.text,
  //     decoration: InputDecoration(
  //       labelText: "Nama Perusahaan",
  //       errorText:
  //           _isFieldnamaperusahaanValid == null || _isFieldnamaperusahaanValid
  //               ? null
  //               : "Email is required",
  //     ),
  //     onChanged: (value) {
  //       bool isFieldValid = value.trim().isNotEmpty;
  //       if (isFieldValid != _isFieldnamaperusahaanValid) {
  //         setState(() => _isFieldnamaperusahaanValid = isFieldValid);
  //       }
  //     },
  //   );
  // }

  Widget _buildTextFieldkegiatan() {
    return TextField(
      controller: _kegiatan,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Kegiatan",
        errorText: _isFieldkegiatanlValid == null || _isFieldkegiatanlValid
            ? null
            : "Email is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldkegiatanlValid) {
          setState(() => _isFieldkegiatanlValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldkendala() {
    return TextField(
      controller: _kendala,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Kendala",
        errorText: _isFieldkendalaValid == null || _isFieldkendalaValid
            ? null
            : "Email is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldkendalaValid) {
          setState(() => _isFieldkendalaValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldsolusi() {
    return TextField(
      controller: _solusi,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Solusi",
        errorText: _isFieldsolusiValid == null || _isFieldsolusiValid
            ? null
            : "Email is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldsolusiValid) {
          setState(() => _isFieldsolusiValid = isFieldValid);
        }
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
                "Masukkan",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () async {
                _apiService.uploadlogbook(_imageFile.path, apiUrl, _date.text,
                    _kegiatan.text, _kendala.text, _solusi.text);
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
