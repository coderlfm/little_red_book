// To parse this JSON data, do
//
//     final noteItem = noteItemFromMap(jsonString);

import 'dart:convert';

class NoteItem {
  NoteItem({
    required this.id,
    required this.title,
    required this.type,
    required this.likes,
    required this.isLiked,
    required this.cover,
    required this.time,
    required this.comments,
    required this.collects,
    required this.user,
    required this.cursorScore,
  });

  final String id;
  final String title;
  final String type;
  final int likes;
  final bool isLiked;
  final Cover cover;
  final String time;
  final int comments;
  final int collects;
  final User user;
  final double cursorScore;

  factory NoteItem.fromJson(String str) => NoteItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NoteItem.fromMap(Map<String, dynamic> json) => NoteItem(
        id: json["id"],
        title: json["title"],
        type: json["type"],
        likes: json["likes"],
        isLiked: json["isLiked"],
        cover: Cover.fromMap(json["cover"]),
        time: json["time"],
        comments: json["comments"],
        collects: json["collects"],
        user: User.fromMap(json["user"]),
        cursorScore: json["cursorScore"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "type": type,
        "likes": likes,
        "isLiked": isLiked,
        "cover": cover.toMap(),
        "time": time,
        "comments": comments,
        "collects": collects,
        "user": user.toMap(),
        "cursorScore": cursorScore,
      };
}

class Cover {
  Cover({
    required this.url,
    required this.gifUrl,
    required this.width,
    required this.height,
    required this.fileId,
  });

  final String url;
  final String gifUrl;
  final int width;
  final int height;
  final String fileId;

  factory Cover.fromJson(String str) => Cover.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Cover.fromMap(Map<String, dynamic> json) => Cover(
        url: json["url"],
        gifUrl: json["gifUrl"],
        width: json["width"],
        height: json["height"],
        fileId: json["fileId"],
      );

  Map<String, dynamic> toMap() => {
        "url": url,
        "gifUrl": gifUrl,
        "width": width,
        "height": height,
        "fileId": fileId,
      };
}

class User {
  User({
    required this.id,
    required this.image,
    required this.nickname,
    required this.redOfficialVerifyType,
    required this.redOfficialVerifyShowIcon,
    required this.officialVerified,
  });

  final String id;
  final String image;
  final String nickname;
  final int redOfficialVerifyType;
  final bool redOfficialVerifyShowIcon;
  final bool officialVerified;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        image: json["image"],
        nickname: json["nickname"],
        redOfficialVerifyType: json["redOfficialVerifyType"],
        redOfficialVerifyShowIcon: json["redOfficialVerifyShowIcon"],
        officialVerified: json["officialVerified"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "image": image,
        "nickname": nickname,
        "redOfficialVerifyType": redOfficialVerifyType,
        "redOfficialVerifyShowIcon": redOfficialVerifyShowIcon,
        "officialVerified": officialVerified,
      };
}
