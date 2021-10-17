import 'package:flutter/material.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop2/src/UI/Style/consts.dart';
import 'package:shop2/src/cubit/home_cubit/cubit.dart';
import 'package:shop2/src/cubit/home_cubit/state.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return ConditionalBuilder(
          condition: state is! GetFavoritesLoadingState,
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
          builder: (context) => ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: cubit.favouriteModel!.data.dataLoad.length,
            itemBuilder: (context, index) =>
                FavouritesListItem(cubit: cubit, index: index),
          ),
        );
      },
    );
  }
}

class FavouritesListItem extends StatelessWidget {
  const FavouritesListItem({
    Key? key,
    required this.cubit,
    required this.index,
    // required this.discount
  }) : super(key: key);
  final HomeCubit cubit;
  final int index;
  final bool discount = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2.0),
      color: Colors.white,
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 120.0,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Image(
                    height: 120.0,
                    width: 120.0,
                    image: NetworkImage(cubit
                        .favouriteModel!.data.dataLoad[index].product.image),
                  ),
                  if (cubit.favouriteModel!.data.dataLoad[index].product
                          .discount !=
                      0
                  // && discount
                  )
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
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cubit.favouriteModel!.data.dataLoad[index].product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "price:\$"
                    '${cubit.favouriteModel!.data.dataLoad[index].product.price.round()}',
                    style: const TextStyle(fontSize: 12.0, color: defaultColor),
                  ),
                  const SizedBox(height: 5),
                  if (cubit.favouriteModel!.data.dataLoad[index].product
                          .discount !=
                      0
                  // && discount
                  )
                    Text(
                      "old price:"
                      '${cubit.favouriteModel!.data.dataLoad[index].product.oldPrice.round()}',
                      style: TextStyle(
                          fontSize: 12.0,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey[400]),
                    ),
                  Row(
                    children: [
                      const Spacer(),
                      IconButton(
                        onPressed: () async {
                          cubit.changeFavourites(
                              productId: cubit.favouriteModel!.data
                                  .dataLoad[index].product.id);
                          // changeFavourites(favData.product.id);
                          // model.changeFavourites(favData.product.id);
                        },
                        icon: CircleAvatar(
                          child: const Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          ),
                          backgroundColor: (cubit.favorites[cubit
                                      .favouriteModel!
                                      .data
                                      .dataLoad[index]
                                      .product
                                      .id] ==
                                  true)
                              ? likeColor
                              : Colors.grey[400],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
