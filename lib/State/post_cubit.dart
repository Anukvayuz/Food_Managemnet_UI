import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_manage_api_cubit/Api/Fetch_api/post_repository.dart';
import 'package:food_manage_api_cubit/State/post_state.dart';
import 'package:food_manage_api_cubit/model/meal_detail_model.dart';
import 'package:food_manage_api_cubit/model/meal_model.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostLoadingState()) {
    fetchPosts();
  }

  Repository postRepository = Repository();
  List<Meal> posts = [];
  void fetchPosts() async {
    posts.clear();
    try {
      posts = await Repository().fetchPosts();
      emit(PostLoadedState(posts));
    } catch (ex) {
      emit(PostErrorState(ex.toString()));
    }
  }

  void fetchMealDetail(int index) async {
    emit(MealLoadingState());
    try {
      List<MealDetail> post =
          await Repository().fetchMealDetail(posts[index].idMeal ?? "");

      emit(MealLoadedState(post));
    } catch (ex) {
      emit(PostErrorState(ex.toString()));
    }
  }
}
