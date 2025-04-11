import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';

class CategoriesListViewItem extends StatelessWidget {
  final dynamic model;
  const CategoriesListViewItem({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 42,
              backgroundColor: primaryColor,
              child: CircleAvatar(
                onBackgroundImageError: (exception, stackTrace) =>
                    Icon(Icons.error),
                radius: 40,
                backgroundImage: CachedNetworkImageProvider(
                  'http://smartlabel1.runasp.net/Uploads/${model.imageUrl}',
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              model.name ?? 'No Name',
              style: TextStyles.productTitle,
            ),
            Spacer(),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_forward_rounded,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
