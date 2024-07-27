import 'package:flutter/material.dart';
import '../models/news.dart';

class NewsTile extends StatelessWidget {
  final News news;

  const NewsTile({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    RegExp regex = RegExp(r'[^:]*');
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.all(8),
      child: SizedBox(
        width: double.maxFinite,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.3,
              width: MediaQuery.of(context).size.width * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      news.source.toString(),
                      maxLines: 1,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      news.title,
                      maxLines: 3,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      (int.parse(DateTime.now()
                          .difference(
                          DateTime.parse(news.time))
                          .toString()[0]) ==
                          0)
                          ? "${DateTime.now().difference(DateTime.parse(news.time)).inMinutes.toString()} min ago"
                          : "${regex.stringMatch(DateTime.now().difference(DateTime.parse(news.time)).toString())?.trim()} hr ago",
                      maxLines: 3,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 14,
                        color: Colors.black38,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.width * 0.3,
              width: MediaQuery.of(context).size.width * 0.3,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    12,
                  ),
                ),
                image: DecorationImage(
                    image: NetworkImage(
                      news.urlToImage,
                    ),
                    fit: BoxFit.cover),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
