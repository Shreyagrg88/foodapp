import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/data/services/api_service.dart';
import 'recipe_event.dart';
import 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  RecipeBloc() : super(RecipeInitial()) {
    on<FetchPopularRecipes>(_onFetchPopularRecipes);
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
}
