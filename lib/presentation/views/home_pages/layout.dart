import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/custom_app_bar.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/custom_nav_bar.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/layout_drawer_widget.dart';

class Layout extends StatelessWidget {
  Layout({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    AppCubit.get(context).scaffoldKey = _scaffoldKey;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      key: _scaffoldKey,
      endDrawer: LayoutDrawerWidget(),
      appBar: CustomAppBar(),
      body: BlocBuilder<AppCubit, AppStates>(
        builder: (context, state) {
          final cubit = AppCubit.get(context);

          return Column(
            children: [
              Expanded(
                child: cubit.screens[cubit.navBarCurrentIndex],
              ),
              CustomNavBar(),
            ],
          );
        },
      ),
    );
  }
}
