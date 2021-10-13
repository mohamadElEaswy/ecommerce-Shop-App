import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shop2/src/cubit/home_cubit/cubit.dart';
import 'package:shop2/src/cubit/home_cubit/state.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: cubit.body[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.items,
            onTap: (int index) {
              cubit.changeScreen(index: index);
            },
            elevation: 0.0,
            currentIndex: cubit.currentIndex,
          ),
        );
      },
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: HomeCubit.get(context).homeModel != null,
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context) => HomeBodyBuilder(cubit: HomeCubit.get(context)),
        );
      },
    );
  }
}

class HomeBodyBuilder extends StatelessWidget {
  const HomeBodyBuilder({Key? key, required this.cubit}) : super(key: key);
  final HomeCubit cubit;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CarouselSlider(
            items: cubit.homeModel!.data.banners
                .map((e) => Image(
                      image: NetworkImage(e.image),
                    ))
                .toList(),
            options: CarouselOptions(
              viewportFraction: 1.0,
              autoPlay: true,
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayCurve: Curves.fastOutSlowIn,
              height: 250.0,
              initialPage: 0,
              reverse: false,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      ),
    );
  }
}
