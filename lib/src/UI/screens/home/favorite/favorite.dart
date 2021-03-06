import 'package:flutter/material.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop2/src/UI/Style/consts.dart';
import 'package:shop2/src/cubit/auth_cubit/cubit.dart';
import 'package:shop2/src/cubit/auth_cubit/state.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return
            cubit.favouriteModel!.data.total == 0
              ? const EmptyFavouriteList()
              :
            ConditionalBuilder(
          condition: cubit.favouriteModel != null,
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

class EmptyFavouriteList extends StatelessWidget {
  const EmptyFavouriteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Your favourite list is Empty'),
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
  final ShopCubit cubit;
  final int index;
  final bool discount = true;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // cubit.getSingleProduct(
        //     productId: cubit.homeModel!.data.products[index].id, context: context);
      },
      child: Container(
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
                      image: NetworkImage(
                        cubit
                            .favouriteModel!.data.dataLoad[index].product.image,
                      ),
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
                      style:
                          const TextStyle(fontSize: 12.0, color: defaultColor),
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
      ),
    );
  }
}
