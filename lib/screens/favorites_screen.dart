import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorite_provider.dart';
import '../widgets/recipe_card.dart';
import '../widgets/empty_state_widget.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favsProvider = Provider.of<FavoriteProvider>(context);
    final favList = favsProvider.favorites;

    return Scaffold(
      appBar: AppBar(title: const Text('My Favorites')),
      body: favList.isEmpty
          ? const EmptyStateWidget(
              title: "No Favorites Yet",
              message:
                  "Start adding recipes to your favorites by tapping the heart icon",
              icon: Icons.favorite_border,
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favList.length,
              itemBuilder: (context, index) {
                return RecipeCard(recipe: favList[index].recipe);
              },
            ),
    );
  }
}
