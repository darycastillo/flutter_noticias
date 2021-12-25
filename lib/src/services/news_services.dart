import 'package:flutter/material.dart';
import 'package:flutter_noticias/src/models/category_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_noticias/src/models/news_models.dart';

final _URLNEWS = 'https://newsapi.org/v2';
final _APIKEY = '7af3d942429a40d6b06a9a0cc663aa1a';

class NewsService extends ChangeNotifier {
  List<Article> headlines = [];
  String _selectedCategory = 'business';
  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];
  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    getTopHeadlines();
    categories.forEach((item) {
      categoryArticles[item.name] = [];
    });
  }

  String get selectedCategory => _selectedCategory;

  set selectedCategory(String value) {
    _selectedCategory = value;
    getArticlesByCategory(value);
    notifyListeners();
  }

  List<Article> get getArticlesSelectedCategory =>
      categoryArticles[_selectedCategory]!;

  getTopHeadlines() async {
    final url = '$_URLNEWS/top-headlines?apiKey=$_APIKEY&country=us';
    final response = await http.get(Uri.parse(url));
    final newsresponse = newsResponseFromJson(response.body);
    headlines.addAll(newsresponse.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (categoryArticles[category] != null &&
        categoryArticles[category]!.isNotEmpty) {
      return;
    }
    final url =
        '$_URLNEWS/top-headlines?apiKey=$_APIKEY&country=us&category=$category';
    final response = await http.get(Uri.parse(url));
    final newsresponse = newsResponseFromJson(response.body);
    categoryArticles[category] = newsresponse.articles;
    // headlines.addAll(newsresponse.articles);
    notifyListeners();
  }
}
