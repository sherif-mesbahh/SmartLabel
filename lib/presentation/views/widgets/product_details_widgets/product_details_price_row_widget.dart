import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';

class ProductDetailsPriceRow extends StatelessWidget {
  final String newPrice;
  final String oldPrice;
  final bool favorite;
  const ProductDetailsPriceRow({
    super.key,
    required this.newPrice,
    required this.oldPrice,
    required this.favorite,
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
        favorite
            ? IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                onPressed: () {},
              )
            : IconButton(
                icon: Icon(
                  Icons.favorite_border_outlined,
                  color: Colors.red,
                ),
                onPressed: () {},
              ),
      ],
    );
  }
}
