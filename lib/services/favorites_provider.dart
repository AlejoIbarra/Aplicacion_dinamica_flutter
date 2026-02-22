import 'package:flutter/material.dart';
import 'package:app_dinamica/models/news_article.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<NewsArticle> _favorites = [];

  List<NewsArticle> get favorites => _favorites;

  void toggleFavorite(NewsArticle article) {
    if (_favorites.contains(article)) {
      _favorites.remove(article);
    } else {
      _favorites.add(article);
    }
    notifyListeners();
  }

  bool isFavorite(NewsArticle article) => _favorites.contains(article);
}
