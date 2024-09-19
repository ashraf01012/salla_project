import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/layout/shop_app/cubit/shop_cubit.dart';
import 'package:salla/shared/components/components.dart';
import 'package:salla/shared/components/constans.dart';

class SettingsScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        var shopCubit = ShopCubit.get(context);
        var userModel = shopCubit.userModel;

        // Check if userModel and its data are not null
        if (userModel == null || userModel.data == null) {
          return const Center(child: CircularProgressIndicator());
        }

        // Set text in controllers only when the userModel and its data are non-null
        nameController.text = userModel.data?.name ?? '';
        emailController.text = userModel.data?.email ?? '';
        phoneController.text = userModel.data?.phone ?? '';

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if (state is ShopLoadingUpdateUserState)
                    const LinearProgressIndicator(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name must not be empty';
                      }
                      return null;
                    },
                    label: 'Name',
                    prefix: Icons.person,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email must not be empty';
                      }
                      return null;
                    },
                    label: 'Email Address',
                    prefix: Icons.email,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone must not be empty';
                      }
                      return null;
                    },
                    label: 'Phone',
                    prefix: Icons.phone,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        shopCubit.updateUserData(
                          name: nameController.text,
                          phone: phoneController.text,
                          email: emailController.text,
                        );
                      }
                    },
                    text: 'Update',
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    onPressed: () {
                      signOut(context);
                    },
                    text: 'Logout',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
