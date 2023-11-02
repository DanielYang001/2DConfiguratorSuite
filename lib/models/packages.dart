// To parse this JSON data, do
//
//     final packages = packagesFromMap(jsonString);

import 'dart:convert';

class Packages {
  final List<Package>? packages;

  Packages({
    this.packages,
  });

  factory Packages.fromJson(String str) => Packages.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Packages.fromMap(Map<String, dynamic> json) => Packages(
        packages: json["packages"] == null
            ? []
            : List<Package>.from(
                json["packages"]!.map((x) => Package.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "packages": packages == null
            ? []
            : List<dynamic>.from(packages!.map((x) => x.toMap())),
      };
}

class Package {
  final String? id;
  final String? name;
  final String? description;
  final List<String>? details;
  final int? price;

  Package({
    this.id,
    this.name,
    this.description,
    this.details,
    this.price,
  });

  factory Package.fromJson(String str) => Package.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Package.fromMap(Map<String, dynamic> json) => Package(
        id: json["ID"],
        name: json["name"],
        description: json["description"],
        details: json["details"] == null
            ? []
            : List<String>.from(json["details"]!.map((x) => x)),
        price: json["price"],
      );

  Map<String, dynamic> toMap() => {
        "ID": id,
        "name": name,
        "description": description,
        "details":
            details == null ? [] : List<dynamic>.from(details!.map((x) => x)),
        "price": price,
      };
}
