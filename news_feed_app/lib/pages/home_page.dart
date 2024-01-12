import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_feed_app/components/news_card.dart';
import 'package:news_feed_app/controllers/auth_controller.dart';
import 'package:news_feed_app/controllers/fetch_news_controller.dart';
import 'package:news_feed_app/pages/article_page.dart';
import '../models/article.dart';
import '../models/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selected = '';

  @override
  void initState() {
    _selected = User.me?.categories?.first ?? '';
    super.initState();
    Get.put(FetchNewsController());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (_) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: const Text(
              'Your News Feed',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                fontFamily: 'Horizon',
              ),
            )),
        body: Column(children: [
          Expanded(
            child: GetBuilder<FetchNewsController>(
              builder: (ctrl) {
                if (ctrl.currentState.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (ctrl.currentState.isError) {
                  return const Center(child: Text('Error loading news'));
                } else {
                  return ListView.builder(
                    itemCount: ctrl.news.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: _chips(User.me?.categories ?? []));
                      }
                      Article article = ctrl.news[index - 1];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: NewsCard(
                            onPressed: () {
                              Get.to(() => ArticlePage(
                                    article: article,
                                  ));
                            },
                            title: article.title,
                            description: article.description,
                            urlToImage: article.urlToImage,
                            author: article.author,
                            publishedAt: article.publishedAt.toString()),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ]),
      );
    });
  }

  Color _colorGeneratorBasedOnIndex(int index) {
    final colors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.yellow,
      Colors.orange,
      Colors.pink,
      Colors.purple,
    ].map((e) => e.withOpacity(0.5)).toList();

    return colors[index % colors.length];
  }

  _chips(List<dynamic> categories) {
    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // Make the ListView horizontal
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final isSelected = _selected ==
              categories[
                  index]; // Check if the current category is the selected one
          return Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            child: ChoiceChip(
              selectedColor: _colorGeneratorBasedOnIndex(index),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide(color: Colors.deepPurpleAccent),
              ),
              backgroundColor: Colors.white,
              label: Padding(
                padding: const EdgeInsets.all(4.0), // Reduce the padding
                child: Text(
                  categories[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontSize: 10.0, // Decrease the font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              selected: isSelected,
              onSelected: (bool selected) {
                setState(() {
                  if (selected) {
                    _selected =
                        (categories[index]); // Set the selected category
                    Get.find<FetchNewsController>()
                        .fetchNews(category: _selected);
                  } else {
                    _selected = '';
                    Get.find<FetchNewsController>()
                        .fetchNews(category: _selected);
                  }
                });
              },
            ),
          );
        },
      ),
    );
  }
}
