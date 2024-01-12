import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:news_feed_app/models/article.dart';
import 'package:news_feed_app/util/log.dart';

class NewsQueries {
  static var client = http.Client();

  /// Fetches news from the News API.
  Future<List<Article>?> fetch(
      String category, String countryCode, String type, int page) async {
    String url = '';
    String apiKey = 'cc68e48dd9e94875841261446f7730f5';

    try {
      if (type == 'top-headlines') {
        url =
            "https://newsapi.org/v2/$type?country=$countryCode&category=$category&pageSize=10&page=${page.toString()}&apiKey=$apiKey";
      } else if (type == 'everything') {
        url =
            "https://newsapi.org/v2/$type?q=$category&pageSize=10&page=${page.toString()}&apiKey=$apiKey";
      }
      var res = await client.get(Uri.parse(url));
      log(this, 'Response: ${res.body}');
      if (res.statusCode == 200) {
        return newsArticleFromJson(res.body);
      } else {
        log(this, 'Unable to fetch news Res:. Error: ${res.statusCode}');
        return null;
      }
    } catch (err) {
      log(this, 'Unable to fetch news. Error: $err');
    }
  }
}
