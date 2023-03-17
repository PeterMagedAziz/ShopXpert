import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_app/layout/cubit/cubit.dart';
import 'package:salla_app/layout/cubit/states.dart';
import 'package:salla_app/modules/product_details/product_details.dart';
import 'package:salla_app/shard/component/component.dart';


class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopAppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Favorites Page'),
          ),
          body: ConditionalBuilder(
            condition: state is! ShopLoadingGetFavoritesDataState &&
                cubit.favoritesModel!.data!.data!.isNotEmpty,
            builder: (context) => ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>  buildInkWell(context, index),
              separatorBuilder: (context, index) => const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Divider(
                  height: 2,
                  color: Colors.grey,
                  thickness: 1.5,
                ),
              ),
              itemCount: cubit.favoritesModel!.data!.data!.length,
            ),
            fallback: (context) => SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.deepOrange[400]!,
                        width: 3,
                      ),
                    ),
                    child: const Icon(
                      Icons.favorite_outlined,
                      size: 60.0,
                      color: Colors.deepOrange,
                    ),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  const Text(
                    'No Favourites',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 34.0,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(20.0),
                    // onTap: () => cubit.changeBottomNavCurrentIndex(0),
                    child: Container(
                      width: 250,
                      padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Add Some Favorites',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  InkWell buildInkWell(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        navigateTo(
            context,
            ProductDetailsScreen(
                id: ShopAppCubit.get(context)
                    .favoritesModel!
                    .data!
                    .data![index]
                    .product!
                    .id!));
      },
      child: buildListProduct(
          ShopAppCubit.get(context).favoritesModel!.data!.data![index].product!,
          context),
    );
  }
}

