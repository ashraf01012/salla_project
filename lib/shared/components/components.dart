import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salla/layout/shop_app/cubit/shop_cubit.dart';
import 'package:salla/models/shop_app/favorites_model.dart';
import 'package:salla/shared/styles/colors.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String)? onSubmit,
  Function(String)? onChange,
  Function()? onTap,
  bool isPassword = false,
  required String? Function(String?) validate,
  required String label,
  IconData? prefix,
  IconData? suffix,
  Function()? suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            20,
          ),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            20,
          ),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            20,
          ),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            20,
          ),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.grey,
          ),
        ),
        labelText: label,
        labelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.grey,
        ),
        prefixIcon: prefix != null
            ? Icon(
                prefix,
              )
            : null,
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: const OutlineInputBorder(),
      ),
    );

Widget defaultButton({
  VoidCallback? onPressed,
  required text,
}) =>
    MaterialButton(
      onPressed: onPressed,
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
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) {
        return false;
      },
    );

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}

Widget buildListProduct(
  model, // Explicit type instead of dynamic
  context, {
  bool isOldPrice = true,
}) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 120.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image ?? ''),
                  width: 120.0,
                  height: 120.0,
                  fit: BoxFit.cover, // Ensures the image fits properly
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 8.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        model.price?.toString() ?? 'N/A',
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: defaultColor,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          model.oldPrice?.toString() ?? '',
                          style: const TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id ?? 0);
                        },
                        icon: (ShopCubit.get(context).favorites[model.id] ??
                                false)
                            ? const Icon(
                                Icons.favorite_border,
                              )
                            : const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
