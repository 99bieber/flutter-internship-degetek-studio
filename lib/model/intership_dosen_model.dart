import 'dart:convert';

class Intershipdosen {
  int id;
  String nama_industri;
  String alamat;
  String cp;
  String nim1;
  String nim2;
  String nim3;
  String date1;
  String date2;
  String dosen;
  String image;

  Intershipdosen(
      {this.id,
      this.nama_industri,
      this.alamat,
      this.cp,
      this.nim1,
      this.nim2,
      this.nim3,
      this.date1,
      this.date2,
      this.dosen,
      this.image});

  factory Intershipdosen.fromJson(Map<dynamic, dynamic> map) {
    return Intershipdosen(
      id: map['id'],
      nama_industri: map['Nama_industri'],
      alamat: map['Alamat'],
      cp: map['Contact_Person'],
      nim1: map['NIM_ketua'],
      nim2: map['NIM_anggota1'],
      nim3: map['NIM_anggota2'],
      date1: map['Durasi1'],
      date2: map['Durasi2'],
      dosen: map['Dosen'],
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
      "Durasi1": date1,
      "Durasi2": date2,
      "Dosen": dosen,
      "Surat_industri": image,
    };
  }

  String toString() {
    return 'User{id: $id, Nama_industri: $nama_industri, Alamat: $alamat, Contact_Person: $cp, NIM_ketua: $nim1, NIM_anggota1: $nim2, NIM_anggota2: $nim3, Durasi1: $date1, Durasi2: $date2, Dosen: $dosen Surat_industri: $image}';
  }
}

List<Intershipdosen> intershipdosenFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Intershipdosen>.from(
      data.map((item) => Intershipdosen.fromJson(item)));
}

String intershipdosenToJson(Intershipdosen data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
