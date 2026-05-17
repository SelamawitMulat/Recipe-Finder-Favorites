import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/recipe_provider.dart';
import '../routes/app_routes.dart';
import '../widgets/category_chip.dart';
import '../widgets/recipe_card.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/custom_drawer.dart';
import '../core/widgets/loading_widget.dart';
import '../core/widgets/error_widget.dart';
import '../core/constants/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _categories = [
    'All',
    'Beef',
    'Chicken',
    'Seafood',
    'Dessert',
    'Vegetarian'
  ];
  String _activeCategory = 'All';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RecipeProvider>(context, listen: false).fetchHomeRecipes();
    });
  }

  void _onCategorySelected(String category) {
    setState(() {
      _activeCategory = category;
      _searchController.clear();
    });
    Provider.of<RecipeProvider>(context, listen: false)
        .fetchHomeRecipes(category: category);
  }

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Finder',
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => recipeProvider.fetchHomeRecipes(
                search: _searchController.text, category: _activeCategory),
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.favorites),
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            SearchBarWidget(
              controller: _searchController,
              onSubmitted: (val) {
                setState(() => _activeCategory = 'All');
                recipeProvider.fetchHomeRecipes(search: val);
              },
              onClear: () {
                _searchController.clear();
                recipeProvider.fetchHomeRecipes(category: _activeCategory);
              },
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 45,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  return CategoryChip(
                    label: _categories[index],
                    isSelected: _activeCategory == _categories[index],
                    onTap: () => _onCategorySelected(_categories[index]),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: RefreshIndicator(
                color: AppColors.primaryCoral,
                onRefresh: () => recipeProvider.fetchHomeRecipes(
                    search: _searchController.text, category: _activeCategory),
                child: recipeProvider.isLoading
                    ? const LoadingWidget()
                    : recipeProvider.errorMessage.isNotEmpty
                        ? CustomErrorWidget(
                            errorMessage: recipeProvider.errorMessage,
                            onRetry: () => recipeProvider.fetchHomeRecipes(
                                search: _searchController.text,
                                category: _activeCategory),
                          )
                        : recipeProvider.recipes.isEmpty
                            ? const Center(
                                child: Text('No Recipes Found.',
                                    style: TextStyle(color: Colors.white)),
                              )
                            : ListView.builder(
                                itemCount: recipeProvider.recipes.length,
                                itemBuilder: (context, index) {
                                  return RecipeCard(
                                      recipe: recipeProvider.recipes[index]);
                                },
                              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
