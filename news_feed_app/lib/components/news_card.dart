import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final String title;
  final String description;
  final String? urlToImage;
  // final String url;
  final String? author;
  final String? publishedAt;

  const NewsCard({
    Key? key,
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.author,
    required this.publishedAt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.deepPurpleAccent),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white54),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.all(10),
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(urlToImage ??
                          'https://demofree.sirv.com/nope-not-here.jpg')))),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 5),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.person_rounded,
                          color: Colors.black26,
                        ),
                        Expanded(child: Text(author ?? 'No Author')),
                        const Spacer(),
                        const Icon(
                          Icons.calendar_month_outlined,
                          color: Colors.black26,
                        ),
                        Expanded(
                          child: Text(
                            publishedAt ?? 'No Date',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 10),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
