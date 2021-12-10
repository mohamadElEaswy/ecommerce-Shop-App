import 'package:flutter/material.dart';
import 'package:shop2/src/UI/Style/consts.dart';
import 'package:shop2/src/cubit/auth_cubit/cubit.dart';
import 'package:shop2/src/cubit/auth_cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key, required this.productId}) : super(key: key);
  static const routeName = 'productDetails';
  final dynamic productId;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: ConditionalBuilder(
            condition: !cubit.loadSingleProduct,
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
            builder: (context) => SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            padding: const EdgeInsets.all(0.0),
                          ),
                          onPressed: () => cubit.cartPost(
                              productId: cubit.singleProduct!.data.id),
                          child: Text(
                            cubit.singleProduct!.data.inCart
                                ? 'Add to cart'
                                : 'Remove from Cart',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () async {
                          cubit.changeFavourites(
                              productId: cubit.singleProduct!.data.id);
                        },
                        icon: CircleAvatar(
                          child: const Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          ),
                          backgroundColor:
                              cubit.favorites[cubit.singleProduct!.data.id] ==
                                      true
                                  ? likeColor
                                  : Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    height: 300.0,
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 8.0),
                      itemCount: cubit.singleProduct!.data.images.length,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          color: Colors.white,
                          child: Image(
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const SizedBox(
                                  height: 200.0,
                                  child: Center(
                                      child: CircularProgressIndicator()));
                            },
                            errorBuilder: (context, error, stackTrace) =>
                                const SizedBox(
                                    height: 200.0,
                                    child: Center(
                                        child: Text('Some errors occurred!'))),
                            height: 200.0,
                            fit: BoxFit.contain,
                            image: NetworkImage(
                                cubit.singleProduct!.data.images[index]),
                          ),
                        );
                      },
                    ),
                  ),
                  if (cubit.singleProduct!.data.discount != 0)
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        color: likeColor,
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: const Text(
                          'DISCOUNT',
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                        ),
                      ),
                    ),
                  const SizedBox(height: 10.0),
                  Text(
                    cubit.singleProduct!.data.name,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      Text(
                        'price: ${cubit.singleProduct!.data.price.toString()} \$',
                        style: const TextStyle(color: defaultColor),
                      ),
                      const SizedBox(width: 30.0),
                      if (cubit.singleProduct!.data.discount != 0)
                        Text(
                          'old price: ${cubit.singleProduct!.data.oldPrice.toString()} \$',
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey[400],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    cubit.singleProduct!.data.description,
                    style: const TextStyle(color: Colors.black87),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
