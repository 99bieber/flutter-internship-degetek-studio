import 'package:aplikasi_magang/api/apiservice.dart';
import 'package:aplikasi_magang/const/constant.dart';
import 'package:aplikasi_magang/model/user_model.dart';
import 'package:flutter/material.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class FormAddScreen extends StatefulWidget {
  User profile;

  FormAddScreen({this.profile});

  @override
  _FormAddScreenState createState() => _FormAddScreenState();
}

class _FormAddScreenState extends State<FormAddScreen> {
  bool _isLoading = false;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _no = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _nim = TextEditingController();
  // final TextEditingController _role = TextEditingController();
  bool _isFieldNameValid;
  bool _isFieldEmailValid;
  bool _isFieldDateValid;
  bool _isFieldNoValid;
  bool _isFieldAddressValid;
  bool _isFieldNIMValid;
  // bool _isFieldRoleValid;
  APIService _apiService = APIService();
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    if (widget.profile != null) {
      _isFieldNameValid = true;
      _name.text = widget.profile.name;
      _isFieldEmailValid = true;
      _email.text = widget.profile.email;
      _isFieldDateValid = true;
      _date.text = widget.profile.date;
      _isFieldNoValid = true;
      _no.text = widget.profile.no;
      _isFieldAddressValid = true;
      _address.text = widget.profile.address;
      _isFieldNIMValid = true;
      _nim.text = widget.profile.nim;
      // _isFieldRoleValid = true;
      // _role.text = widget.profile.role;
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
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTextFieldName(),
                _buildTextFieldEmail(),
                _buildTextFieldNIM(),
                _buildTextFieldDate(),
                _buildTextFieldNo(),
                _buildTextFieldAdress(),
                // _buildTextFieldRole(),
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
                      if (_isFieldNameValid == null ||
                          _isFieldEmailValid == null ||
                          _isFieldDateValid == null ||
                          _isFieldNoValid == null ||
                          _isFieldAddressValid == null ||
                          !_isFieldNameValid ||
                          !_isFieldEmailValid ||
                          !_isFieldDateValid ||
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
                      // String role = _role.text;
                      User profile = User(
                        name: name,
                        nim: nim,
                        email: email,
                        date: date,
                        no: no,
                        address: address,
                        // role: role,
                      );
                      if (widget.profile == null) {
                        // _apiService.createProfile(profile).then((isSuccess) {
                        //   setState(() => _isLoading = false);
                        //   if (isSuccess) {
                        //     Navigator.pop(
                        //         _scaffoldState.currentState.context, true);
                        //   } else {
                        //     _scaffoldState.currentState.showSnackBar(SnackBar(
                        //       content: Text("Submit data failed"),
                        //     ));
                        //   }
                        // });
                      } else {
                        profile.id = widget.profile.id;
                        _apiService.updateProfile(profile).then((isSuccess) {
                          setState(() => _isLoading = false);
                          if (isSuccess) {
                            Navigator.of(context)
                                .pushReplacementNamed('/datauser');
                          } else {
                            _scaffoldState.currentState.showSnackBar(SnackBar(
                              content: Text("Update data failed"),
                            ));
                          }
                        });
                      }
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
    );
  }

  Widget _buildTextFieldName() {
    return TextField(
      controller: _name,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
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
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "NIM",
        errorText: _isFieldNIMValid == null || _isFieldNIMValid
            ? null
            : "Full name is required",
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
        labelText: "Date of birth",
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

  Widget _buildTextFieldNo() {
    return TextField(
      controller: _no,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "No",
        errorText: _isFieldNoValid == null || _isFieldNoValid
            ? null
            : "Age is required",
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
      controller: _address,
      keyboardType: TextInputType.streetAddress,
      decoration: InputDecoration(
        labelText: "Address",
        errorText: _isFieldAddressValid == null || _isFieldAddressValid
            ? null
            : "Age is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldAddressValid) {
          setState(() => _isFieldAddressValid = isFieldValid);
        }
      },
    );
  }

  // Widget _buildTextFieldRole() {
  //   return TextField(
  //     controller: _role,
  //     keyboardType: TextInputType.text,
  //     decoration: InputDecoration(
  //       labelText: "NIM",
  //       errorText: _isFieldRoleValid == null || _isFieldRoleValid
  //           ? null
  //           : "Full name is required",
  //     ),
  //     onChanged: (value) {
  //       bool isFieldValid = value.trim().isNotEmpty;
  //       if (isFieldValid != _isFieldRoleValid) {
  //         setState(() => _isFieldRoleValid = isFieldValid);
  //       }
  //     },
  //   );
  // }
}
