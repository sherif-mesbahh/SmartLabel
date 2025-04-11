import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/categories_widgets/fav_widgets/fav_list_view_item.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/login_widgets/custom_text_form_field_widget.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search',
          style: TextStyles.appBarTitle,
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomTextFormFieldWidget(
              controller: searchController,
              hintText: 'Search',
              labelText: 'Search',
              obscureText: false,
              suffixIconOnPressed: () {},
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (cotext, index) {
                  return FavListViewItem(favModel: null,);
                },
                itemCount: 10,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
              ),
            )
          ],
        ),
      ),
    );
  }
}
