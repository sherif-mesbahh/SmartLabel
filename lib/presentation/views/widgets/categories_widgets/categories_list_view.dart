import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight(context) * .1,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                radius: 27,
                backgroundColor: primaryColor,
                child: CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(
                    'assets/images/fruits_image.jpg',
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: 10,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
