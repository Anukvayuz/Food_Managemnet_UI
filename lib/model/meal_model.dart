// To parse this JSON data, do
//
//     final mealModel = mealModelFromJson(jsonString);

import 'dart:convert';

MealModel mealModelFromJson(String str) => MealModel.fromJson(json.decode(str));

String mealModelToJson(MealModel data) => json.encode(data.toJson());

class MealModel {
    final List<Meal>? meals;

    MealModel({
        this.meals,
    });

    MealModel copyWith({
        List<Meal>? meals,
    }) => 
        MealModel(
            meals: meals ?? this.meals,
        );

    factory MealModel.fromJson(Map<String, dynamic> json) => MealModel(
        meals: json["meals"] == null ? [] : List<Meal>.from(json["meals"]!.map((x) => Meal.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "meals": meals == null ? [] : List<dynamic>.from(meals!.map((x) => x.toJson())),
    };
}

class Meal {
    final String? strMeal;
    final String? strMealThumb;
    final String? idMeal;

    Meal({
        this.strMeal,
        this.strMealThumb,
        this.idMeal,
    });

    Meal copyWith({
        String? strMeal,
        String? strMealThumb,
        String? idMeal,
    }) => 
        Meal(
            strMeal: strMeal ?? this.strMeal,
            strMealThumb: strMealThumb ?? this.strMealThumb,
            idMeal: idMeal ?? this.idMeal,
        );

    factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        strMeal: json["strMeal"],
        strMealThumb: json["strMealThumb"],
        idMeal: json["idMeal"],
    );

    Map<String, dynamic> toJson() => {
        "strMeal": strMeal,
        "strMealThumb": strMealThumb,
        "idMeal": idMeal,
    };
}
