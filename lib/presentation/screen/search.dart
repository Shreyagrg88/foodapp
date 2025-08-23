import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/logic/recipe_bloc/recipe_bloc.dart';
import 'package:foodapp/logic/recipe_bloc/recipe_event.dart';
import 'package:foodapp/logic/recipe_bloc/recipe_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔍 Search Bar
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Search recipes...",
                  filled: true,
                  fillColor: Colors.orange.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    context.read<RecipeBloc>().add(SearchRecipes(value));
                  }
                },
              ),
              const SizedBox(height: 16),

              // 🥘 Results
              Expanded(
                child: BlocBuilder<RecipeBloc, RecipeState>(
                  builder: (context, state) {
                    if (state is RecipeLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is RecipeError) {
                      return Center(
                        child: Text("Error: ${state.message}",
                            style: const TextStyle(color: Colors.red)),
                      );
                    } else if (state is RecipeLoaded) {
                      if (state.recipes.isEmpty) {
                        return const Center(child: Text("No recipes found"));
                      }
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
    );
  }

  // 🍲 Recipe Card
  static Widget _buildRecipeCard(String title, String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Container(color: Colors.grey.shade200),
            ),
          ),
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
