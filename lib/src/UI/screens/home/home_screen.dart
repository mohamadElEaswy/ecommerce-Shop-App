import 'package:flutter/material.dart';
import 'package:shop2/src/core/models/home_model.dart';
import 'package:shop2/src/cubit/home_screen_cubit/cubit.dart';
import 'package:shop2/src/cubit/home_screen_cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
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

    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel! != null,
              // && cubit.categoriesModel != null

          builder: (context) =>
               homeBodyBuilder(
                   model: cubit.homeModel!,
                // cubit.categoriesModel!, cubit
              ),
          fallback: (context) =>
              const Center(
                child: CircularProgressIndicator(),
              ),
        );
      },
    );
  }
}


Widget homeBodyBuilder({required HomeModel model}) =>SingleChildScrollView(
  physics: const BouncingScrollPhysics(),
  child: Column(children: [
    CarouselSlider(
      items: model.data.banners
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
  ],),
);