import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _apiKey = "c786f17c6e494077b6f280edacb984d3";
  static const String _baseUrl = "https://api.spoonacular.com/recipes";

  /// Fetch random recipes for homepage
  static Future<List<Map<String, dynamic>>> getRandomRecipes(int number) async {
    final response = await http.get(
      Uri.parse("$_baseUrl/random?number=$number&apiKey=$_apiKey"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List recipes = data['recipes'];
      return recipes.map((e) => {
            "id": e["id"],
            "title": e["title"],
            "image": e["image"],
            "readyInMinutes": e["readyInMinutes"],
          }).toList();
    } else {
      throw Exception("Failed to load random recipes: ${response.body}");
    }
  }

  /// Fetch recipes by search query
  static Future<List<Map<String, dynamic>>> searchRecipes(String query) async {
    final response = await http.get(
      Uri.parse(
        "$_baseUrl/complexSearch?query=${Uri.encodeComponent(query)}&number=12&apiKey=$_apiKey",
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List results = data['results'];
      return results.map((e) => {
            "id": e["id"],
            "title": e["title"],
            "image": e["image"],
          }).toList();
    } else {
      throw Exception("Failed to search recipes: ${response.body}");
    }
  }

  /// Fetch single recipe details (ingredients, instructions, etc.)
  static Future<Map<String, dynamic>> getRecipeDetails(int id) async {
    final response = await http.get(
      Uri.parse("$_baseUrl/$id/information?apiKey=$_apiKey"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return {
        "id": data["id"],
        "title": data["title"],
        "image": data["image"],
        "readyInMinutes": data["readyInMinutes"],
        "summary": data["summary"],
        "instructions": data["instructions"],
        "ingredients": (data["extendedIngredients"] as List)
            .map((i) => i["original"])
            .toList(),
      };
    } else {
      throw Exception("Failed to load recipe details: ${response.body}");
    }
  }
}

