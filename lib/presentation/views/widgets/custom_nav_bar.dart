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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(4, (index) {
            return _buildNavItem(
              context,
              index: index,
              iconPath: _navIconPath(index),
              label: _navLabel(context, index),
              isSelected: cubit.navBarCurrentIndex == index,
            );
          }),
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

    return GestureDetector(
      onTap: () => cubit.changeNavBarCurrentIndex(index: index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color:
              isSelected ? secondaryColor.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            ImageIcon(
              AssetImage(iconPath),
              color: isSelected ? secondaryColor : darkColor,
              size: 24,
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: isSelected
                  ? Row(
                      children: [
                        const SizedBox(width: 6),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (child, animation) =>
                              FadeTransition(
                            opacity: animation,
                            child: SizeTransition(
                              sizeFactor: animation,
                              axis: Axis.horizontal,
                              child: child,
                            ),
                          ),
                          child: Text(
                            label,
                            key: ValueKey(label),
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  String _navIconPath(int index) {
    switch (index) {
      case 0:
        return 'assets/images/home_white.png';
      case 1:
        return 'assets/images/favorite_white.png';
      case 2:
        return 'assets/images/shopping-cart.png';
      case 3:
      default:
        return 'assets/images/profile_white.png';
    }
  }

  String _navLabel(BuildContext context, int index) {
    switch (index) {
      case 0:
        return S.of(context).navBarHome;
      case 1:
        return S.of(context).navBarFav;
      case 2:
        return S.of(context).navBarCart;
      case 3:
      default:
        return S.of(context).navBarProfile;
    }
  }
}
