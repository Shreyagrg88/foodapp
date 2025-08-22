import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/logic/recipe_bloc/recipe_bloc.dart';
import 'package:foodapp/logic/recipe_bloc/recipe_event.dart';
import 'package:foodapp/logic/recipe_bloc/recipe_state.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RecipeBloc()..add(const FetchPopularRecipes(8)),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔍 Search Bar
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: "Search",
                    filled: true,
                    fillColor: Colors.orange.shade50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // 🟩 Category Chips
                SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildCategoryChip("Soup"),
                      _buildCategoryChip("Seafood"),
                      _buildCategoryChip("Sushi"),
                      _buildCategoryChip("Chicken"),
                      _buildCategoryChip("Salad"),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // 📌 Recipes Grid
                Expanded(
                  child: BlocBuilder<RecipeBloc, RecipeState>(
                    builder: (context, state) {
                      if (state is RecipeLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is RecipeError) {
                        return Center(
                            child: Text("Error: ${state.message}",
                                style: const TextStyle(color: Colors.red)));
                      } else if (state is RecipeLoaded) {
                        return GridView.builder(
                          itemCount: state.recipes.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.8,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemBuilder: (context, index) {
                            final recipe = state.recipes[index];
                            return _buildRecipeCard(
                              recipe['title'] ?? "No title",
                              recipe['image'] ?? "",
                            );
                          },
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🟩 Category Chip
  static Widget _buildCategoryChip(String label) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: Chip(
        label: Text(label),
        backgroundColor: Colors.orange.shade50,
        labelStyle: const TextStyle(color: Colors.black),
      ),
    );
  }

  // 🍲 Recipe Card
  static Widget _buildRecipeCard(String title, String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Container(color: Colors.grey.shade200),
            ),
          ),

          // Gradient overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),

          // Title
          Positioned(
            left: 8,
            bottom: 8,
            right: 8,
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
