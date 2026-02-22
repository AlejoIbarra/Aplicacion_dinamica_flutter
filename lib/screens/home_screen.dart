import 'package:flutter/material.dart';
import 'package:app_dinamica/services/api_service.dart';
import 'package:app_dinamica/models/news_article.dart';
import 'package:app_dinamica/screens/favorite_screen.dart';
import 'package:provider/provider.dart';
import 'package:app_dinamica/services/favorites_provider.dart';

import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = '';
  late Future<List<NewsArticle>> _newsFuture;

  @override
  void initState() {
    super.initState();
    _newsFuture = ApiService.getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noticias'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoriteScreen(savedNews: []),
                ),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar noticias...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) =>
                  setState(() => searchQuery = value.toLowerCase()),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _newsFuture = ApiService.getNews();
          });
        },
        child: FutureBuilder<List<NewsArticle>>(
          future: _newsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Error al cargar las noticias'));
            }
            if (snapshot.hasData) {
              final filteredNews = snapshot.data!.where((article) {
                return article.title.toLowerCase().contains(searchQuery) ||
                    article.description.toLowerCase().contains(searchQuery);
              }).toList();

              if (filteredNews.isEmpty) {
                return const Center(child: Text('No se encontraron noticias'));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: filteredNews.length,
                itemBuilder: (context, index) {
                  final article = filteredNews[index];
                  final favProvider = context.watch<FavoritesProvider>();
                  final isFav = favProvider.isFavorite(article);
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailScreen(article: article),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Hero(
                                tag: article.imageUrl,
                                child: Image.network(
                                  article.imageUrl,
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              PositionAt(
                                right: 10,
                                top: 10,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: IconButton(
                                    icon: Icon(
                                      isFav
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: isFav ? Colors.red : Colors.grey,
                                    ),
                                    onPressed: () {
                                      favProvider.toggleFavorite(article);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final article = snapshot.data![index];
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(article: article),
                    ),
                  ),
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Hero(
                          tag: article.imageUrl,
                          child: Image.network(
                            article.imageUrl,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        ListTile(
                          title: Text(
                            article.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(article.description),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class PositionAt extends StatelessWidget {
  final double right;
  final double top;
  final Widget child;
  const PositionAt({
    Key? key,
    required this.right,
    required this.top,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(right: right, top: top, child: child);
  }
}
