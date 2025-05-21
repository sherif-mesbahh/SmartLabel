import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/fav_widgets/fav_list_view_item.dart';

class FavPage extends StatelessWidget {
  const FavPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        final cubit = AppCubit.get(context);
        final favData = cubit.favModel?.data;

        if (state is GetFavProductsLoadingState) {
          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.68,
            ),
            itemCount: 6,
            itemBuilder: (context, index) => Shimmer.fromColors(
              baseColor: Colors.grey[800]!,
              highlightColor: Colors.grey[500]!,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          );
        }

        if (!cubit.isLogin) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/not_login.png',
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    AppCubit.get(context).changeNavBarCurrentIndex(index: 3);
                  },
                  child: Text(S.of(context).pleaseLoginFirst),
                )
              ],
            ),
          );
        }

        if (favData == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/failed_icon.png',
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 16),
                Text(
                  S.of(context).failedToLoadFavourites,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        }

        if (favData.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/empty_fav.png',
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 16),
                Text(
                  S.of(context).noFavouritesFound,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    AppCubit.get(context).changeNavBarCurrentIndex(index: 0);
                  },
                  child: Text(S.of(context).browseProducts),
                )
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            await Future.wait([cubit.getFav()]);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: favData.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio:
                    screenWidth(context) / (screenHeight(context) * 0.775),
              ),
              itemBuilder: (context, index) {
                final item = favData[index];
                return FavCardItem(
                  favModel: item,
                  cubit: cubit,
                  index: index,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
