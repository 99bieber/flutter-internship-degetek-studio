import 'dart:convert';

class logbook {
  int id;
  String date;
  String kegiatan;
  String kendala;
  String solusi;
  String image;

  logbook(
      {this.id,
      this.date,
      this.kegiatan,
      this.kendala,
      this.solusi,
      this.image});

  factory logbook.fromJson(Map<dynamic, dynamic> map) {
    return logbook(
      id: map['id'],
      date: map['tanggal'],
      kegiatan: map['kegiatan'],
      kendala: map['kendala'],
      solusi: map['solusi'],
      image: map['lampiran'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "tanggal": date,
      "kegiatan": kegiatan,
      "kendala": kendala,
      "solusi": solusi,
      "lampiran": image,
    };
  }

  String toString() {
    return 'User{id: $id, tanggal: $date, kegiatan: $kegiatan, kendala: $kendala, solusi: $solusi, lampiran: $image}';
  }
}

List<logbook> logbookFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<logbook>.from(data.map((item) => logbook.fromJson(item)));
}

String logbookToJson(logbook data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
