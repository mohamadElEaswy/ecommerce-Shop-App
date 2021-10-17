import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop2/src/cubit/home_cubit/cubit.dart';
import 'package:shop2/src/cubit/home_cubit/state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) => ProductsItem(
                    cubit: cubit,
                    index: index,
                  ),
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: cubit.cartModel.data.cartItems.length,
                ),
              ),
              Text('total' + cubit.cartModel.data.total.toString()),
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
  final HomeCubit cubit;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Image(
              width: 100.0,
              height: 100.0,
              image: NetworkImage(
                  cubit.cartModel.data.cartItems[index].product.image)),
          const SizedBox(width: 5),
          Column(
            children: [
              SizedBox(
                width: 150.0,
                child: Text(
                  cubit.cartModel.data.cartItems[index].product.name,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.bodyText2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
