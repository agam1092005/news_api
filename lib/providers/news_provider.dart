import 'dart:developer';

import 'package:flutter/material.dart';
import '../services/news_service.dart';
import '../models/news.dart';

class NewsProvider with ChangeNotifier {
  List<News> _newsList = [];

  List<News> get newsList => _newsList;

  Future<void> fetchNews(String countryCode) async {
    try {
      _newsList = await NewsService.fetchTopHeadlines(countryCode);
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }
}