// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ThemeStyle {
  Color primary;
  Color primaryLight;
  Color primaryPastel;
  Color primaryDark;
  Color secondary;
  Color secondaryLight;
  Color secondaryPastel;

  ThemeStyle({
    required this.primary,
    required this.primaryLight,
    required this.primaryPastel,
    required this.primaryDark,
    required this.secondary,
    required this.secondaryLight,
    required this.secondaryPastel,
  });
}

int colorIndex = 0;

List<ThemeStyle> themeStyle = [
  ThemeStyle(
    primary: Color.fromARGB(255, 255, 147, 67),
    primaryLight: Color.fromARGB(255, 253, 182, 128),
    primaryPastel: Color.fromARGB(255, 255, 147, 67),
    primaryDark: Color.fromARGB(255, 142, 72, 19),
    secondary: Color.fromARGB(255, 19, 188, 255),
    secondaryLight: Color.fromARGB(255, 133, 220, 255),
    secondaryPastel: Color.fromARGB(255, 145, 220, 249),
  ),
];
List<ThemeStyle> themeStyle2 = [
  ThemeStyle(
    primary: Color.fromARGB(255, 255, 193, 37), // Brighter orange
    primaryLight: Color.fromARGB(255, 255, 223, 128), // Brighter light orange
    primaryPastel: Color.fromARGB(255, 255, 210, 128), // Brighter pastel orange
    primaryDark: Color.fromARGB(255, 204, 130, 0), // Brighter dark orange
    secondary: Color.fromARGB(255, 0, 214, 255), // Brighter cyan
    secondaryLight: Color.fromARGB(255, 128, 235, 255), // Brighter light cyan
    secondaryPastel: Color.fromARGB(255, 180, 240, 250), // Brighter pastel cyan
  ),
];
List<ThemeStyle> themeStyle3 = [
  ThemeStyle(
    primary: Color.fromARGB(255, 255, 105, 180), // Bright pink
    primaryLight: Color.fromARGB(255, 255, 182, 193), // Light pink
    primaryPastel: Color.fromARGB(255, 255, 204, 229), // Pastel pink
    primaryDark: Color.fromARGB(255, 219, 112, 147), // Dark pink
    secondary: Color.fromARGB(255, 144, 238, 144), // Light green
    secondaryLight: Color.fromARGB(255, 193, 255, 193), // Light pastel green
    secondaryPastel: Color.fromARGB(255, 204, 255, 229), // Pastel green
  ),
];
List<ThemeStyle> themeStyle4 = [
  ThemeStyle(
    primary: Color.fromARGB(255, 255, 223, 0), // Bright yellow
    primaryLight: Color.fromARGB(255, 255, 239, 128), // Light yellow
    primaryPastel: Color.fromARGB(255, 255, 248, 204), // Pastel yellow
    primaryDark: Color.fromARGB(255, 204, 179, 0), // Dark yellow
    secondary: Color.fromARGB(255, 0, 191, 255), // Bright blue
    secondaryLight: Color.fromARGB(255, 128, 223, 255), // Light blue
    secondaryPastel: Color.fromARGB(255, 204, 239, 255), // Pastel blue
  ),
];
List<ThemeStyle> themeStyle5 = [
  ThemeStyle(
    primary: Color.fromARGB(255, 186, 85, 211), // Bright purple
    primaryLight: Color.fromARGB(255, 221, 160, 221), // Light purple
    primaryPastel: Color.fromARGB(255, 230, 190, 230), // Pastel purple
    primaryDark: Color.fromARGB(255, 148, 0, 211), // Dark purple
    secondary: Color.fromARGB(255, 0, 206, 209), // Bright teal
    secondaryLight: Color.fromARGB(255, 128, 224, 225), // Light teal
    secondaryPastel: Color.fromARGB(255, 204, 239, 240), // Pastel teal
  ),
];
List<ThemeStyle> themeStyle6 = [
  ThemeStyle(
    primary: Color.fromARGB(255, 255, 69, 0), // Bright red
    primaryLight: Color.fromARGB(255, 255, 160, 122), // Light red
    primaryPastel: Color.fromARGB(255, 255, 182, 193), // Pastel red
    primaryDark: Color.fromARGB(255, 178, 34, 34), // Dark red
    secondary: Color.fromARGB(255, 50, 205, 50), // Bright lime
    secondaryLight: Color.fromARGB(255, 144, 238, 144), // Light lime
    secondaryPastel: Color.fromARGB(255, 193, 255, 193), // Pastel lime
  ),
];

Color get primary {
  return themeStyle5[colorIndex].primary;
}

Color get primaryPastel {
  return themeStyle5[colorIndex].primaryPastel;
}

Color get primaryLight {
  return themeStyle5[colorIndex].primaryLight;
}

Color get primaryDark {
  return themeStyle5[colorIndex].primaryDark;
}

Color get secondary {
  return themeStyle5[colorIndex].secondary;
}

Color get secondaryLight {
  return themeStyle5[colorIndex].secondaryLight;
}

Color get secondaryPastel {
  return themeStyle5[colorIndex].secondaryPastel;
}

Color get warning {
  return const Color.fromARGB(255, 255, 237, 77);
}

Color get warningDark {
  return Color.fromARGB(255, 221, 204, 20);
}

Color get danger {
  return const Color.fromARGB(255, 255, 81, 81);
}

Color get dangerSplash {
  return Color.fromARGB(255, 255, 126, 126);
}

Color get dangerDark {
  return Color.fromARGB(255, 200, 27, 27);
}

Color get link {
  return const Color.fromARGB(255, 0, 0, 238);
}

Color get safe {
  return const Color.fromARGB(255, 134, 241, 108);
}

Color get safeAlt {
  return const Color.fromARGB(255, 66, 185, 36);
}

Color get grey1 {
  return const Color.fromARGB(255, 136, 136, 136);
}

Color get grey2 {
  return const Color.fromARGB(255, 217, 217, 217);
}

Color get grey3 {
  return const Color.fromARGB(255, 247, 247, 247);
}

class ThemeModel {
  String name;
  String logo;
  ColorModel color;
  List<String> permission;

  ThemeModel({
    required this.name,
    required this.logo,
    required this.color,
    required this.permission,
  });

  factory ThemeModel.fromJson(Map<String, dynamic> json) => ThemeModel(
        name: json["name"] ?? "",
        logo: json["logo"] ?? "",
        color: ColorModel.fromJson(json["color"]),
        permission: json["permission"] == null
            ? <String>[]
            : List<String>.from(json["permission"].map((x) => x)),
      );
  //

  Map<String, dynamic> toJson() => {
        "name": name,
        "logo": logo,
        "color": color,
        "permission": permission,
      };
}

class ColorModel {
  Color primary;
  Color primaryAlt;
  Color primarySplash;
  Color secondary;

  ColorModel({
    required this.primary,
    required this.primaryAlt,
    required this.primarySplash,
    required this.secondary,
  });

  factory ColorModel.fromJson(Map<String, dynamic> json) => ColorModel(
        primary: json["primary"] == null
            ? const Color.fromARGB(255, 32, 46, 74)
            : Color(
                int.parse("0xff${json["primary"].toString().toLowerCase()}")),
        primaryAlt: json["primaryAlt"] == null
            ? const Color.fromARGB(255, 49, 63, 91)
            : Color(int.parse(
                "0xff${json["primaryAlt"].toString().toLowerCase()}")),
        primarySplash: json["primarySplash"] == null
            ? const Color.fromARGB(255, 49, 63, 91)
            : Color(int.parse(
                "0xff${json["primarySplash"].toString().toLowerCase()}")),
        secondary: json["secondary"] == null
            ? const Color.fromARGB(255, 242, 137, 66)
            : Color(
                int.parse("0xff${json["secondary"].toString().toLowerCase()}")),
      );

  Map<String, dynamic> toJson() => {
        "primary": primary,
        "primaryAlt": primaryAlt,
        "primarySplash": primarySplash,
        "secondary": secondary,
      };
}
