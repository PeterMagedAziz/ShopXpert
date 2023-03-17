import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salla_app/modules/In_cart_screen/In_cart_screen.dart';
import 'package:salla_app/shard/component/constants.dart';
import '../../../layout/cubit/cubit.dart';
import '../../../layout/cubit/states.dart';
import '../../../models/categories_model.dart';
import '../../../models/home_model.dart';
import '../../../shard/component/component.dart';
import '../../../shard/size_config.dart';
import '../categories/categories_screen.dart';
import '../categories/category_products_Screen.dart';
import '../notifications_screen/notifications_screen.dart';
import '../product_details/product_details.dart';
import '../search/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavoritesDataState) {
          if (state.changeFavoritesModel!.status!) {
            showToast(
                text: state.changeFavoritesModel!.message!,
                state: ToastStates.SUCCESS);
          }
        }
      },
      builder: (context, state) {
        SizeConfig().init(context);
        ShopAppCubit cubit = ShopAppCubit.get(context);

        List<String>? categoriesImage = [
          "assets/images/e1.jpg",
          "assets/images/pc1.jpg",
          "assets/images/s2.jpg",
          "assets/images/l1.jpg",
          "assets/images/c1.jpg",
        ];
        return SafeArea(
            top: false,
            child: ConditionalBuilder(
                builder: (BuildContext context) => homeBuilder(
                    context,
                    cubit,
                    categoriesImage,
                    cubit.homeModel!.data!.products,
                    cubit.homeModel
                ),
                fallback: (BuildContext context) =>
                    const Center(child: CircularProgressIndicator()),
                condition: cubit.homeModel != null &&
                    cubit.categoriesModel != null &&
                    cubit.inCartGetModel != null &&
                    cubit.notifications != null));
      },
    );
  }

  Padding homeBuilder(
      BuildContext context,
      ShopAppCubit cubit,
      List<String> categoriesImage,
      List<ProductsModel> homeList, HomeModel? homeModel) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: getProportionateScreenWidth(20),
            ),
            homeHeader(context),
            SizedBox(
              height: getProportionateScreenWidth(30),
            ),
            banner(cubit.homeModel),
            SizedBox(
              height: getProportionateScreenWidth(30),
            ),
            specialOffers(context, cubit, categoriesImage), //
            SizedBox(
              height: getProportionateScreenWidth(25),
            ),
            sectionTitle(context, "Popular product"), // section title
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: Container(
                color: Colors.grey[100]!.withOpacity(0.5),
                height: 238,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      productCard(homeList[index], context),
                  scrollDirection: Axis.horizontal,
                  itemCount: homeList.length,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget productCard(ProductsModel homeList, BuildContext context) {
    return InkWell(
      onTap: () {
        navigateTo(
            context,
            ProductDetailsScreen(
              id: homeList.id,
            ));
      },
      child: Padding(
        padding: EdgeInsets.only(left: getProportionateScreenWidth(8)),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          width: getProportionateScreenWidth(140),
          height: 50,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AspectRatio(
                aspectRatio: 1.02,
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.0)),
                      child: Stack(
                        children: [
                          Image(
                            image: NetworkImage('${homeList.image}'),
                            height: 120,
                            width: double.infinity,
                          ),
                          if (homeList.discount != 0)
                            Container(
                              decoration:
                              const BoxDecoration(color: Colors.red),
                              child: const Text(
                                'DISCOUNT',
                                style: TextStyle(
                                    fontSize: 8.0, color: Colors.white),
                              ),
                            )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  homeList.name.toString(),
                  maxLines: 2,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${homeList.price}',
                      style: const TextStyle(
                          color: Color(0xFFFF7643),
                          fontWeight: FontWeight.w600),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        ShopAppCubit.get(context).changeFavorites(homeList.id);
                      },
                      child: Container(
                        padding: EdgeInsets.all(getProportionateScreenWidth(6)),
                        height: getProportionateScreenWidth(28),
                        width: getProportionateScreenWidth(28),
                        decoration: BoxDecoration(
                            color: kSecondaryColor.withOpacity(0.1),
                            shape: BoxShape.circle),
                        child: SvgPicture.asset(
                          "assets/icons/Heart Icon_2.svg",
                          color:
                              ShopAppCubit.get(context).favorites[homeList.id]!
                                  ? const Color(0xFFFF7643)
                                  : kSecondaryColor.withOpacity(0.5),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Column specialOffers(
    BuildContext context, ShopAppCubit cubit, List<String> categoriesImage) {
  return Column(
    children: [
      sectionTitle(context, "Special for you"), //
      SizedBox(
        height: getProportionateScreenWidth(25),
      ),
      SizedBox(
        height: 150,
        child: SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: cubit.categoriesModel!.data!.data.length,
            itemBuilder: (context, index) => SpecialOfferCard(
              model: cubit.categoriesModel!.data!.data[index],
              image: categoriesImage[index],
            ),
          ),
        ),
      ),
    ],
  );
}

Padding sectionTitle(BuildContext context, String title) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: getProportionateScreenWidth(18), color: Colors.black),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CategoriesScreen()));
          },
          child: const Text("see more "),
        ),
      ],
    ),
  );
}

Padding banner(HomeModel? homeModel,) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
    child: CarouselSlider(
      items: homeModel!.data!.banners.map(
              (e) =>  Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0)),
            child: Image(
              image: NetworkImage('${e.image}'),
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ))
          .toList(),
      options: CarouselOptions(
        height: 250.0,
        initialPage: 0,
        viewportFraction: 1.0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(seconds: 1),
        autoPlayCurve: Curves.fastOutSlowIn,
        scrollDirection: Axis.horizontal,
      ),
    ),
  );
}

Padding homeHeader(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: SizeConfig.screenWidth * 0.6,
          decoration: BoxDecoration(
              color: kSecondaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15)),
          child: TextField(
            onTap: () {
              navigateTo(context, const SearchScreen());
            },
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20),
                    vertical: getProportionateScreenWidth(9)),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                hintText: "Search product",
                prefixIcon: const Icon(Icons.search)),
          ),
        ),
        buildIconButton(
          press: () {
            navigateTo(
                context,
                const InCartScreen(
                  fromNotification: true,
                ));
          },
          numOfItem:
              ShopAppCubit.get(context).inCartGetModel!.data!.cartItems.length,
          context: context,
          svg: "assets/icons/Cart Icon.svg",
        ),
        buildIconButton(
          press: () {
            ShopAppCubit.get(context).getNotifications();
            navigateTo(context, const NotificationsScreen());
          },
          numOfItem: ShopAppCubit.get(context).notifications!.data!.total,
          context: context,
          svg: "assets/icons/Bell.svg",
        ),
      ],
    ),
  );
}

InkWell buildIconButton(
    {required BuildContext context,
    required String svg,
    int? numOfItem,
    required Function press}) {
  return InkWell(
    borderRadius: BorderRadius.circular(50),
    onTap: () {
      press();
    },
    child: Stack(
      children: [
        Container(
          padding: EdgeInsets.all(getProportionateScreenWidth(12)),
          decoration: BoxDecoration(
              color: kSecondaryColor.withOpacity(0.1), shape: BoxShape.circle),
          child: SvgPicture.asset(svg),
        ),
        if (numOfItem != 0)
          Positioned(
              top: -1,
              right: 0,
              child: Container(
                height: getProportionateScreenWidth(16),
                width: getProportionateScreenWidth(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF4848),
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.5, color: Colors.white),
                ),
                child: Center(
                  child: Text(
                    "${numOfItem!}",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(10),
                      height: 1,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ))
      ],
    ),
  );
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.model,
    required this.image,
  }) : super(key: key);
  final DataModel model;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: GestureDetector(
        onTap: () {
          ShopAppCubit.get(context).getCategoriesDetailData(model.id);
          navigateTo(context, CategoryProductsDetailsScreen(model.name));
        },
        child: SizedBox(
          height: getProportionateScreenWidth(150),
          width: getProportionateScreenWidth(250),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Stack(
              children: [
                Image.asset(
                  image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFF343434).withOpacity(0.4),
                        const Color(0xFF343434).withOpacity(0.15),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(15),
                        vertical: getProportionateScreenWidth(10)),
                    child: Text.rich(
                      TextSpan(
                        style: const TextStyle(color: Colors.white),
                        children: [
                          TextSpan(
                            text: "${model.name!.toUpperCase()}\n",
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(18),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
  SizedBox categoryCard(
      {required String icon, required String text, GestureTapCallback? press}) {
    return SizedBox(
      width: getProportionateScreenWidth(55),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              padding: EdgeInsets.all(
                getProportionateScreenWidth(15),
              ),
              decoration: BoxDecoration(
                  color: const Color(0XFFFFECDF),
                  borderRadius: BorderRadius.circular(10)),
              child: SvgPicture.asset(icon),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            text.toUpperCase(),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

