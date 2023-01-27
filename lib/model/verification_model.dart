// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class Verification {
//   int id;
//   String image;

//   Verification({
//     this.id,
//     this.image
//   });

//   factory Verification.fromJson(Map<dynamic, dynamic> map) {
//     return Verification(
//       id: map['id'],
//       image: map['image'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "id": id,
//       "nama": name,
//       "nim": nim,
//       "email": email,
//       "tanggal_lahir": date,
//       "No_telp": no,
//       "alamat": address,
//     };
//   }

//   String toString() {
//     return 'User{id: $id, nama: $name, nim: $nim email: $email, "tanggal_lahir": $date, No_telp: $no, alamat: $address}';
//   }
// }

// List<Verification> userFromJson(String jsonData) {
//   final data = json.decode(jsonData);
//   return List<Verification>.from(data.map((item) => Verification.fromJson(item)));
// }

// String userToJson(Verification data) {
//   final jsonData = data.toJson();
//   return json.encode(jsonData);
// }
