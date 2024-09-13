import 'package:food_manage_api_cubit/model/meal_detail_model.dart';
import 'package:food_manage_api_cubit/model/meal_model.dart';

class PostState {}

class PostLoadingState extends PostState {}

class PostLoadedState extends PostState {
  final List<Meal> posts;
  PostLoadedState(
    this.posts,
  );
}

class MealLoadingState extends PostState {}

class MealLoadedState extends PostState {
  final List<MealDetail> post;
  MealLoadedState(
    this.post,
  );
}

class PostErrorState extends PostState {
  final String error;
  PostErrorState(this.error);
}
