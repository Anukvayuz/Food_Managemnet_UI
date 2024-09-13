import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_manage_api_cubit/State/post_cubit.dart';
import 'package:food_manage_api_cubit/State/post_state.dart';

// ignore: must_be_immutable
class DetailScreen extends StatefulWidget {
  int index;
  DetailScreen({super.key, required this.index});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late PostCubit cubit;
  @override
  void initState() {
    // TODO: implement initState

    cubit = BlocProvider.of<PostCubit>(context);
    cubit.fetchMealDetail(widget.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("List Details"),
        ),
        body: SafeArea(
            child: BlocBuilder<PostCubit, PostState>(
                bloc: cubit,
                buildWhen: (previous, current) =>
                    current is MealLoadedState || current is MealLoadingState,
                builder: (context, state) {
                  if (state is MealLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is MealLoadedState) {
                    return ListView.builder(
                      itemCount: state.post.length,
                      itemBuilder: (context, index) {
                        return Expanded(
                          child: Column(
                            children: [
                              state.post[index].strMealThumb == null
                                  ? SizedBox()
                                  : Container(
                                      height: 300.0,
                                      width: 350.0,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40)),
                                      child: Image.network(
                                          state.post[index].strMealThumb ?? ""),
                                    ),
                              Text(state.post[index].idMeal.toString()),
                              Text(state.post[index].strMeal.toString()),
                              Text(state.post[index].strCategory.toString()),
                              Text(state.post[index].strArea.toString()),
                              Text(state.post[index].strMeal.toString()),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (state is PostErrorState) {
                    return const Text("Error");
                  }
                  return const Center(
                    child: Text("Error"),
                  );
                })));
  }
}
