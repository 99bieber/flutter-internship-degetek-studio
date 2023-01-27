import 'package:aplikasi_magang/api/apiservice.dart';
import 'package:aplikasi_magang/const/constant.dart';
import 'package:aplikasi_magang/model/intership_model.dart';
import 'package:aplikasi_magang/model/logbook_model.dart';
import 'package:aplikasi_magang/model/perusahaan_model.dart';
import 'package:aplikasi_magang/page/user/menu.dart';
import 'package:flutter/material.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class createPerusahaan extends StatefulWidget {
  Perusahaan profile;

  createPerusahaan({this.profile});

  @override
  _createPerusahaanState createState() => _createPerusahaanState();
}

class _createPerusahaanState extends State<createPerusahaan> {
  bool _isLoading = false;
  final TextEditingController _namaperusahaan = TextEditingController();
  final TextEditingController _alamat = TextEditingController();
  final TextEditingController _cp = TextEditingController();
  // final TextEditingController _role = TextEditingController();
  bool _isFieldnamaperusahaanValid;
  bool _isFieldAlamatlValid;
  bool _isFieldCPValid;
  // bool _isFieldRoleValid;
  APIService _apiService = APIService();
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    if (widget.profile != null) {
      _isFieldnamaperusahaanValid = true;
      _namaperusahaan.text = widget.profile.nama_industri;
      _isFieldAlamatlValid = true;
      _alamat.text = widget.profile.alamat;
      _isFieldCPValid = true;
      _cp.text = widget.profile.cp;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        backgroundColor: ColorPalette.hintColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          widget.profile == null ? "Form Add" : "Edit Data",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _buildTextFieldnamaperusahaan(),
                  _buildTextFieldAlamat(),
                  _buildTextFieldCP(),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      child: Text(
                        widget.profile == null
                            ? "Submit".toUpperCase()
                            : "Update Data".toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        if (_isFieldnamaperusahaanValid == null ||
                            _isFieldnamaperusahaanValid == null ||
                            _isFieldAlamatlValid == null ||
                            _isFieldCPValid == null ||
                            !_isFieldnamaperusahaanValid ||
                            !_isFieldAlamatlValid ||
                            !_isFieldCPValid) {
                          _scaffoldState.currentState.showSnackBar(
                            SnackBar(
                              content: Text("Please fill all field"),
                            ),
                          );
                          return;
                        }
                        setState(() => _isLoading = true);
                        String nama_industri = _namaperusahaan.text;
                        String alamat = _alamat.text;
                        String cp = _cp.text;
                        Perusahaan profile = Perusahaan(
                          nama_industri: nama_industri,
                          alamat: alamat,
                          cp: cp,
                        );

                        _apiService
                            .createPerusahaan(
                                _namaperusahaan.text, _alamat.text, _cp.text)
                            .then((res) {
                          setState(() => _isLoading = false);
                          // if (res) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LandingPageUser()),
                              (Route<dynamic> route) => false);
                          // } else {
                          _scaffoldState.currentState.showSnackBar(SnackBar(
                            content: Text("Submit data Berhasil"),
                          ));
                          // }
                        });
                      },
                      color: ColorPalette.hintColor,
                    ),
                  )
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
                : "Full name is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldnamaperusahaanValid) {
          setState(() => _isFieldnamaperusahaanValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldAlamat() {
    return TextField(
      controller: _alamat,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorPalette.hintColor)),
        prefixIcon: Icon(
          Icons.home,
          color: ColorPalette.hintColor,
        ),
        labelStyle: TextStyle(color: ColorPalette.hintColor),
        labelText: "Alamat",
        errorText: _isFieldAlamatlValid == null || _isFieldAlamatlValid
            ? null
            : "Full name is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldAlamatlValid) {
          setState(() => _isFieldAlamatlValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldCP() {
    return TextField(
      controller: _cp,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorPalette.hintColor)),
        prefixIcon: Icon(
          Icons.phone,
          color: ColorPalette.hintColor,
        ),
        labelStyle: TextStyle(color: ColorPalette.hintColor),
        labelText: "Contact Person",
        errorText: _isFieldCPValid == null || _isFieldCPValid
            ? null
            : "Email is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldCPValid) {
          setState(() => _isFieldCPValid = isFieldValid);
        }
      },
    );
  }
}
