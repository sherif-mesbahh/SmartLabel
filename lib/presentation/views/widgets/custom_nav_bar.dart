import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          margin: EdgeInsets.only(
            bottom: 10,
            left: 10,
            right: 10,
          ), // Adds a floating effect
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            currentIndex: AppCubit.get(context).navBarCurrentIndex,
            onTap: (value) {
              AppCubit.get(context).changeNavBarCurrentIndex(index: value);
            },
            type: BottomNavigationBarType.fixed,
            selectedItemColor: secondaryColor,
            unselectedItemColor: darkColor,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.production_quantity_limits),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: 'Favoriets',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
