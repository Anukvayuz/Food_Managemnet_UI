import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:food_manage_api_cubit/Api/Base_Api/api.dart';
import 'package:food_manage_api_cubit/model/meal_detail_model.dart';
import 'package:food_manage_api_cubit/model/meal_model.dart';

class Repository {
  API api = API();

  Future<List<Meal>> fetchPosts() async {
    try {
      Response response = await api.sendrequest.get("/filter.php?a=Indian");
      var postMaps = response.data;
      log("type : ${postMaps.runtimeType}");
   //   log("postsss : ${postMaps["meals"]}");

      List<Meal> meals = (postMaps["meals"] as List)
          .map((meal) => Meal.fromJson(meal as Map<String, dynamic>))
          .toList();
      return meals;
    } catch (ex) {
      throw ex;
    }
  }

  Future<List<MealDetail>> fetchMealDetail(String id) async {
    try {
      Response response = await api.sendrequest.get("/lookup.php?i=$id");
      var postMap = response.data;
      log("type : ${postMap.runtimeType}");
      log("postsss : ${postMap["meals"]}");

      List<MealDetail> mealdetail = (postMap["meals"] as List)
          .map((mealdetail) =>
              MealDetail.fromJson(mealdetail as Map<String, dynamic>))
          .toList();
      return mealdetail;
    } catch (ex) {
      throw ex;
    }
  }
}

// Future<List<Model>> fetchPosts() async {
//   try {
//     Response response = await api.sendRequest.get("/posts");
//     List<dynamic> postMaps = response.data;
//     //log("type of postMap ${postMaps.runtimeType}");

//     //model ke data ko ak ak karke postmaps me convert kiya
//     return postMaps
//         .map((e) => Model.fromJson(e as Map<String, dynamic>))
//         .toList();
//   } catch (ex) {
//     throw ex;
//   }
// }
