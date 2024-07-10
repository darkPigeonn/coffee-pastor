class ModelStore {
  String nama;
  Lokasi lokasi;
  String startTime;
  String endTime;
  String deskripsi;
  List<String> images;
  int phone;

  ModelStore({
    required this.nama,
    required this.lokasi,
    required this.startTime,
    required this.endTime,
    required this.deskripsi,
    required this.images,
    required this.phone,
  });

  factory ModelStore.fromJson(Map<String, dynamic> json) => ModelStore(
        nama: json["nama"],
        lokasi: Lokasi.fromJson(json["lokasi"]),
        startTime: json["startTime"],
        endTime: json["endTime"],
        deskripsi: json["deskripsi"],
        images: List<String>.from(json["images"].map((x) => x)),
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "lokasi": lokasi.toJson(),
        "startTime": startTime,
        "endTime": endTime,
        "deskripsi": deskripsi,
        "images": List<String>.from(images.map((x) => x)),
        "phone": phone,
      };
}

class Lokasi {
  String alamat;
  double latitude;
  double longitude;

  Lokasi({
    required this.alamat,
    required this.latitude,
    required this.longitude,
  });

  factory Lokasi.fromJson(Map<String, dynamic> json) => Lokasi(
        alamat: json["alamat"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "alamat": alamat,
        "latitude": latitude,
        "longitude": longitude,
      };
}

List<Map<String, dynamic>> body = [
  {
    "nama": "Galeri Seminari (Cafe Pastor)",
    "lokasi": {
      "alamat":
          "Jl. Ngloji, Jurangmenjing, Garum, Kec. Garum, Kabupaten Blitar, Jawa Timur 66182",
      "latitude": -8.073910,
      "longitude": 112.224110
    },
    "startTime": "08:00",
    "endTime": "21:30",
    "deskripsi": "Tempat Nongkrong Orang Muda, Ngopi sambil Ngobrolin Iman",
    "images": [""],
    "phone": 081234534699
  },
  {
    "nama": "Cafe Pastor",
    "lokasi": {
      "alamat":
          "Jl. Ngagel Madya No.1, Baratajaya, Kec. Gubeng, Surabaya, Jawa Timur 60284",
      "latitude": -7.290190,
      "longitude": 112.758240
    },
    "startTime": "10:00",
    "endTime": "22:00",
    "deskripsi": "Tempat Nongkrong Orang Muda, Ngopi sambil Ngobrolin Iman",
    "images": [],
    "phone": 081234534699
  },
];
