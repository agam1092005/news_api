// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/constant.dart';
import 'package:share_plus/share_plus.dart';

import '../models/news.dart';

class DetailedNews extends StatefulWidget {
  const DetailedNews({super.key});

  @override
  State<DetailedNews> createState() => _DetailedNewsState();
}

class _DetailedNewsState extends State<DetailedNews> {
  @override
  Widget build(BuildContext context) {
    final News news = ModalRoute.of(context)!.settings.arguments as News;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF303F60),
        onPressed: () {
          Share.shareUri(
            Uri.parse(
              news.url,
            ),
          );
        },
        child: const Icon(
          CupertinoIcons.share,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: const Color(0xFF0C54BE),
        actions: [
          Row(
            children: [
              Text(
                "${news.time.toString().substring(8, 10)} ${month[int.parse(news.time.toString().substring(5, 7))]}",
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
            ],
          ),
        ],
        centerTitle: false,
        title: const Text(
          'MyNews',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                height: MediaQuery.of(context).size.width,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      news.urlToImage,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black54,
                        Colors.black87,
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${news.title} (${news.source})",
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      news.author,
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        color: Colors.white60,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
            child: Text(
              "Description: ${news.description}",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
            child: Text(
              news.content,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
