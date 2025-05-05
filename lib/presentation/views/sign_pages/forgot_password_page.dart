import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/login_widgets/forgot_password_widgets/forgot_password_app_bar_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/login_widgets/forgot_password_widgets/forgot_password_email_section_widget.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> codeFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    codeController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: ForgotPasswordAppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocConsumer<AppCubit, AppStates>(
              listener: (context, state) {
                if (state is ForgotPasswordSendCodeSuccessState) {
                  Fluttertoast.showToast(
                    msg: 'Code sent successfully, check your email',
                    backgroundColor: Colors.green,
                    textColor: secondaryColor,
                    gravity: ToastGravity.BOTTOM,
                    toastLength: Toast.LENGTH_LONG,
                    timeInSecForIosWeb: 1,
                    fontSize: 16,
                  );
                }
                if (state is ForgotPasswordSendCodeErrorState) {
                  Fluttertoast.showToast(
                    msg: state.error,
                    backgroundColor: Colors.red,
                    textColor: secondaryColor,
                    gravity: ToastGravity.BOTTOM,
                    toastLength: Toast.LENGTH_LONG,
                    timeInSecForIosWeb: 1,
                    fontSize: 16,
                  );
                }
                if (state is ForgotPasswordVerifyCodeSuccessState) {
                  Fluttertoast.showToast(
                    msg: 'Code Verified Successfully',
                    backgroundColor: Colors.green,
                    textColor: secondaryColor,
                    gravity: ToastGravity.BOTTOM,
                    toastLength: Toast.LENGTH_LONG,
                    timeInSecForIosWeb: 1,
                    fontSize: 16,
                  );
                }
                if (state is ForgotPasswordVerifyCodeErrorState) {
                  Fluttertoast.showToast(
                    msg: state.error,
                    backgroundColor: Colors.red,
                    textColor: secondaryColor,
                    gravity: ToastGravity.BOTTOM,
                    toastLength: Toast.LENGTH_LONG,
                    timeInSecForIosWeb: 1,
                    fontSize: 16,
                  );
                }
                if (state is ForgotPasswordChangePasswordSuccessState) {
                  Fluttertoast.showToast(
                    msg: 'Password Changed Successfully',
                    backgroundColor: Colors.green,
                    textColor: secondaryColor,
                    gravity: ToastGravity.BOTTOM,
                    toastLength: Toast.LENGTH_LONG,
                    timeInSecForIosWeb: 1,
                    fontSize: 16,
                  );
                  popNavigator(context);
                  AppCubit.get(context).codeSent = false;
                  AppCubit.get(context).codeVerified = false;
                }
                if (state is ForgotPasswordChangePasswordErrorState) {
                  Fluttertoast.showToast(
                    msg: state.error,
                    backgroundColor: Colors.red,
                    textColor: secondaryColor,
                    gravity: ToastGravity.BOTTOM,
                    toastLength: Toast.LENGTH_LONG,
                    timeInSecForIosWeb: 1,
                    fontSize: 16,
                  );
                }
              },
              builder: (context, state) {
                return ForgotPasswordEmailSection(
                    emailFormKey: emailFormKey,
                    emailController: emailController,
                    codeFormKey: codeFormKey,
                    codeController: codeController,
                    passwordFormKey: passwordFormKey,
                    newPasswordController: newPasswordController,
                    confirmPasswordController: confirmPasswordController);
              },
            ),
          ),
        ),
      ),
    );
  }
}
