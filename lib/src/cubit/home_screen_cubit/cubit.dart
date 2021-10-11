import 'package:shop2/src/cubit/home_screen_cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(InitialShopState());
  static ShopCubit get(context) => BlocProvider.of(context);



}
