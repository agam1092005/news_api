// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/auth_provider.dart';
import '../providers/news_provider.dart';
import '../services/firebase_service.dart';
import '../widgets/news_tile.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  NewsScreenState createState() => NewsScreenState();
}

class NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  var country_code = "";

  void _fetchNews() async {
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);
    try {
      String countryCode = await FirebaseService.getCountryCode();
      setState(() {
        country_code = countryCode;
      });
      await newsProvider.fetchNews(countryCode);
    } catch (e) {
      log(e.toString());
    }
  }

  void _signOut(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      await authProvider.signOut();
      Navigator.pushReplacementNamed(context, '/login');
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('loggedin', false);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF303F60),
        onPressed: () => _signOut(context),
        child: const Icon(
          Icons.logout,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF0C54BE),
        actions: [
          Row(
            children: [
              const Icon(
                CupertinoIcons.location_fill,
                size: 18,
                color: Colors.white,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                country_code.toString().toUpperCase(),
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
      body: newsProvider.newsList.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF0C54BE),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: Text(
                    "Top Headlines",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: newsProvider.newsList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          var news = newsProvider.newsList[index];
                          Navigator.pushNamed(context, '/news/details', arguments: news);
                        },
                        child: NewsTile(news: newsProvider.newsList[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
