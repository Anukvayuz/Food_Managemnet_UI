import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_manage_api_cubit/Screen/detail_screen.dart';
import 'package:food_manage_api_cubit/State/post_cubit.dart';
import 'package:food_manage_api_cubit/State/post_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PostCubit cubits;

  @override
  void initState() {
    // TODO: implement initState
    cubits = BlocProvider.of<PostCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("API Cubit"),
        ),
        body: SafeArea(
            child: BlocBuilder<PostCubit, PostState>(
                bloc: cubits,
                buildWhen: (previous, current) =>
                    current is PostLoadingState || current is PostLoadedState,
                builder: (context, state) {
                  if (state is PostLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is PostLoadedState) {
                    return GridView.builder(
                      itemCount: state.posts.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 15,
                              //   mainAxisSpacing: 10,
                              mainAxisExtent: 230),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          height: 300,
                          width: 250,
                          child: Column(
                            children: [
                              state.posts[index].strMealThumb == null
                                  ? SizedBox()
                                  : InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailScreen(
                                                      index: index,
                                                    )));
                                      },
                                      child: Image.network(
                                          state.posts[index].strMealThumb ??
                                              ""),
                                    ),
                              Text(state.posts[index].strMeal.toString()),
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
