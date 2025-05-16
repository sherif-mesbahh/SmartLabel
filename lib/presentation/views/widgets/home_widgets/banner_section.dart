import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/shimmer_widget.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/products_widgets/custom_slider.dart';

class BannerSection extends StatelessWidget {
  const BannerSection({
    super.key,
    required this.cubit,
  });

  final AppCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        final banners = cubit.activeBannersModel?.data;
        if (state is GetActiveBannersLoadingState) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ShimmerBox(
                height: screenHeight(context) * 0.25,
                width: screenWidth(context) * 0.8,
              ),
            ),
          );
        }

        if (banners == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/failed_icon.png',
                  width: screenHeight(context) * .8,
                  height: screenHeight(context) * .2,
                ),
                const SizedBox(height: 8),
                Text(S.of(context).failedToLoadBanners),
              ],
            ),
          );
        }

        if (banners.isEmpty) {
          return const SizedBox();
        }

        return CustomSlider(banners: banners);
      },
    );
  }
}
