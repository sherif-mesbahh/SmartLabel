import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_label_software_engineering/core/services/api_services/token_refresher.dart';
import 'package:smart_label_software_engineering/core/utils/bloc_observer.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/home_pages/layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  final appCubit = AppCubit();
  await appCubit.checkLoginStatus();

  if (appCubit.isLogin) {
    TokenRefresher.start();
  }
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => appCubit..getProducts()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AppCubit, AppStates>(
        builder: (context, state) {
          return Layout();
        },
      ),
    );
  }
}
