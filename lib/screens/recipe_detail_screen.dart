// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/recipe_model.dart';
import '../providers/recipe_provider.dart';
import '../providers/favorite_provider.dart';
import '../providers/note_provider.dart';
import '../core/widgets/loading_widget.dart';
import '../core/constants/app_colors.dart';
import '../widgets/rating_widget.dart';

class RecipeDetailScreen extends StatefulWidget {
  final String recipeId;
  const RecipeDetailScreen({super.key, required this.recipeId});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  RecipeModel? _fullRecipe;
  bool _loading = true;
  int _currentRating = 0;
  final TextEditingController _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadRecipeDetails();
  }

  void _loadRecipeDetails() async {
    final recProv = Provider.of<RecipeProvider>(context, listen: false);
    final noteProv = Provider.of<NoteProvider>(context, listen: false);

    final details = await recProv.fetchDetailedRecipe(widget.recipeId);
    if (details != null) {
      final savedNote = noteProv.getNoteForMeal(widget.recipeId);
      setState(() {
        _fullRecipe = details;
        _loading = false;
        if (savedNote != null) {
          _currentRating = savedNote.rating;
          _notesController.text = savedNote.content;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Scaffold(body: LoadingWidget());
    if (_fullRecipe == null)
      return const Scaffold(
          body: Center(child: Text("Error fetching details")));

    final recipe = _fullRecipe!;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: AppColors.realBackgroundDark,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                recipe.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              background: Image.network(recipe.thumbnailUrl, fit: BoxFit.cover),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryCoral,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.edit_note, color: Colors.white),
                    label: const Text("Add Note & Rating",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    onPressed: () => _showAddNoteModal(context, recipe.id),
                  ),
                  const SizedBox(height: 24),
                  const Text("Ingredients",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  const SizedBox(height: 12),
                  ...recipe.ingredients.map((ing) => Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(
                            bottom: 8), // Standard backward-compatible fix here
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.cardBackgroundDark,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.lens,
                                size: 8, color: AppColors.primaryCoral),
                            const SizedBox(width: 12),
                            Expanded(
                                child: Text(ing,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 15))),
                          ],
                        ),
                      )),
                  const SizedBox(height: 24),
                  const Text("Instructions",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  const SizedBox(height: 12),
                  Text(
                    recipe.instructions ?? 'No dynamic instructions provided.',
                    style: const TextStyle(
                        color: AppColors.textSecondaryDark,
                        fontSize: 15,
                        height: 1.5),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _showAddNoteModal(BuildContext context, String mealId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.realBackgroundDark,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  top: 20,
                  left: 16,
                  right: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Your Rating",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  const SizedBox(height: 8),
                  RatingWidget(
                    rating: _currentRating,
                    size: 32,
                    onRatingSelected: (val) =>
                        setModalState(() => _currentRating = val),
                  ),
                  const SizedBox(height: 16),
                  const Text("Your Notes",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _notesController,
                    maxLines: 4,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "What did you think?",
                      hintStyle: const TextStyle(color: Colors.grey),
                      fillColor: AppColors.cardBackgroundDark,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonSaveColor,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      Provider.of<NoteProvider>(context, listen: false)
                          .saveOrUpdateNote(
                              mealId, _notesController.text, _currentRating);
                      Navigator.pop(context);
                    },
                    child: const Text("Save Note",
                        style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
