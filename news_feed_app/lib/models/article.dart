import 'dart:convert';

import 'package:news_feed_app/util/log.dart';

/// Function that takes a JSON string str, decodes it into a Dart object,
/// and then maps each article in the
/// 'articles' list to an Article object.
/// [Param] String str
List<Article> newsArticleFromJson(String str) => List<Article>.from(json
    .decode(str)['articles']
    .map((x) => Article.fromJson(Map<String, dynamic>.from(x))));

class Article {
  final String title;
  final String description;
  final String? urlToImage;
  final String url;
  final String? content;
  final String? author;
  final String? language;
  final String? country;
  final DateTime publishedAt;
  Source source;

  Article({
    required this.source,
    required this.title,
    required this.description,
    required this.url,
    required this.publishedAt,
    this.urlToImage,
    this.content,
    this.author,
    this.language,
    this.country,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: Source.fromJson(json["source"]),
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      urlToImage: json['urlToImage'],
      url: json['url'] ?? 'No URL',
      content: json['content'],
      author: json['author'],
      language: json['language'],
      publishedAt: DateTime.parse(json['publishedAt']),
    );
  }
}

class Source {
  dynamic id;
  String name;

  Source({this.id, required this.name});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'],
      name: json['name'],
    );
  }
}
