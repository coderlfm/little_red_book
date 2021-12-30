// To parse this JSON data, do
//
//     final tabItem = tabItemFromMap(jsonString);

import 'dart:convert';

class TabItem {
  TabItem({
    required this.name,
    required this.oid,
  });

  final String name;
  final String oid;

  factory TabItem.fromJson(String str) => TabItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TabItem.fromMap(Map<String, dynamic> json) => TabItem(
        name: json["name"],
        oid: json["oid"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "oid": oid,
      };
}
