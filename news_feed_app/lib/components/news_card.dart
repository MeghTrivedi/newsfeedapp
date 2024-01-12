import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final String title;
  final String description;
  final String? urlToImage;
  final String? url;
  final String? author;
  final String? publishedAt;
  final void Function()? onPressed;

  const NewsCard({
    Key? key,
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.author,
    required this.publishedAt,
    this.onPressed,
    this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
        width: double.infinity,
        height: 270,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white54),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(urlToImage ??
                                'https://demofree.sirv.com/nope-not-here.jpg')))),
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.black.withOpacity(0.3),
                        Colors.black.withOpacity(0.1),
                      ],
                    ),
                  ),
                ),

                /// Author, Title and, Date
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 5),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Title
                        Text(
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                            fontFamily: 'Agne',
                          ),
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        Row(
                          children: [
                            const Icon(
                              Icons.person_rounded,
                              color: Colors.white,
                            ),
                            Expanded(
                              child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.0,
                                    fontFamily: 'Agne',
                                  ),
                                  author ?? 'No Author'),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.calendar_month_outlined,
                              color: Colors.white,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                publishedAt ?? 'No Date',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Description
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                description,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
            // add a line here
            const Divider(
              color: Colors.deepPurpleAccent,
              height: 20,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
          ],
        ),
      ),
    );
  }
}
