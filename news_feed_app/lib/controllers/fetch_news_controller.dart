import 'package:get/get.dart';
import 'package:news_feed_app/models/user.dart';
import 'package:news_feed_app/queries/news_queries.dart';
import 'package:news_feed_app/util/log.dart';

import '../config/current_state.dart';
import '../models/article.dart';

class FetchNewsController extends GetxController {
  var news = List<Article>.empty().obs;
  var page = 1.obs; // Page number for pagination.
  late final CurrentState currentState = CurrentState(() => update());
  final NewsQueries newsQueries = NewsQueries();

  @override
  void onInit() {
    super.onInit();
    fetchNews();
  }

  Future<void> fetchNews({String category = ''}) async {
    if (category == '') {
      category = User.me?.categories?.first;
    }
    try {
      currentState.refresh(StateAs.loading);
      var fetchedNews =
          await newsQueries.fetch(category, 'ca', 'top-headlines', page.value);
      if (fetchedNews != null) {
        news.clear(); // clear old news.
        news.addAll(fetchedNews);
        // page.value++;
      }
    } catch (err) {
      log(this, 'Unable to fetch news. Error: $err');
    }
    currentState.refresh(StateAs.ok);
  }

  Future<void> fetchNextPage() async {
    page.value++;
    await fetchNews();
  }
}
