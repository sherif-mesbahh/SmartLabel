import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';

class SearchCustomTextWidget extends StatelessWidget {
  const SearchCustomTextWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyles.productTitle(context).copyWith(
        fontSize: 18,
        color: Colors.grey[600],
      ),
    );
  }
}
