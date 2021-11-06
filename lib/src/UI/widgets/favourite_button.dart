import 'package:flutter/material.dart';
import 'package:shop2/src/UI/Style/consts.dart';
import 'package:shop2/src/cubit/auth_cubit/cubit.dart';

class GlobalFavouriteButton extends StatefulWidget {
  const GlobalFavouriteButton({Key? key, required this.cubit, required this.num}) : super(key: key);
final ShopCubit cubit;
 final int num;

  @override
  State<GlobalFavouriteButton> createState() => _GlobalFavouriteButtonState();
}

class _GlobalFavouriteButtonState extends State<GlobalFavouriteButton> {
  @override
  Widget build(BuildContext context) {
    return
      IconButton(
        onPressed: () async {
          widget.cubit.changeFavourites(
              productId: widget.cubit.favouriteModel!.data
                  .dataLoad[widget.num].product.id);
        },
        icon: const Icon(
          Icons.favorite_border,
          color: Colors.white,
        ),color: (widget.cubit.favorites[widget.cubit
          .favouriteModel!
          .data
          .dataLoad[widget.num]
          .product
          .id] ==
          true)
          ? likeColor
          : Colors.grey[400],
    );
  }
}
Widget btnFav({required ShopCubit cubit, required int num}) =>IconButton(
  onPressed: () async {
    cubit.changeFavourites(
        productId: cubit.favouriteModel!.data
            .dataLoad[num].product.id);
  },
  icon: const Icon(
    Icons.favorite_border,
    color: Colors.white,
  ),color: (cubit.favorites[cubit
    .favouriteModel!
    .data
    .dataLoad[num]
    .product
    .id] ==
    true)
    ? likeColor
    : Colors.grey[400],
);