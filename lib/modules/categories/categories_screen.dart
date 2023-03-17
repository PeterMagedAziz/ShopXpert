import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/cubit/cubit.dart';
import '../../../layout/cubit/states.dart';
import '../../../models/categories_model.dart';
import '../../../shard/component/component.dart';
import 'category_products_Screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        CategoriesModel categoriesModel =
        ShopAppCubit.get(context).categoriesModel!;

        return Scaffold(
          appBar: AppBar(
            leading: appBarLeading(context),
          ),
          body: ConditionalBuilder(
            condition: state is! ShopLoadingCategoryDataState &&
                ShopAppCubit.get(context).categoriesModel != null,
            builder: (context) => ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildCategoriesItemRow(
                    categoriesModel.data!.data[index],
                    context,
                    categoriesImage![index]),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: categoriesModel.data!.data.length),
            fallback: (context) =>
            const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}

List<String>? categoriesImage = [
  "assets/images/e1.jpg",
  "assets/images/pc1.jpg",
  "assets/images/s2.jpg",
  "assets/images/l1.jpg",
  "assets/images/c1.jpg",
];
Widget buildCategoriesItemRow(DataModel model, context, String image) =>
    InkWell(
      onTap: () {
        ShopAppCubit.get(context).getCategoriesDetailData(model.id);
        navigateTo(context, CategoryProductsDetailsScreen(model.name));
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
                width: 150.0,
                height: 150.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    color: Colors.black,
                    image: DecorationImage(
                      alignment: Alignment.center,
                      fit: BoxFit.cover,
                      image: AssetImage(image),
                    ))),
            const SizedBox(
              width: 20,
            ),
            Text(
              model.name!,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
            )
          ],
        ),
      ),
    );
