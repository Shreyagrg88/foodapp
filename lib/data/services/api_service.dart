import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _apiKey = "c786f17c6e494077b6f280edacb984d3";
  static const String _baseUrl = "https://api.spoonacular.com/recipes";

  /// Fetch random recipes for homepage
  static Future<List<dynamic>> getRandomRecipes(int number) async {
    final response = await http.get(
      Uri.parse("$_baseUrl/random?number=$number&apiKey=$_apiKey"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['recipes']; // returns list of recipes
    } else {
      throw Exception("Failed to load random recipes");
    }
  }

  /// Fetch recipes by category/search query
  static Future<List<dynamic>> searchRecipes(String query) async {
    final response = await http.get(
      Uri.parse("$_baseUrl/complexSearch?query=$query&apiKey=$_apiKey"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['results']; // returns list of recipes
    } else {
      throw Exception("Failed to search recipes");
    }
  }

  /// Fetch single recipe details
  static Future<Map<String, dynamic>> getRecipeDetails(int id) async {
    final response = await http.get(
      Uri.parse("$_baseUrl/$id/information?apiKey=$_apiKey"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load recipe details");
    }
  }
}
