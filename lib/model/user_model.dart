import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  int id;
  String name;
  String nim;
  String email;
  String date;
  String no;
  String address;

  User({
    this.id,
    this.name,
    this.nim,
    this.email,
    this.date,
    this.no,
    this.address,
  });

  factory User.fromJson(Map<dynamic, dynamic> map) {
    return User(
      id: map['id'],
      name: map['nama'],
      nim: map['nim'],
      email: map['email'],
      date: map['tanggal_lahir'],
      no: map['No_telp'],
      address: map['alamat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nama": name,
      "nim": nim,
      "email": email,
      "tanggal_lahir": date,
      "No_telp": no,
      "alamat": address,
    };
  }

  String toString() {
    return 'User{id: $id, nama: $name, nim: $nim email: $email, "tanggal_lahir": $date, No_telp: $no, alamat: $address}';
  }
}

List<User> userFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<User>.from(data.map((item) => User.fromJson(item)));
}

String userToJson(User data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
