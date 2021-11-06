import 'package:flutter/material.dart';
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
            condition: cubit.singleProduct != null,
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
            builder: (context) => Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
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
                              loadingBuilder:
                                  (context, child, loadingProgress) {
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
                                          child:
                                              Text('Some errors occurred!'))),
                              height: 200.0,
                              fit: BoxFit.contain,
                              image: NetworkImage(
                                  cubit.singleProduct!.data.images[index]),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      cubit.singleProduct!.data.name,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(height: 10.0),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
