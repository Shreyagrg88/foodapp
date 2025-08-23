import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/data/services/api_service.dart';
import 'package:foodapp/logic/recipe_bloc/recipe_event.dart';
import 'package:foodapp/logic/recipe_bloc/recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  RecipeBloc() : super(RecipeInitial()) {
    on<FetchPopularRecipes>(_onFetchPopularRecipes);
    on<SearchRecipes>(_onSearchRecipes);
  }

  Future<void> _onFetchPopularRecipes(
      FetchPopularRecipes event, Emitter<RecipeState> emit) async {
    emit(RecipeLoading());
    try {
      final recipes = await ApiService.getRandomRecipes(event.count);
      emit(RecipeLoaded(recipes));
    } catch (e) {
      emit(RecipeError(e.toString()));
    }
  }

  Future<void> _onSearchRecipes(
      SearchRecipes event, Emitter<RecipeState> emit) async {
    emit(RecipeLoading());
    try {
      final recipes = await ApiService.searchRecipes(event.query);
      emit(RecipeLoaded(recipes));
    } catch (e) {
      emit(RecipeError(e.toString()));
    }
  }
}
