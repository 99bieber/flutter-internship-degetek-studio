import 'dart:convert';

class Intership {
  int id;
  String nama_industri;
  String nim1;
  String nim2;
  String nim3;
  String status;
  String image;

  Intership(
      {this.id,
      this.nama_industri,
      this.nim1,
      this.nim2,
      this.nim3,
      this.status,
      this.image});

  factory Intership.fromJson(Map<dynamic, dynamic> map) {
    return Intership(
      id: map['id'],
      nama_industri: map['Nama_industri'],
      nim1: map['NIM_ketua'],
      nim2: map['NIM_anggota1'],
      nim3: map['NIM_anggota2'],
      status: map['status'],
      image: map['Surat_industri'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "Nama_Industri": nama_industri,
      "NIM_ketua": nim1,
      "NIM_anggota1": nim2,
      "NIM_anggota2": nim3,
      'status': status,
      "Surat_industri": image
    };
  }

  String toString() {
    return 'User{id: $id, Nama_industri: $nama_industri, NIM_ketua: $nim1, NIM_anggota1: $nim2, NIM_anggota2: $nim3, status: $status, Surat_industri: $image}';
  }
}

List<Intership> intershipFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Intership>.from(data.map((item) => Intership.fromJson(item)));
}

String intershipToJson(Intership data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
