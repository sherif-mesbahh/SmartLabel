import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_label_software_engineering/core/services/api_services/token_refresher.dart';
import 'package:smart_label_software_engineering/core/utils/bloc_observer.dart';
import 'package:smart_label_software_engineering/core/utils/internet_monitor.dart';
import 'package:smart_label_software_engineering/core/utils/shared_preferences.dart';
import 'package:smart_label_software_engineering/features/splashScreen/presentation/views/splash_screen_page.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await SharedPrefs.init();

  final isOnBoardingFinished = SharedPrefs.isOnBoardingFinished();
  final appCubit = AppCubit();
  await appCubit.checkLoginStatus();

  if (appCubit.isLogin) {
    TokenRefresher.start();
  }
  runApp(
    DevicePreview(
      enabled: !kReleaseMode, // Only enable in debug or profile mode
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => appCubit..getProducts()),
        ],
        child: MyApp(showOnBoarding: !isOnBoardingFinished),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool showOnBoarding;

  const MyApp({super.key, required this.showOnBoarding});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        // Start monitoring from global context
        InternetMonitor().startMonitoring(context);
        return DevicePreview.appBuilder(context, child);
      },
      home: BlocBuilder<AppCubit, AppStates>(
        builder: (context, state) {
          return SplashScreenPage(showOnBoarding: showOnBoarding);
        },
      ),
    );
  }
}
