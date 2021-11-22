//products items on home GRID
import 'package:flutter/material.dart';
import 'package:shop2/src/UI/Style/consts.dart';
import 'package:shop2/src/UI/screens/home/product_details/product_details.dart';
import 'package:shop2/src/core/route/const_route_functions.dart';
import 'package:shop2/src/cubit/auth_cubit/cubit.dart';

class GridItem extends StatelessWidget {
  const GridItem({Key? key, required this.cubit, required this.index})
      : super(key: key);
  final ShopCubit cubit;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        cubit.getSingleProduct(
            productId: cubit.homeModel!.data.products[index].id,
            context: context);
        navigate(
            context: context,
            newRouteName: ProductDetails.routeName,
            args: cubit.homeModel!.data.products[index].id);
      },
      child: Container(
        // height: 400.0,
        color: Colors.white,
        padding: const EdgeInsets.all(2.0),
        margin: const EdgeInsets.all(2.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Center(
                  child: Image(
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;

                      return const SizedBox(
                          height: 200.0,
                          child: Center(child: CircularProgressIndicator()));
                    },
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox(
                            height: 200.0,
                            child:
                                Center(child: Text('Some errors occurred!'))),
                    height: 200.0,
                    fit: BoxFit.fitWidth,
                    image: NetworkImage(
                      cubit.homeModel!.data.products[index].image,
                    ),
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
                    // btnFav(cubit:cubit,num: index,)/
                    // GlobalFavouriteButton(cubit:cubit,num: index,),
                    IconButton(
                      onPressed: () async {
                        cubit.changeFavourites(
                            productId:
                                cubit.homeModel!.data.products[index].id);
                      },
                      icon: CircleAvatar(
                        child: const Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                        backgroundColor: cubit.favorites[
                                    cubit.homeModel!.data.products[index].id] ==
                                true
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5.0),
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
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  padding: const EdgeInsets.all(0.0),
                ),
                onPressed: () {
                  cubit.cartPost(
                      productId: cubit.homeModel!.data.products[index].id);
                },
                child: Text(
                  cubit.homeModel!.data.products[index].inCart != true
                      ? 'Add to cart'
                      : 'Remove from Cart',
                  style: const TextStyle(color: Colors.white, fontSize: 15.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GridCategoriesItem extends StatelessWidget {
  const GridCategoriesItem({Key? key, required this.cubit, required this.index})
      : super(key: key);
  final ShopCubit cubit;
  final int index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        cubit.getSingleProduct(
            productId: cubit.homeModel!.data.products[index].id,
            context: context);
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(2.0),
        margin: const EdgeInsets.all(2.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Center(
                  child: Image(
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;

                      return const SizedBox(
                          height: 200.0,
                          child: Center(child: CircularProgressIndicator()));
                    },
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox(
                            height: 200.0,
                            child:
                                Center(child: Text('Some errors occurred!'))),
                    height: 200.0,
                    fit: BoxFit.fitWidth,
                    image: NetworkImage(
                      cubit.homeModel!.data.products[index].image,
                    ),
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
                    // IconButton(
                    //   onPressed: () async {
                    //     cubit.changeFavourites(
                    //         productId: cubit.favouriteModel!.data
                    //             .dataLoad[index].product.id);
                    //   },
                    //   icon: CircleAvatar(
                    //     child: const Icon(
                    //       Icons.favorite_border,
                    //       color: Colors.white,
                    //     ),
                    //     backgroundColor: (cubit.categoriesModel.data.data[1]. == true)
                    //         ? likeColor
                    //         : Colors.grey[400],
                    //   ),
                    // ),
                    // FavouriteButton(cubit:cubit,index: index,),
                  ],
                ),
              ],
            ),
            Text(
              cubit.homeModel!.data.products[index].name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5.0),
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
          ],
        ),
      ),
    );
  }
}
