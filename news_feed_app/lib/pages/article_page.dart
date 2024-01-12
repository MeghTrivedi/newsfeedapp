import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_feed_app/models/article.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticlePage extends StatefulWidget {
  final Article article;
  const ArticlePage({Key? key, required this.article});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: CustomScrollView(
        slivers: [
          // Sliver app Bar
          SliverAppBar(
            title: Text(
              widget.article.source.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.4),
                  child: const Icon(Icons.chevron_left, color: Colors.white),
                ),
              ),
            ),
            centerTitle: true,
            expandedHeight: 250,
            flexibleSpace: Stack(children: [
              FlexibleSpaceBar(
                background: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                          colors: [Colors.black38, Colors.black],
                          begin: Alignment.center,
                          end: Alignment.bottomCenter)
                      .createShader(bounds),
                  blendMode: BlendMode.darken,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(widget.article.urlToImage ??
                                'https://demofree.sirv.com/nope-not-here.jpg'))),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  top: 100,
                  right: 20,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.article.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        widget.article.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(children: [
                        const Icon(
                          Icons.newspaper_sharp,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            widget.article.author ?? 'No Author',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.calendar_month_outlined,
                          color: Colors.white,
                        ),
                        Text(
                          widget.article.publishedAt.toLocal().toString(),
                          style:
                              const TextStyle(color: Colors.white, fontSize: 8),
                        )
                      ])
                    ],
                  ),
                ),
              )
            ]),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "News Content",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Colors.deepPurpleAccent),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(widget.article.content ?? 'No Content'),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () async {
                      var url = Uri.parse(widget.article.url);
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        throw 'Could not launch ${widget.article.url}';
                      }
                    },
                    child: Text(
                      widget.article.url,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.deepPurpleAccent),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
