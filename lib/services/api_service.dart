import '../models/news_article.dart';

class ApiService {
  static Future<List<NewsArticle>> getNews() async {
    await Future.delayed(const Duration(seconds: 2));
    return [
      NewsArticle(
        title: 'News Article 1',
        description: 'Description 1',
        imageUrl:
            'https://static.vecteezy.com/system/resources/thumbnails/045/132/933/small/a-beautiful-picture-of-the-eiffel-tower-in-paris-the-capital-of-france-with-a-wonderful-background-in-wonderful-natural-colors-photo.jpg',
        content: 'Content 1',
      ),
      NewsArticle(
        title: 'News Article 2',
        description: 'Description 2',
        imageUrl:
            'https://static.vecteezy.com/system/resources/thumbnails/045/132/933/small/a-beautiful-picture-of-the-eiffel-tower-in-paris-the-capital-of-france-with-a-wonderful-background-in-wonderful-natural-colors-photo.jpg',
        content: 'Content 2',
      ),
      NewsArticle(
        title: 'News Article 3',
        description: 'Description 3',
        imageUrl:
            'https://static.vecteezy.com/system/resources/thumbnails/045/132/933/small/a-beautiful-picture-of-the-eiffel-tower-in-paris-the-capital-of-france-with-a-wonderful-background-in-wonderful-natural-colors-photo.jpg',
        content: 'Content 3',
      ),
    ];
  }
}
