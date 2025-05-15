import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cat_provider.dart';

class LikedCatsScreen extends StatelessWidget {
  const LikedCatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final catProvider = Provider.of<CatProvider>(context);
    final likedCats = catProvider.likedCats;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Liked Cats'),
        actions: [
          DropdownButton<String>(
            hint: const Text('Filter by breed'),
            items: [
              ...catProvider.availableBreeds.map(
                (breed) => DropdownMenuItem(value: breed, child: Text(breed)),
              ),
              const DropdownMenuItem(value: 'all', child: Text('All breeds')),
            ],
            onChanged: (value) => catProvider.setFilterBreed(value ?? 'all'),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: likedCats.length,
        itemBuilder: (context, index) {
          final cat = likedCats[index];
          if (catProvider.filterBreed != 'all' &&
              cat.breedName != catProvider.filterBreed) {
            return const SizedBox.shrink();
          }
          return Dismissible(
            key: Key(cat.id),
            direction: DismissDirection.endToStart,
            background: Container(color: Colors.red),
            onDismissed: (_) => catProvider.removeLikedCat(cat),
            child: ListTile(
              leading: Image.network(cat.url, width: 50, height: 50),
              title: Text(cat.breedName),
              subtitle: Text(cat.breedDescription),
              trailing: Text(cat.dateLiked.toString()),
            ),
          );
        },
      ),
    );
  }
}
