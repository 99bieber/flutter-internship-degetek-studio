import 'package:aplikasi_magang/api/apiservice.dart';
import 'package:aplikasi_magang/const/constant.dart';
import 'package:aplikasi_magang/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EmployeeAdd extends StatefulWidget {
  @override
  User profile;

  EmployeeAdd({this.profile});

  _EmployeeAddState createState() => _EmployeeAddState();
}

class _EmployeeAddState extends State<EmployeeAdd> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  // DateTime _date;
  final TextEditingController _date = TextEditingController();
  final TextEditingController _no = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _nim = TextEditingController();
  final TextEditingController _role = TextEditingController();
  bool _isLoading = false;
  bool _isFieldNameValid;
  bool _isFieldEmailValid;
  bool _isFieldDateValid;
  bool _isFieldNoValid;
  bool _isFieldAddressValid;
  bool _isFieldNIMValid;
  bool _isFieldRoleValid;
  APIService _apiService = APIService();
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        backgroundColor: ColorPalette.hintColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Form Add",
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
                  _buildTextFieldName(),
                  _buildTextFieldNIM(),
                  _buildTextFieldEmail(),
                  _buildTextFieldDate(),
                  _buildTextFieldNo(),
                  _buildTextFieldAdress(),
                  _buildTextFieldRole(),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () {
                        if (_isFieldNameValid == null ||
                            _isFieldEmailValid == null ||
                            // _isFieldDateValid == null ||
                            _isFieldNoValid == null ||
                            _isFieldAddressValid == null ||
                            !_isFieldNameValid ||
                            !_isFieldEmailValid ||
                            // !_isFieldDateValid ||
                            !_isFieldNoValid ||
                            !_isFieldAddressValid) {
                          _scaffoldState.currentState.showSnackBar(
                            SnackBar(
                              content: Text("Please fill all field"),
                            ),
                          );
                          return;
                        }
                        setState(() => _isLoading = true);
                        String name = _name.text;
                        String email = _email.text;
                        String date = _date.text;
                        String no = _no.text;
                        String address = _address.text;
                        String nim = _nim.text;
                        String role = _role.text;
                        User profile = User(
                            name: name,
                            email: email,
                            date: date,
                            no: no,
                            address: address);
                        _apiService
                            .storeEmployee(_name.text, _nim.text, _email.text,
                                _date.text, _no.text, _address.text, _role.text)
                            .then((res) {
                          setState(() => _isLoading = false);
                          // if (res) {
                          Navigator.of(context)
                              .pushReplacementNamed('/datauser');
                          // } else {
                          _scaffoldState.currentState.showSnackBar(SnackBar(
                            content: Text("Submit data Berhasil"),
                          ));
                          // }
                        });
                      },
                      child: Text(
                        "Submit".toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
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

  Widget _buildTextFieldName() {
    return TextField(
      controller: _name,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorPalette.hintColor)),
        prefixIcon: Icon(
          Icons.person,
          color: ColorPalette.hintColor,
        ),
        labelStyle: TextStyle(color: ColorPalette.hintColor),
        labelText: "Full name",
        errorText: _isFieldNameValid == null || _isFieldNameValid
            ? null
            : "Full name is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldNameValid) {
          setState(() => _isFieldNameValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldNIM() {
    return TextField(
      controller: _nim,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorPalette.hintColor)),
        prefixIcon: Icon(
          Icons.format_list_numbered_rounded,
          color: ColorPalette.hintColor,
        ),
        labelStyle: TextStyle(color: ColorPalette.hintColor),
        labelText: "NIM",
        errorText: _isFieldNIMValid == null || _isFieldNIMValid
            ? null
            : "NIM is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldNIMValid) {
          setState(() => _isFieldNIMValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldEmail() {
    return TextField(
      controller: _email,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorPalette.hintColor)),
        prefixIcon: Icon(
          Icons.alternate_email_rounded,
          color: ColorPalette.hintColor,
        ),
        labelStyle: TextStyle(color: ColorPalette.hintColor),
        labelText: "Email",
        errorText: _isFieldEmailValid == null || _isFieldEmailValid
            ? null
            : "Email is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldEmailValid) {
          setState(() => _isFieldEmailValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldDate() {
    // return TextFormField(
    //   controller:  dateFormat.format(_date),
    //   keyboardType: TextInputType.datetime,
    //   decoration: InputDecoration(
    //     labelText: "Tanggal Lahir",
    //     errorText: _isFieldDateValid == null || _isFieldDateValid
    //         ? null
    //         : "Age is required",
    //   ),
    //   onChanged: (value) {
    //     bool isFieldValid = value.trim().isNotEmpty;
    //     if (isFieldValid != _isFieldDateValid) {
    //       setState(() => _isFieldDateValid = isFieldValid);
    //     }
    //   },
    //   onTap: () {
    //     showDatePicker(
    //             context: context,
    //             initialDate: _dateTime == null ? DateTime.now() : _dateTime,
    //             firstDate: DateTime(2001),
    //             lastDate: DateTime(2021))
    //         .then((date) {
    //       setState(() {
    //         _dateTime = date;
    //       });
    //     });
    //   },
    // );
    // showDatePicker(
    //         context: context,
    //         initialDate: DateTime.now(),
    //         firstDate: DateTime(2020),
    //         lastDate: DateTime.now())
    //     .then((value) {
    //   if (value == null) {
    //     return;
    //   }
    //   setState(() {
    //     _date.text = value;
    //   });
    // });
    return TextFormField(
      controller: _date,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorPalette.hintColor)),
        prefixIcon: Icon(
          Icons.calendar_today,
          color: ColorPalette.hintColor,
        ),
        labelStyle: TextStyle(color: ColorPalette.hintColor),
        labelText: "Tanggal Lahir",
        hintText: "Tanggal Lahir",
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

  Widget _buildTextFieldNo() {
    return TextField(
      controller: _address,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorPalette.hintColor)),
        prefixIcon: Icon(
          Icons.phone,
          color: ColorPalette.hintColor,
        ),
        labelStyle: TextStyle(color: ColorPalette.hintColor),
        labelText: "No Telp",
        errorText: _isFieldNoValid == null || _isFieldNoValid
            ? null
            : "No Telp is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldNoValid) {
          setState(() => _isFieldNoValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldAdress() {
    return TextField(
      controller: _no,
      keyboardType: TextInputType.streetAddress,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorPalette.hintColor)),
        prefixIcon: Icon(
          Icons.home,
          color: ColorPalette.hintColor,
        ),
        labelStyle: TextStyle(color: ColorPalette.hintColor),
        labelText: "Address",
        errorText: _isFieldAddressValid == null || _isFieldAddressValid
            ? null
            : "Address is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldAddressValid) {
          setState(() => _isFieldAddressValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldRole() {
    return TextField(
      controller: _role,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorPalette.hintColor)),
        prefixIcon: Icon(
          Icons.how_to_reg,
          color: ColorPalette.hintColor,
        ),
        labelStyle: TextStyle(color: ColorPalette.hintColor),
        labelText: "Role",
        errorText:
            _isFieldRoleValid == null || _isFieldRoleValid ? null : "0/1",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldRoleValid) {
          setState(() => _isFieldRoleValid = isFieldValid);
        }
      },
    );
  }
}
