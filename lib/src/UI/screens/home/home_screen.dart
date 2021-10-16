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
          condition: HomeCubit.get(context).homeModel != null &&
              HomeCubit.get(context).categoriesModel != null,
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context) => HomeBodyBuilder(cubit: HomeCubit.get(context)),
        );
      },
    );
  }
}

//home body
class HomeBodyBuilder extends StatelessWidget {
  const HomeBodyBuilder({Key? key, required this.cubit}) : super(key: key);
  final HomeCubit cubit;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          //home Slider
          Container(
            color: Colors.white,
            child: CarouselSlider(
              items: cubit.homeModel!.data.banners
                  .map((e) => Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Image(
                          image: NetworkImage(e.image),
                        ),
                      ))
                  .toList(),
              options: CarouselOptions(
                viewportFraction: .9,
                pageSnapping: true,
                aspectRatio: 0.6,
                autoPlay: true,
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayCurve: Curves.fastOutSlowIn,
                height: 200.0,
                initialPage: 0,
                reverse: false,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
          const SizedBox(height: 5.0),
          //categories section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    Text(
                      'categories',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const Spacer(),
                    ElevatedButton(
                      child: const Text('view all'),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5.0),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(4.0),
                height: 100.0,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => BuildCategoriesHomeItem(
                    categoriesData: cubit.categoriesModel!.data!.data[index],
                  ),
                    separatorBuilder: (context, index) => VerticalDivider(
                    width: 4.0,
                      color: Colors.grey[200],
                  ),
                  itemCount: cubit.categoriesModel!.data!.data.length,
                ),
              ),
            ],
          ),
          //products section
          const SizedBox(height: 5.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    Text(
                      'products',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const Spacer(),
                    ElevatedButton(
                      child: const Text('view all'),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 2),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.5,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                  cubit.homeModel!.data.products.length,
                  (index) => GridItem(
                    cubit: cubit,
                    index: index,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//categories at home screen
class BuildCategoriesHomeItem extends StatelessWidget {
  const BuildCategoriesHomeItem({Key? key, required this.categoriesData})
      : super(key: key);
  final DataModel categoriesData;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
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

//products items on home GRID
class GridItem extends StatelessWidget {
  const GridItem({Key? key, required this.cubit, required this.index})
      : super(key: key);
  final HomeCubit cubit;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(2.0),
      margin: const EdgeInsets.all(2.0),
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
              Row(
                children: [
                  if (cubit.homeModel!.data.products[index].discount != 0)
                    Container(
                      color: likeColor,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: const Text(
                        'DISCOUNT',
                        style: TextStyle(color: Colors.white, fontSize: 12.0),
                      ),
                    ),
                  const Spacer(),
                  //favourite button
                  IconButton(
                    onPressed: () {
                      cubit.changeFavourites(
                          productId: cubit.homeModel!.data.products[index].id);
                    },
                    icon: CircleAvatar(
                      child: const Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      ),
                      backgroundColor: (cubit.favorites[
                                  cubit.homeModel!.data.products[index].id] ==
                              true)
                          ? likeColor
                          : Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            cubit.homeModel!.data.products[index].name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "price:\$" +
                        cubit.homeModel!.data.products[index].price.toString(),
                    style: const TextStyle(fontSize: 12.0, color: defaultColor),
                  ),
                  const SizedBox(height: 5.0),
                  if (cubit.homeModel!.data.products[index].discount != 0)
                    Text(
                      "old price:\$" +
                          '${cubit.homeModel!.data.products[index].oldPrice.round()}'
                              .toString(),
                      style: TextStyle(
                          fontSize: 12.0,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey[400]),
                    ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  // fixedSize: const Size(60.0, 0.0),
                  minimumSize: const Size(60.0, 30.0),
                  maximumSize: const Size(75.0, 30.0),
                  padding: const EdgeInsets.all(0.0),
                ),
                onPressed: () {
                  // cubit.changeFavourites(
                  //     productId: cubit.homeModel!.data.products[index].id);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment:CrossAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.add_shopping_cart,
                      color: Colors.white,
                      size: 12.0,
                    ),
                    Text(
                      'Add to cart',
                      style: TextStyle(color: Colors.white, fontSize: 10.0),
                    ),
                  ],
                ),
              ),
              // ),
              // IconButton(
              //   onPressed: () {},
              //   icon: CircleAvatar(
              //     child: const Icon(
              //       Icons.add_shopping_cart,
              //       color: Colors.white,
              //       size: 22.0,
              //     ),
              //     backgroundColor: Colors.grey[400],
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
