import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_app/layout/cubit/cubit.dart';
import 'package:salla_app/modules/search/cubit/cubit.dart';
import 'package:salla_app/modules/search/cubit/states.dart';
import '../../shard/component/component.dart';
import '../product_details/product_details.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    TextEditingController searchController = TextEditingController();
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              elevation: 0.1,
              actions: const [
                Icon(
                  Icons.content_paste_search_outlined,
                  size: 24.0,
                ),
                SizedBox(
                  width: 20.0,
                ),
              ],
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultTextFormField(
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      action: TextInputAction.search,
                      validation: (value) {
                        if (value.isEmpty) return 'Search For Any Thing';
                      },
                      onSubmit: (String text) {
                        cubit.search(text: text);
                      },
                      labelText: "Search",
                      prefixIcon: Icons.manage_search_outlined,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 20.0,
                    ),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.builder(
                            itemCount: cubit.searchModel!.data!.data!.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      navigateTo(
                                          context,
                                          ProductDetailsScreen(
                                              id: cubit
                                                  .searchModel!
                                                  .data!
                                                  .data![index]
                                                  .id!));
                                    },
                                    child: buildListProduct(
                                      cubit
                                          .searchModel!
                                          .data!
                                          .data![index],
                                      context,
                                      isOldPrice: false,
                                    ),
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 30.0),
                                    child: Divider(
                                      height: 2,
                                      color: Colors.grey,
                                      thickness: 1.5,
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  InkWell buildInkWell(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        navigateTo(
            context,
            ProductDetailsScreen(
                id: ShopAppCubit.get(context)
                    .searchModel!
                    .data!
                    .data![index]
                    .id!));
      },
      child: buildListProduct(
        ShopAppCubit.get(context).searchModel!.data!.data![index],
        context,
        isOldPrice: false,
      ),
    );
  }
}
