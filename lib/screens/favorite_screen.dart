import 'package:flutter/material.dart';
import 'package:app_dinamica/models/news_article.dart';

class FavoriteScreen extends StatelessWidget {
  final List<NewsArticle> savedNews;

  const FavoriteScreen({Key? key, required this.savedNews}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favoritos'), centerTitle: true),
      body: savedNews.isEmpty
          ? const Center(child: Text('No hay noticias favoritas'))
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: savedNews.length,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      savedNews[index].imageUrl,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    savedNews[index].title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text('Guardado en favoritos'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Noticia eliminada de favoritos: ${savedNews[index].title}',
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
    );
  }
}
