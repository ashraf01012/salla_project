import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/layout/shop_app/cubit/shop_cubit.dart';
import 'package:salla/models/shop_app/categories_model.dart';
import 'package:salla/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        // categoriesModel.data.data[index])
        return ListView.separated(
          itemBuilder: (context, index) => buildCatItem(
            ShopCubit.get(context).categoriesModel!.data!.data![index],
          ),
          itemCount: ShopCubit.get(context).categoriesModel!.data!.data!.length,
          separatorBuilder: (context, index) => myDivider(),
        );
      },
    );
  }

  Widget buildCatItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage('${model.image}'),
              width: 80.0,
              height: 80.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 20.0,
            ),
            Text(
              '${model.name}',
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
            ),
          ],
        ),
      );
}
