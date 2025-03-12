import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/categories_widgets/fav_widgets/fav_list_view_item.dart';

class FavPage extends StatelessWidget {
  const FavPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return FavListViewItem();
      },
      itemCount: 10,
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
    );
  }
}
