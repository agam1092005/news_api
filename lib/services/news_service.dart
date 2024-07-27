import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news.dart';

class NewsService {
  static const String _apiKey = 'e80db20cc6e64bfe8100ac3b5dbc9390';

  static Future<List<News>> fetchTopHeadlines(String countryCode) async {
    final response = await http.get(
      Uri.parse('https://newsapi.org/v2/top-headlines?country=$countryCode&apiKey=$_apiKey'),
    );


    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> articles = jsonResponse['articles'];
      List<News> newsList = articles.map((item) => News.fromJson(item)).toList();
      return newsList;
    } else {
      throw Exception('Failed to load news');
    }
  }
}
