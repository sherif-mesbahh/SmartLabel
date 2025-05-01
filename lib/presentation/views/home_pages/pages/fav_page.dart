import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
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
          return Column(
            children: [
              Center(
                child: Lottie.asset(
                  'assets/lottie/loading_indicator.json',
                  width: 100,
                  height: 100,
                ),
              ),
            ],
          );
        }
        if (AppCubit.get(context).isLogin) {
          if (favData == null) {
            return const Center(child: Text('Failed to load favorites'));
          }

          if (favData.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(child: Text('No favorites found')),
              ],
            );
          }
          if (state is AddToFavSuccessState ||
              state is RemoveFromFavSuccessState) {
            cubit.getFav();
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              return FavListViewItem(
                favModel: favData[index],
                cubit: cubit,
                index: index,
              );
            },
            itemCount: favData.length,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  'Please login first',
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
