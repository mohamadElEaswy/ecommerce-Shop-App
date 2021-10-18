import 'package:flutter/material.dart';
import 'package:shop2/src/UI/Style/consts.dart';
import 'package:shop2/src/UI/widgets/grid_item.dart';
import 'package:shop2/src/core/models/categories_model.dart';
import 'package:shop2/src/cubit/home_cubit/cubit.dart';
import 'package:shop2/src/cubit/home_cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.grey[100],
              width: 100.0,
              height: double.infinity,
              child: Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8.0),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => BuildCategoriesItem(
                      cubit: cubit,
                      categoriesData: cubit.categoriesModel!.data!.data[index],
                    ),
                    separatorBuilder: (context, index) => const Divider(
                      height: 4.0,
                      color: defaultColor,
                    ),
                    itemCount: cubit.categoriesModel!.data!.data.length,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.grey[100],
                child: (cubit.categoriesDetailsModel.status != null)
                    ? GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        mainAxisSpacing: 1.0,
                        crossAxisSpacing: 1.0,
                        childAspectRatio: 1 / 1.8,
                        physics: const BouncingScrollPhysics(),
                        children:
                            // cubit.categoriesDetailsModel != null ?
                            List.generate(
                          cubit.categoriesDetailsModel.data!.data.length,
                          (index) => GridCategoriesItem(
                            cubit: cubit,
                            index: index,
                          ),
                        ),
                        // : Center(child: Text,)
                      )
                    : const Center(
                        child: Text('No products'),
                      ),
              ),
            )
          ],
        );
      },
    );
  }
}

class BuildCategoriesItem extends StatelessWidget {
  const BuildCategoriesItem(
      {Key? key, required this.categoriesData, required this.cubit
      // required this.onTap
      })
      : super(key: key);
  final DataModel categoriesData;
  final HomeCubit cubit;
  // final Function onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        cubit.getCategoriesDetails(categoryId: categoriesData.id);
      },
      child: Container(
        padding: const EdgeInsets.all(4.0),
        height: 50.0,
        width: 100.0,
        child: Text(
          categoriesData.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ),
    );
  }
}
