import 'dart:convert';

class Perusahaan {
  int id;
  String nama_industri;
  String alamat;
  String cp;
  String nim1;
  String nim2;
  String nim3;
  String image;

  Perusahaan(
      {this.id,
      this.nama_industri,
      this.alamat,
      this.cp,
      this.nim1,
      this.nim2,
      this.nim3,
      this.image});

  factory Perusahaan.fromJson(Map<dynamic, dynamic> map) {
    return Perusahaan(
      id: map['id'],
      nama_industri: map['Nama_industri'],
      alamat: map['Alamat'],
      cp: map['Contact_Person'],
      nim1: map['NIM_ketua'],
      nim2: map['NIM_anggota1'],
      nim3: map['NIM_anggota2'],
      image: map['Surat_industri'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "Nama_Industri": nama_industri,
      "Alamat": alamat,
      "Contact_Person": cp,
      "NIM_ketua": nim1,
      "NIM_anggota1": nim2,
      "NIM_anggota2": nim3,
      "Surat_industri": image
    };
  }

  String toString() {
    return 'User{id: $id, Nama_industri: $nama_industri, Alamat: $alamat, Contact_Person: $cp, NIM_ketua: $nim1, NIM_anggota1: $nim2, NIM_anggota2: $nim3, Surat_industri: $image}';
  }
}

List<Perusahaan> perusahaanFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Perusahaan>.from(data.map((item) => Perusahaan.fromJson(item)));
}

String perusahaanToJson(Perusahaan data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
