import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = AppCubit.get(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              context,
              index: 0,
              iconPath: 'assets/images/home_white.png',
              label: S.of(context).navBarHome,
              isSelected: cubit.navBarCurrentIndex == 0,
            ),
            _buildNavItem(
              context,
              index: 1,
              iconPath: 'assets/images/category_white.png',
              label: S.of(context).navBarCategories,
              isSelected: cubit.navBarCurrentIndex == 1,
            ),
            _buildNavItem(
              context,
              index: 2,
              iconPath: 'assets/images/favorite_white.png',
              label: S.of(context).navBarFav,
              isSelected: cubit.navBarCurrentIndex == 2,
            ),
            _buildNavItem(
              context,
              index: 3,
              iconPath: 'assets/images/profile_white.png',
              label: S.of(context).navBarProfile,
              isSelected: cubit.navBarCurrentIndex == 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required int index,
    required String iconPath,
    required String label,
    required bool isSelected,
  }) {
    final cubit = AppCubit.get(context);
    return InkWell(
      onTap: () {
        cubit.changeNavBarCurrentIndex(index: index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ImageIcon(
            AssetImage(iconPath),
            color: isSelected ? secondaryColor : darkColor,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? secondaryColor : darkColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
