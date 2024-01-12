import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_feed_app/pages/article_page.dart';

import '../components/news_card.dart';
import '../components/news_feed_input_field.dart';
import '../controllers/fetch_news_controller.dart';
import '../controllers/future_queue_controller.dart';
import '../controllers/search_news_controller.dart';
import '../models/article.dart';
import '../util/input_debouncer.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchNewsCtrl = Get.put(SearchNewsController());
  final _searchCtrl = TextEditingController();
  final _futureQueueCtrl = Get.put(FutureQueueController());
  final _focusNode = FocusNode();

  late final _debouncer = InputDebouncer(
    delay: const Duration(milliseconds: 500),
  );

  @override
  void initState() {
    super.initState();
  }

  _fetch() {
    _debouncer.call(() {
      if (_searchCtrl.text.trim() != '') {
        _searchNewsCtrl.setSearchValue(_searchCtrl.text);
        _futureQueueCtrl.addFuture(_searchNewsCtrl.fetchNews(
            type: 'everything', category: _searchCtrl.text.trim()));
      }
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Search')),
      body: Center(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10.0, top: 15, bottom: 10),
            child: NewsFeedInputField(
              hintText: 'Search...',
              onChanged: (val) {
                _searchCtrl.text = val;
                _fetch();
                return true;
              },
            ),
          ),
          Expanded(
            child: GetBuilder<FetchNewsController>(
                init: Get.find<FetchNewsController>(),
                builder: (newsCtrl) {
                  return GetBuilder<SearchNewsController>(
                      init: _searchNewsCtrl,
                      builder: (controller) {
                        if (_searchNewsCtrl.currentState.isLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (_searchNewsCtrl.currentState.isError) {
                          return const Center(
                              child: Text('Error loading news'));
                        } else {
                          return ListView.builder(
                            itemCount: controller.news.length,
                            itemBuilder: (context, index) {
                              Article article = controller.news[index];
                              return NewsCard(
                                onPressed: () => ArticlePage(article: article),
                                title: article.title,
                                description: article.description,
                                urlToImage: article.urlToImage,
                                author: article.author,
                                publishedAt: article.publishedAt.toString(),
                              );
                            },
                          );
                        }
                      });
                }),
          ),
        ]),
      ),
    );
  }
}
