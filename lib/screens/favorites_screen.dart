import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorite_provider.dart';
import '../widgets/recipe_card.dart';
import '../widgets/empty_state_widget.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final favoriteRecipes = favoriteProvider.favorites;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Recipes',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: favoriteRecipes.isEmpty
          ? const EmptyStateWidget(
              message: 'No favorites added yet!',
              icon: Icons.favorite_border,
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: favoriteRecipes.length,
              itemBuilder: (context, index) {
                return RecipeCard(recipe: favoriteRecipes[index]);
              },
            ),
    );
  }
}
