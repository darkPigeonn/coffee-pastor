class ModelTentang {
    List<Promo> promos;
    Paroki paroki;

    ModelTentang({
        required this.promos,
        required this.paroki,
    });

    factory ModelTentang.fromJson(Map<String, dynamic> json) => ModelTentang(
        promos: List<Promo>.from(json["promos"].map((x) => Promo.fromJson(x))),
        paroki: Paroki.fromJson(json["paroki"]),
    );

    Map<String, dynamic> toJson() => {
        "promos": List<dynamic>.from(promos.map((x) => x.toJson())),
        "paroki": paroki.toJson(),
    };
}

class Paroki {
    String id;
    String parokiId;
    String dioceseCode;
    String dioceseId;
    String name;
    String churchName;
    String city;
    String lastKnownPastorName;
    String parokiName;
    String location;
    String locationNote;
    String pastorParokiName;
    String pastorSignatureUrl;
    String parokiPrintName;
    String kevikepanName;
    String kevikepanId;
    String address;
    List<dynamic> churchImage;
    String description;
    String email;
    String history;
    List<String> images;
    List<Pastor> pastors;
    String secretariatTelephone;
    List<SocialLink> socialLinks;
    String website;
    String whatsapp;
    String cityId;
    String cityName;
    String villageId;
    String villageName;
    String logo;
    Coordinates coordinates;

    Paroki({
        required this.id,
        required this.parokiId,
        required this.dioceseCode,
        required this.dioceseId,
        required this.name,
        required this.churchName,
        required this.city,
        required this.lastKnownPastorName,
        required this.parokiName,
        required this.location,
        required this.locationNote,
        required this.pastorParokiName,
        required this.pastorSignatureUrl,
        required this.parokiPrintName,
        required this.kevikepanName,
        required this.kevikepanId,
        required this.address,
        required this.churchImage,
        required this.description,
        required this.email,
        required this.history,
        required this.images,
        required this.pastors,
        required this.secretariatTelephone,
        required this.socialLinks,
        required this.website,
        required this.whatsapp,
        required this.cityId,
        required this.cityName,
        required this.villageId,
        required this.villageName,
        required this.logo,
        required this.coordinates,
    });

    factory Paroki.fromJson(Map<String, dynamic> json) => Paroki(
        id: json["_id"],
        parokiId: json["ParokiID"],
        dioceseCode: json["dioceseCode"],
        dioceseId: json["dioceseId"],
        name: json["name"],
        churchName: json["churchName"],
        city: json["city"],
        lastKnownPastorName: json["LastKnownPastorName"],
        parokiName: json["parokiName"],
        location: json["location"],
        locationNote: json["locationNote"],
        pastorParokiName: json["pastorParokiName"],
        pastorSignatureUrl: json["pastorSignatureUrl"],
        parokiPrintName: json["parokiPrintName"],
        kevikepanName: json["kevikepanName"],
        kevikepanId: json["kevikepanId"],
        address: json["address"],
        churchImage: List<dynamic>.from(json["churchImage"].map((x) => x)),
        description: json["description"],
        email: json["email"],
        history: json["history"],
        images: List<String>.from(json["images"].map((x) => x)),
        pastors: List<Pastor>.from(json["pastors"].map((x) => Pastor.fromJson(x))),
        secretariatTelephone: json["secretariatTelephone"],
        socialLinks: List<SocialLink>.from(json["socialLinks"].map((x) => SocialLink.fromJson(x))),
        website: json["website"],
        whatsapp: json["whatsapp"],
        cityId: json["cityId"],
        cityName: json["cityName"],
        villageId: json["villageId"],
        villageName: json["villageName"],
        logo: json["logo"],
        coordinates: Coordinates.fromJson(json["coordinates"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "ParokiID": parokiId,
        "dioceseCode": dioceseCode,
        "dioceseId": dioceseId,
        "name": name,
        "churchName": churchName,
        "city": city,
        "LastKnownPastorName": lastKnownPastorName,
        "parokiName": parokiName,
        "location": location,
        "locationNote": locationNote,
        "pastorParokiName": pastorParokiName,
        "pastorSignatureUrl": pastorSignatureUrl,
        "parokiPrintName": parokiPrintName,
        "kevikepanName": kevikepanName,
        "kevikepanId": kevikepanId,
        "address": address,
        "churchImage": List<dynamic>.from(churchImage.map((x) => x)),
        "description": description,
        "email": email,
        "history": history,
        "images": List<dynamic>.from(images.map((x) => x)),
        "pastors": List<dynamic>.from(pastors.map((x) => x.toJson())),
        "secretariatTelephone": secretariatTelephone,
        "socialLinks": List<dynamic>.from(socialLinks.map((x) => x.toJson())),
        "website": website,
        "whatsapp": whatsapp,
        "cityId": cityId,
        "cityName": cityName,
        "villageId": villageId,
        "villageName": villageName,
        "logo": logo,
        "coordinates": coordinates.toJson(),
    };
}

class Coordinates {
    double latitude;
    double longitude;

    Coordinates({
        required this.latitude,
        required this.longitude,
    });

    factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
    };
}

class Pastor {
    String pastorName;
    String jabatan;
    String profilePicture;

    Pastor({
        required this.pastorName,
        required this.jabatan,
        required this.profilePicture,
    });

    factory Pastor.fromJson(Map<String, dynamic> json) => Pastor(
        pastorName: json["pastorName"],
        jabatan: json["jabatan"],
        profilePicture: json["profilePicture"],
    );

    Map<String, dynamic> toJson() => {
        "pastorName": pastorName,
        "jabatan": jabatan,
        "profilePicture": profilePicture,
    };
}

class SocialLink {
    String label;
    String type;
    String url;

    SocialLink({
        required this.label,
        required this.type,
        required this.url,
    });

    factory SocialLink.fromJson(Map<String, dynamic> json) => SocialLink(
        label: json["label"],
        type: json["type"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "label": label,
        "type": type,
        "url": url,
    };
}

class Promo {
    String id;
    String image;

    Promo({
        required this.id,
        required this.image,
    });

    factory Promo.fromJson(Map<String, dynamic> json) => Promo(
        id: json["_id"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "image": image,
    };
}
