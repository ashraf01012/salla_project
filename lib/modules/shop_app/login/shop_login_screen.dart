import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/layout/shop_app/shop_layout.dart';
import 'package:salla/modules/shop_app/login/login_screen_cubit/login_cubit.dart';
import 'package:salla/modules/shop_app/register/cubit/_shop_register_cubit.dart';
import 'package:salla/modules/shop_app/register/shop_register_screen.dart';
import 'package:salla/shared/components/components.dart';
import 'package:salla/shared/components/constans.dart';
import 'package:salla/shared/network/local/cache_helper.dart';
import 'package:salla/shared/styles/colors.dart';

import '../../../models/shop_app/login_model.dart';

class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({super.key});
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status != null) {
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value) {
                token = state.loginModel.data!.token ?? '';
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ShopLayout(),
                  ),
                );
              });
            } else {
              showToast(
                text: state.loginModel.message ?? '',
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Text(
                          'Sign In',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.black,
                                    fontSize: 30,
                                  ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Welcome back! please enter your details',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        defaultFormField(
                          label: 'Enter your email',
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter your email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.text,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter your password';
                            }
                            return null;
                          },
                          label: 'Enter your password',
                          isPassword: LoginCubit.get(context).isPassword,
                          suffixPressed: () {
                            LoginCubit.get(context).changePasswordVisibility();
                          },
                          suffix: LoginCubit.get(context).suffix,
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              LoginCubit.get(context).userLogIn(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Forgot password',
                                style: TextStyle(
                                  color: defaultColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (BuildContext context) => MaterialButton(
                            onPressed: () {
                              print(state.toString());
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).userLogIn(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            color: defaultColor,
                            minWidth: double.infinity,
                            height: 50,
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                              borderSide: const BorderSide(
                                color: defaultColor,
                              ),
                            ),
                            elevation: 0,
                            child: const Text(
                              'sign in',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          fallback: (BuildContext context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 30,
                              ),
                              width: 135,
                              height: 2,
                              color: Colors.grey,
                            ),
                            const Text(
                              'OR',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 30,
                              ),
                              width: 135,
                              height: 2,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have account? ',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                navigateTo(context, ShopRegisterScreen());
                              },
                              style: const ButtonStyle(
                                overlayColor: WidgetStatePropertyAll(
                                  Colors.white,
                                ),
                              ),
                              child: const Text(
                                'Sign up',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
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
