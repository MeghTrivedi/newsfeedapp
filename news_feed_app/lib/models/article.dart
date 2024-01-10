class NewsArticle {
  final String title;
  final String description;
  final String urlToImage;
  final String url;
  final String? category;
  final String? content;
  final String? author;
  final String? language;
  final String? country;

  NewsArticle(
      {required this.title,
      required this.description,
      required this.urlToImage,
      required this.url,
      this.category,
      this.content,
      this.author,
      this.language,
      this.country});

  // factory NewsArticle.fromJson(Map<String, dynamic> json) {
  //   return NewsArticle(
  //     title: json['title'],
  //     description: json['description'],
  //     urlToImage: json['urlToImage'],
  //     url: json['url'],
  //   );
  // }
}
