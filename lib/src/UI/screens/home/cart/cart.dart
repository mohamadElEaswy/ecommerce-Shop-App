import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop2/src/UI/Style/consts.dart';
import 'package:shop2/src/cubit/auth_cubit/cubit.dart';
import 'package:shop2/src/cubit/auth_cubit/state.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => ProductsItem(
                    cubit: cubit,
                    index: index,
                  ),
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: cubit.cartModel.data.cartItems.length,
                ),
              ),
              Text(
                'total price: ' + cubit.cartModel.data.total.toString() + ' \$',
                style: const TextStyle(color: activeColor, fontSize: 16.0),
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      child: const Text('Purchase'), onPressed: () {})),
            ],
          ),
        );
      },
    );
  }
}

class ProductsItem extends StatelessWidget {
  const ProductsItem({Key? key, required this.cubit, required this.index})
      : super(key: key);
  final ShopCubit cubit;
  final int index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        cubit.getSingleProduct(
            productId: cubit.homeModel!.data.products[index].id, context: context);
      },
      child: Container(
        color: Colors.white,
        child: Row(
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image(
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
                    width: 100.0,
                    height: 100.0,
                    image: NetworkImage(
                        cubit.cartModel.data.cartItems[index].product.image)),
                if (cubit.cartModel.data.cartItems[index].product.discount != 0)
                  Container(
                    color: likeColor,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(color: Colors.white, fontSize: 12.0),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 180.0,
                  child: Text(
                    cubit.cartModel.data.cartItems[index].product.name,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.bodyText2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  'price: ' +
                      cubit.cartModel.data.cartItems[index].product.price
                          .toString() +
                      ' \$',
                  maxLines: 2,
                  style: const TextStyle(color: activeColor),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5.0),
                if (cubit.cartModel.data.cartItems[index].product.discount != 0)
                  Text(
                    "old price:\$" +
                        '${cubit.cartModel.data.cartItems[index].product.oldPrice.round()}'
                            .toString(),
                    style: TextStyle(
                        fontSize: 12.0,
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey[400]),
                  ),
                const SizedBox(height: 5.0),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          cubit.cartQuantity(
                            cartItemId:
                                cubit.cartModel.data.cartItems[index].id,
                            quantity:
                                cubit.cartModel.data.cartItems[index].quantity +
                                    1,
                          );
                        },
                        icon: const Icon(Icons.add)),
                    Text(cubit.cartModel.data.cartItems[index].quantity
                        .toString()),
                    IconButton(
                        onPressed: () {
                          if (cubit.cartModel.data.cartItems[index].quantity >
                              1) {
                            cubit.cartQuantity(
                              cartItemId:
                                  cubit.cartModel.data.cartItems[index].id,
                              quantity: cubit.cartModel.data.cartItems[index]
                                      .quantity -
                                  1,
                            );
                          }
                        },
                        icon: const Icon(Icons.minimize)),
                  ],
                )
              ],
            ),
            IconButton(
              onPressed: () {
                cubit.changeFavourites(productId: cubit.homeModel!.data.products[index].id);
              },
              icon: CircleAvatar(
                child: const Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                ),
                backgroundColor:
                    (cubit.favorites[cubit.homeModel!.data.products[index].id] == true)
                        ? likeColor
                        : Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
