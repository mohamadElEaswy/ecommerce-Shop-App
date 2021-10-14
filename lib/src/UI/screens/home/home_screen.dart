import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shop2/src/UI/Style/consts.dart';
import 'package:shop2/src/core/models/categories_model.dart';
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
          appBar: AppBar(leading: const SizedBox()),
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
          condition: HomeCubit.get(context).homeModel != null && HomeCubit.get(context).categoriesModel != null,
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
      physics: const BouncingScrollPhysics(),
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
           SizedBox(
            height: 100.0,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) =>
                  BuildCategoriesHomeItem(categoriesData: cubit.categoriesModel!.data!.data[index],),
              separatorBuilder: (context, index) => const SizedBox(
                width: 1.0,
              ),
              itemCount: cubit.categoriesModel!.data!.data.length,
            ),
          ),const SizedBox(height: 10.0),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
            childAspectRatio: 1 / 1.8,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(cubit.homeModel!.data.products.length,
                    (index) => GridItem(cubit: cubit, index: index,),
          ),),
        ],
      ),
    );
  }
}
class BuildCategoriesHomeItem extends StatelessWidget {
  const BuildCategoriesHomeItem({Key? key, required this.categoriesData}) : super(key: key);
  final DataModel categoriesData;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      height: 100.0,
      width: 100.0,
      child: Stack(
        children: [
          Image(
            image: NetworkImage(categoriesData.image),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 100.0,
              color: Colors.black45,
              child: Text(
                categoriesData.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 14.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class GridItem extends StatelessWidget {
  const GridItem({Key? key, required this.cubit, required this.index}) : super(key: key);
final HomeCubit cubit;
final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                height: 200.0,
                image: NetworkImage(
                    cubit.homeModel!.data.products[index].image,
                ),
              ),
              if (cubit.homeModel!.data.products[index].discount != 0)
                Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: const Text(
                    'DISCOUNT',
                    style: TextStyle(color: Colors.white, fontSize: 12.0),
                  ),
                ),
            ],
          ),
          Text(
            cubit.homeModel!.data.products[index].name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              Text(
                '${cubit.homeModel!.data.products[index].price.round()}',
                style: const TextStyle(fontSize: 12.0,color: defaultColor),
              ),
              const SizedBox(
                width: 10.0
              ),
              if (cubit.homeModel!.data.products[index].discount != 0)
                Text(
                  '${cubit.homeModel!.data.products[index].oldPrice.round()}',
                  style: TextStyle(
                      fontSize: 12.0,
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey[400]),
                ),
              const Spacer(),
              IconButton(
                onPressed: () async{
                  cubit.changeFavourites(cubit.homeModel!.data.products[index].id);
                },
                icon: CircleAvatar(
                  child: const Icon(
                    Icons.favorite_border,color: Colors.white,
                  ),
                  backgroundColor: (cubit.favorites[cubit.homeModel!.data.products[index].id] == true) ? defaultColor : Colors.grey[400],
                ),
              ),
              IconButton(
                onPressed: ()
                // async
                {
                  // cubit.changeFavourites(cubit.homeModel!.data.products[index].id);
                },
                icon: CircleAvatar(
                  child: const Icon(
                    Icons.add_shopping_cart,color: Colors.white,size: 22.0,
                  ),
                  backgroundColor:
                  (
                      // cubit.favorites[cubit.homeModel!.data.products[index].id] ==
                          true) ? defaultColor : Colors.grey[400],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
