import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';

class ProductDetailsPriceRow extends StatelessWidget {
  final String newPrice;
  final String oldPrice;
  final dynamic model;
  const ProductDetailsPriceRow({
    super.key,
    required this.newPrice,
    required this.oldPrice,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          S.of(context).productDetailsPrice,
          style: TextStyles.productTitle(context).copyWith(
            fontSize: 18,
          ),
        ),
        Text(
          '\$ $newPrice',
          style: TextStyles.productPrice(context).copyWith(fontSize: 18),
        ),
        SizedBox(
          width: 10,
        ),
        if (newPrice != oldPrice)
          Text(
            '\$ $oldPrice',
            style: TextStyles.productOldPrice(context).copyWith(fontSize: 18),
          ),
        Spacer(),
        BlocBuilder<AppCubit, AppStates>(
          builder: (context, state) {
            final isFav = model.favorite ?? false;
            return isFav
                ? GestureDetector(
                    onTap: () {
                      if (AppCubit.get(context).isLogin) {
                        AppCubit.get(context).removeFromFav(model: model);
                      } else {
                        Fluttertoast.showToast(
                          msg: S.of(context).youMustBeLoggedIn,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                    },
                    child: Lottie.asset(
                      'assets/lottie/inFavAnimation.json',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      repeat: false,
                      reverse: false,
                      animate: true,
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      if (AppCubit.get(context).isLogin) {
                        AppCubit.get(context).addToFav(model: model);
                      } else {
                        Fluttertoast.showToast(
                          msg: S.of(context).youMustBeLoggedIn,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      child: Lottie.asset(
                        'assets/lottie/notFavAnimation.json',
                        width: 60,
                        height: 60,
                        repeat: false,
                        reverse: false,
                        animate: true,
                      ),
                    ),
                  );
          },
        ),
      ],
    );
  }
}
