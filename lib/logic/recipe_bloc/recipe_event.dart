import 'package:equatable/equatable.dart';

abstract class RecipeEvent extends Equatable {
  const RecipeEvent();

  @override
  List<Object?> get props => [];
}

class FetchPopularRecipes extends RecipeEvent {
  final int count;
  const FetchPopularRecipes(this.count);

  @override
  List<Object?> get props => [count];
}

class SearchRecipes extends RecipeEvent {
  final String query;
  const SearchRecipes(this.query);

  @override
  List<Object?> get props => [query];
}
