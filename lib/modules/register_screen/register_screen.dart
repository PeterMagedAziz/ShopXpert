import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_app/layout/shop_layout.dart';
import 'package:salla_app/modules/register_screen/cubit/cubit.dart';
import 'package:salla_app/modules/register_screen/cubit/states.dart';
import 'package:salla_app/shard/component/component.dart';
import 'package:salla_app/shard/component/constants.dart';
import 'package:salla_app/shard/network/local/cache_helper.dart';


class ShopRegisterScreen extends StatelessWidget {

  const ShopRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status!) {
              // Print For Test
              print(state.loginModel.message);
              print(state.loginModel.data!.token);
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value) {
                token = state.loginModel.data!.token;
                navigateReplacementTo(context, const ShopLayoutScreen());
              });
              showToast(
                text: state.loginModel.message!,
                state: ToastStates.SUCCESS,
              );
            } else {
              // Print For Test
              print(state.loginModel.message);
              showToast(
                text: state.loginModel.message!,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          var cubit = ShopRegisterCubit.get(context);
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Register".toUpperCase(),
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text(
                          "Register to browse our hot offers",
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultTextFormField(
                          controller: nameController,
                          prefixIcon: Icons.person_outline,
                          labelText: "User Name",
                          keyboardType: TextInputType.name,
                          validation: (value) {
                            if (value.isEmpty) return "Please Enter Your Name";
                          },
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultTextFormField(
                          controller: emailController,
                          prefixIcon: Icons.email,
                          labelText: "Email Address",
                          keyboardType: TextInputType.emailAddress,
                          validation: (value) {
                            if (value.isEmpty) {
                              return "Please Enter Your Email Address";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultTextFormField(
                          obscureText: cubit.isPassword,
                          controller: passwordController,
                          prefixIcon: Icons.password,
                          suffixIcon: cubit.suffix,
                          suffixPressed: () => cubit
                              .changePasswordVisibility(),
                          labelText: "Password",
                          keyboardType: TextInputType.visiblePassword,
                          validation: (value) {
                            if (value.isEmpty) {
                              return "Please Enter Your Password";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultTextFormField(
                          controller: phoneController,
                          prefixIcon: Icons.phone,
                          labelText: "Phone",
                          keyboardType: TextInputType.visiblePassword,
                          validation: (value) {
                            if (value.isEmpty) return "Please Enter Your Phone";
                          },
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => defaultElevatedButton(
                            text: "register",
                            borderRadius: 15.0,
                            function: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userRegister(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                          ),
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
