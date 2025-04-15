import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/views/admin_pages/admin_edit_category_page.dart';

class AdminCategoriesGridViewItem extends StatelessWidget {
  const AdminCategoriesGridViewItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pushNavigator(context, AdminEditCategoryPage(), slideRightToLeft);
      },
      child: Stack(
        alignment: Alignment.topRight,
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: screenHeight(context) * .2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/images/fruits_image.jpg',
                    ),
                  ),
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Category Name',
                style: TextStyles.productTitle,
              ),
            ],
          ),
          Positioned(
            top: -10,
            right: -10,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
