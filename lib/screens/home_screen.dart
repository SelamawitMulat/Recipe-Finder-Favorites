import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/recipe_provider.dart';
import '../widgets/recipe_card.dart';
import '../core/widgets/loading_widget.dart';
import '../core/widgets/error_widget.dart'; // Cleanly imports your CustomErrorWidget file

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'All';
  final TextEditingController _searchController = TextEditingController();

  final List<String> _categories = [
    'All',
    'Beef',
    'Chicken',
    'Seafood',
    'Dessert',
    'Vegetarian'
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RecipeProvider>(context, listen: false).fetchRecipes();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final filteredRecipes = recipeProvider.recipes.where((recipe) {
      final matchesCategory = _selectedCategory == 'All' ||
          recipe.category.toLowerCase() == _selectedCategory.toLowerCase();

      final matchesSearch = recipe.title
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()) ||
          recipe.category
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()) ||
          recipe.instructions
              .toLowerCase()
              .contains(_searchController.text.toLowerCase());

      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Finder',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.orange),
              accountName: const Text(
                'Recipe Finder',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black),
              ),
              accountEmail: const Text(
                'Your Culinary Companion',
                style: TextStyle(color: Colors.black87),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.grey[900],
                child: const Icon(Icons.restaurant_menu,
                    color: Colors.orange, size: 36),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.orange),
              title: const Text('Home',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.favorite, color: Colors.red),
              title: const Text('Favorites',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/favorites');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.blue),
              title: const Text('Settings',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/settings');
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline, color: Colors.white70),
              title: const Text('About',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/about');
              },
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Search recipes, categories, or ingredients...',
                prefixIcon: const Icon(Icons.search),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = _selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: isSelected,
                    selectedColor: Colors.orange,
                    backgroundColor:
                        isDark ? Colors.grey[800] : Colors.grey[200],
                    labelStyle: TextStyle(
                      color: isSelected
                          ? Colors.black
                          : (isDark ? Colors.white : Colors.black87),
                      fontWeight: FontWeight.bold,
                    ),
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: () {
              // 1. Loading State
              if (recipeProvider.isLoading) {
                return const LoadingWidget();
              }

              // 2. Error State: Evaluates cleanly if any active internet connection issue is present
              if (recipeProvider.errorMessage.isNotEmpty) {
                return CustomErrorWidget(
                  message: recipeProvider.errorMessage,
                  onRetry: () => recipeProvider.fetchRecipes(),
                );
              }

              // 3. Empty Fallback State
              if (filteredRecipes.isEmpty) {
                return const Center(
                  child: Text(
                    'No recipes found matching selection.',
                    style: TextStyle(color: Colors.white54, fontSize: 16),
                  ),
                );
              }

              // 4. Success State
              return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: filteredRecipes.length,
                itemBuilder: (context, index) {
                  return RecipeCard(recipe: filteredRecipes[index]);
                },
              );
            }(),
          ),
        ],
      ),
    );
  }
}
