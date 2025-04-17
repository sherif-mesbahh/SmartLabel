import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
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
          'Price: ',
          style: TextStyles.productPrice.copyWith(
            fontSize: 18,
            color: darkColor,
          ),
        ),
        Text(
          '\$ $newPrice',
          style: TextStyles.productPrice.copyWith(fontSize: 18),
        ),
        SizedBox(
          width: 10,
        ),
        if (newPrice != oldPrice)
          Text(
            '\$ $oldPrice',
            style: TextStyles.productOldPrice.copyWith(fontSize: 18),
          ),
        Spacer(),
        BlocBuilder<AppCubit, AppStates>(
          builder: (context, state) {
            final isFav = model.favorite ?? false;
            return isFav
                ? InkWell(
                    onTap: () {
                      AppCubit.get(context).removeFromFav(model: model);
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
                : InkWell(
                    onTap: () {
                      AppCubit.get(context).addToFav(model: model);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      child: Lottie.asset(
                        'assets/lottie/notFavAnimation.json',
                        width: 40,
                        height: 40,
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
