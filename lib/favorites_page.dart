import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  final List<String> favorites;

  const FavoritesPage({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Favorites'),
      ),
      body: Center(
        child: favorites.isEmpty?
         const Text('No favorites yet.')
            : ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      favorites[index],
                      width: 200,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
      ),
    );
  }
}
