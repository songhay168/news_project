import 'dart:convert';

import 'respone_model.dart';

// Function to parse JSON string to NewsModel object
NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));

// Function to convert NewsModel object to JSON string
String newsModelToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel extends ResponeModel {
  String status;
  int totalResults;
  List<Article> articles;

  @override
  String getStatus() => status;

  NewsModel({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  // Factory constructor to create NewsModel from JSON
  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        status: json["status"] ?? "unknown", // Default status
        totalResults: json["totalResults"] ?? 0, // Default totalResults
        articles: json["articles"] != null
            ? List<Article>.from(
                json["articles"].map((x) => Article.fromJson(x)))
            : [], // Default empty list if null
      );

  // Method to convert NewsModel to JSON
  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
      };
}

class Article {
  Source source;
  String? author;
  String title;
  String description;
  String url;
  String? urlToImage;
  DateTime publishedAt;
  String content;

  Article({
    required this.source,
    this.author,
    required this.title,
    required this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  // Factory constructor to create Article from JSON
  factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: Source.fromJson(json["source"] ?? {}), // Default Source if null
        author: json["author"] ?? "Anonymous", // Default author
        title: json["title"] ?? "No Title", // Default title
        description:
            json["description"] ?? "No Description", // Default description
        url: json["url"] ?? "", // Default empty URL
        urlToImage: json["urlToImage"], // Keep nullable
        publishedAt: json["publishedAt"] != null
            ? DateTime.parse(json["publishedAt"])
            : DateTime.now(), // Default to current date
        content: json["content"] ?? "No Content", // Default content
      );

  // Method to convert Article to JSON
  Map<String, dynamic> toJson() => {
        "source": source.toJson(),
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt.toIso8601String(),
        "content": content,
      };
}

class Source {
  Id? id;
  Name name;

  Source({
    this.id,
    required this.name,
  });

  // Factory constructor to create Source from JSON
  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"] != null
            ? idValues.map[json["id"]]
            : null, // Keep nullable
        name: json["name"] != null
            ? nameValues.map[json["name"]] ?? Name.REMOVED
            : Name.REMOVED, // Default name
      );

  // Method to convert Source to JSON
  Map<String, dynamic> toJson() => {
        "id": id != null ? idValues.reverse[id] : null, // Keep nullable
        "name": nameValues.reverse[name],
      };
}

enum Id { ARS_TECHNICA, BUSINESS_INSIDER, THE_VERGE, WIRED }

final idValues = EnumValues({
  "ars-technica": Id.ARS_TECHNICA,
  "business-insider": Id.BUSINESS_INSIDER,
  "the-verge": Id.THE_VERGE,
  "wired": Id.WIRED
});

enum Name {
  ANDROID_CENTRAL,
  ARS_TECHNICA,
  BBC_NEWS,
  BUSINESS_INSIDER,
  GIZMODO_COM,
  REMOVED,
  THE_VERGE,
  WIRED,
  YAHOO_ENTERTAINMENT
}

// Add this extension to the Name enum
extension NameExtension on Name {
  String get displayName {
    switch (this) {
      case Name.ANDROID_CENTRAL:
        return "Android Central";
      case Name.ARS_TECHNICA:
        return "Ars Technica";
      case Name.BBC_NEWS:
        return "BBC News";
      case Name.BUSINESS_INSIDER:
        return "Business Insider";
      case Name.GIZMODO_COM:
        return "Gizmodo.com";
      case Name.REMOVED:
        return "[Removed]";
      case Name.THE_VERGE:
        return "The Verge";
      case Name.WIRED:
        return "Wired";
      case Name.YAHOO_ENTERTAINMENT:
        return "Yahoo Entertainment";
    }
  }
}

final nameValues = EnumValues({
  "Android Central": Name.ANDROID_CENTRAL,
  "Ars Technica": Name.ARS_TECHNICA,
  "BBC News": Name.BBC_NEWS,
  "Business Insider": Name.BUSINESS_INSIDER,
  "Gizmodo.com": Name.GIZMODO_COM,
  "[Removed]": Name.REMOVED,
  "The Verge": Name.THE_VERGE,
  "Wired": Name.WIRED,
  "Yahoo Entertainment": Name.YAHOO_ENTERTAINMENT
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
