import 'dart:convert';
import 'package:aplikasi_magang/model/intership_dosen_model.dart';
import 'package:aplikasi_magang/model/logbook_model.dart';
import 'package:aplikasi_magang/model/login_model.dart';
import 'package:aplikasi_magang/model/intership_model.dart';
import 'package:aplikasi_magang/model/perusahaan_model.dart';
import 'package:aplikasi_magang/model/user_model.dart';
import 'package:aplikasi_magang/page/admin/verif_intership_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http_parser/src/media_type.dart';
import 'dart:typed_data';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class APIService extends ChangeNotifier {
  final url = "https://0fbf00264d6c.ngrok.io";
  List<Perusahaan> _data1 = [];
  List<Perusahaan> get dataPerusahaan => _data1;
  static Future<List<Perusahaan>> getPerusahaan() async {
    final res = await http.get("https://0fbf00264d6c.ngrok.io/industri/ver");
    if (res.statusCode == 200) {
      return perusahaanFromJson(res.body);
    } else {
      return null;
    }
  }

  List<Perusahaan> _data2 = [];
  List<Perusahaan> get dataPerusahaan1 => _data2;
  static Future<List<Perusahaan>> getPerusahaan1() async {
    final res = await http.get("https://0fbf00264d6c.ngrok.io/industri/notver");
    if (res.statusCode == 200) {
      return perusahaanFromJson(res.body);
    } else {
      return null;
    }
  }

  List<Intership> _data3 = [];
  List<Intership> get dataIntership => _data3;
  static Future<List<Intershipdosen>> getIntership() async {
    final res =
        await http.get("https://0fbf00264d6c.ngrok.io/industri/daftar/notver");
    if (res.statusCode == 200) {
      return intershipdosenFromJson(res.body);
    } else {
      return null;
    }
  }

  List<Intership> _data4 = [];
  List<Intership> get datalogbook => _data4;
  static Future<List<logbook>> getlogbook() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getInt('idmhs');
    final res = await http.get("https://0fbf00264d6c.ngrok.io/logbook/$id");
    if (res.statusCode == 200) {
      return logbookFromJson(res.body);
    } else {
      return null;
    }
  }

  List<User> _data = [];
  List<User> get dataUser => _data;
  static Future<List<User>> getUser() async {
    final res = await http.get("https://0fbf00264d6c.ngrok.io/user");
    if (res.statusCode == 200) {
      return userFromJson(res.body);
    } else {
      return null;
    }
  }

  Future<String> uploadImage(
      filepath,
      url,
      String _namaperusahaan,
      String _nim1,
      String _nim2,
      String _nim3,
      String date1,
      String date2) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('picture', filepath));
    request.fields['Nama_industri'] = _namaperusahaan;
    request.fields['NIM_ketua'] = _nim1;
    request.fields['NIM_anggota1'] = _nim2;
    request.fields['NIM_anggota2'] = _nim3;
    request.fields['industrinama'] = _namaperusahaan;
    request.fields['Durasi1'] = date1;
    request.fields['Durasi2'] = date2;
    final res = await request.send();
    print(res);
    return res.reasonPhrase;
  }

  Future<String> uploadlogbook(filepath, url, String _date, String _kegiatan,
      String _kendala, String _solusi) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getInt('idmhs');
    Uri urll = Uri.parse("$url$id");
    final request = http.MultipartRequest('POST', urll);
    request.files.add(await http.MultipartFile.fromPath('picture', filepath));
    request.fields['tanggal'] = _date;
    request.fields['kegiatan'] = _kegiatan;
    request.fields['kendala'] = _kendala;
    request.fields['solusi'] = _solusi;
    final res = await request.send();
    print(res);
    return res.reasonPhrase;
  }

  Future<String> updatelogbook(filepath, url, String id, String image,
      String date, String kegiatan, String kendala, String solusi) async {
    Uri urll = Uri.parse("$url$id/$image");
    final request = http.MultipartRequest('PUT', urll);
    request.files.add(await http.MultipartFile.fromPath('picture', filepath));
    request.fields['tanggal'] = date;
    request.fields['kegiatan'] = kegiatan;
    request.fields['kendala'] = kendala;
    request.fields['solusi'] = solusi;
    final res = await request.send();
    print(res);
    return res.reasonPhrase;
  }

  Future<String> updatelogbook1(String id, String image, String date,
      String kegiatan, String kendala, String solusi) async {
    print("masuk");
    final response = await http.put(
      "$url/logbook/$id/$image",
      body: {
        "tanggal": date,
        "kegiatan": kegiatan,
        "kendala": kendala,
        "solusi": solusi,
        "picture": image,
      },
    );
  }

  Future<String> verifIntershipdosen(String id, String dosen) async {
    print(dosen);
    final response = await http.put(
      "$url/industri/daftar/$id",
      body: {
        "Dosen": dosen,
      },
    );
  }

  Future<bool> storeEmployee(String name, String nim, String email, String date,
      String address, String no, String role) async {
    final baseurl = '$url/user';
    var date1 = DateTime.parse(date);
    print("$name, $email, $date1, $address, $no");
    final res = await http.post(baseurl, body: {
      "nama": name,
      "nim": nim,
      "email": email,
      "tanggal_lahir": DateFormat("yyyy-MM-dd").format(date1),
      "no_telp": no,
      "alamat": address,
      "role": role,
    });
    final result = json.decode(res.body);
    if (res.statusCode == 200 && result['status'] == 'success') {
      return true;
    }
    return false;
  }

  Future<bool> createPerusahaan(
      String namaperusahaan, String alamat, String cp) async {
    final baseurl = '$url/industri';
    print("$namaperusahaan, $alamat, $cp");
    final res = await http.post(baseurl, body: {
      "Nama_industri": namaperusahaan,
      "Alamat": alamat,
      "Contact_Person": cp,
    });
    final result = json.decode(res.body);
    if (res.statusCode == 200 && result['status'] == 'success') {
      return true;
    }
    return false;
  }

  Future<bool> updateProfile(User data) async {
    var id = data.id;
    print(data.no);
    final response = await http.put(
      "$url/user/$id",
      body: {
        "nama": data.name,
        "email": data.email,
        "nim": data.nim,
        "tanggal_lahir": data.date,
        "no_telp": data.no,
        "alamat": data.address,
      },
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteProfile(int id) async {
    final response = await http.delete(
      "https://0fbf00264d6c.ngrok.io/user/$id",
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deletelogbook(int id, String image) async {
    final res = await http.delete(
      "https://0fbf00264d6c.ngrok.io/logbook/gambar/$image/$id",
      headers: {"content-type": "application/json"},
    );
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> updatePrusahaan(int id) async {
    final response = await http.put(
      "https://0fbf00264d6c.ngrok.io/industri/$id",
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> updateIntership(int id) async {
    final response = await http.put(
      "https://0fbf00264d6c.ngrok.io/industri/daftar/$id",
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
