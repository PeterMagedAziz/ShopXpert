import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_app/layout/shop_layout.dart';
import 'package:salla_app/shard/component/component.dart';
import '../../shard/component/constants.dart';
import '../../shard/network/local/cache_helper.dart';
import '../register_screen/register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopLoginScreen extends StatelessWidget {
  const ShopLoginScreen({super.key});


  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status!) {
              // Print For Test
              print(state.loginModel.message);
              print(state.loginModel.data!.token);
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value) {
                token = state.loginModel.data!.token;
                navigateReplacementTo(
                  context,
                  const ShopLayoutScreen(),
                );
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
          var cubit = ShopLoginCubit.get(context);
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
                          "Login".toUpperCase(),
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text(
                          "Login now to browse our hot offers",
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                          ),
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
                            if (value!.isEmpty) {
                              return "Please Enter Your Email Address";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultTextFormField(
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              cubit.userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          obscureText: cubit.isPassword,
                          controller: passwordController,
                          prefixIcon: Icons.password,
                          suffixIcon: cubit.suffix,
                          suffixPressed: () => cubit
                              .changePasswordVisibility(),
                          labelText: "Password",
                          keyboardType: TextInputType.visiblePassword,
                          validation: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter Your Password";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => defaultElevatedButton(
                            text: "Login",
                            borderRadius: 15.0,
                            function: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userLogin(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don\'t have an account?"),
                            defaultTextButton(
                              text: "Register",
                              function: () => navigateReplacementTo(
                                context,
                                const ShopRegisterScreen(),
                              ),
                            ),
                          ],
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
