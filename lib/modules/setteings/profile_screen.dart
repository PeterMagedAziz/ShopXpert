import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/cubit/cubit.dart';
import '../../../layout/cubit/states.dart';
import '../../../shard/component/component.dart';
import '../../../shard/component/constants.dart';

class ProfileScreen extends StatelessWidget {


  const ProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopAppCubit.get(context).userModel;
        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;

        return Scaffold(
          appBar: AppBar(
            leading: appBarLeading(context),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ConditionalBuilder(
              condition: ShopAppCubit.get(context).userModel != null &&
                  state is! ShopLoadingGetUserDataState,
              fallback: (context) => const CircularProgressIndicator(),
              builder: (context) => SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 35.0),
                  child: Center(
                    child: Column(
                      children: [
                        if (state is ShopLoadingUpdateDataState)
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: LinearProgressIndicator(),
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultTextFormField(
                          keyboardType : TextInputType.text,
                          controller: nameController,
                          hintText: "Enter your name",
                          prefixIcon: Icons.person,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultTextFormField(
                          keyboardType: TextInputType.text,
                          controller: emailController,
                          hintText: "Enter email address",
                          prefixIcon: Icons.email,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultTextFormField(
                          keyboardType: TextInputType.number,
                          controller: phoneController,
                          hintText: "Enter your phone",
                          prefixIcon: Icons.phone,
                        ),
                        const SizedBox(height: 25),
                        defaultButton(
                            text: "UPDATE",
                            width: 350,
                            function: () {
                              ShopAppCubit.get(context).updateUserData(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text);
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
