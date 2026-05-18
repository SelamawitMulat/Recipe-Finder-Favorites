// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/recipe_provider.dart';
import '../widgets/recipe_card.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/category_chip.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/skeleton_card.dart';
import '../core/widgets/error_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _categories = [
    'All',
    'Breakfast',
    'Lunch',
    'Dinner',
    'Dessert'
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RecipeProvider>(context, listen: false).fetchRecipes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Finder',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      drawer: const CustomDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchBarWidget(
              onChanged: (query) => recipeProvider.searchRecipes(query),
            ),
          ),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = recipeProvider.selectedCategory == category;
                return CategoryChip(
                  category: category,
                  isSelected: isSelected,
                  onSelected: () => recipeProvider.filterByCategory(category),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _buildRecipeContent(recipeProvider),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeContent(RecipeProvider provider) {
    if (provider.isLoading) {
      return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 5,
        itemBuilder: (context, index) => const SkeletonCard(),
      );
    }

    if (provider.errorMessage.isNotEmpty) {
      return CustomErrorWidget(
        message: provider.errorMessage,
        onRetry: () => provider.fetchRecipes(),
      );
    }

    if (provider.recipes.isEmpty) {
      return const Center(
        child: Text(
          'No recipes found.',
          style: TextStyle(fontSize: 16, color: Colors.white54),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: provider.recipes.length,
      itemBuilder: (context, index) {
        return RecipeCard(recipe: provider.recipes[index]);
      },
    );
  }
}
