import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';

class ProductDetailsPriceRow extends StatelessWidget {
  const ProductDetailsPriceRow({
    super.key,
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
          '\$10.99',
          style: TextStyles.productPrice.copyWith(fontSize: 18),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          '\$11.00',
          style: TextStyles.productOldPrice.copyWith(fontSize: 18),
        ),
        Spacer(),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.favorite_border_outlined),
        ),
      ],
    );
  }
}

