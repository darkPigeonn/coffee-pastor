class Promo {
  final String id;
  final String image;

  Promo({
    required this.id,
    required this.image,
  });

  factory Promo.fromJson(Map<String, dynamic> json) {
    return Promo(
      id: json['_id'],
      image: json['image'][0], // Assuming 'image' is a list with one URL
    );
  }
}

class Paroki {
  final String name;
  final String pastorParokiName;
  final String address;
  final List<Promo> promos;

  Paroki({
    required this.name,
    required this.pastorParokiName,
    required this.address,
    required this.promos,
  });

  factory Paroki.fromJson(Map<String, dynamic> json) {
    List<Promo> promosList = [];
    if (json['promos'] != null) {
      promosList = List<Promo>.from(
        json['promos'].map((promo) => Promo.fromJson(promo)),
      );
    }

    return Paroki(
      name: json['parokiName'],
      pastorParokiName: json['pastorParokiName'],
      address: json['address'],
      promos: promosList,
    );
  }
}

// Common data structure for both types
class CarouselItem {
  final String type; // 'promo' or 'paroki'
  final dynamic data; // Can be either Promo or Paroki

  CarouselItem({
    required this.type,
    required this.data,
  });
}
