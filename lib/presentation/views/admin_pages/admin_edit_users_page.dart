import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_label_software_engineering/core/components/components.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/login_widgets/custom_text_form_field_widget.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/sign_widgets/custom_button_widget.dart';

class AdminEditUsersPage extends StatefulWidget {
  const AdminEditUsersPage({super.key});

  @override
  State<AdminEditUsersPage> createState() => _AdminEditUsersPageState();
}

class _AdminEditUsersPageState extends State<AdminEditUsersPage> {
  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          onPressed: () => popNavigator(context),
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: secondaryColor,
            size: 30,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Edit Users',
          style: TextStyles.appBarTitle(context),
        ),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                // Admin Icon
                Icon(Icons.admin_panel_settings,
                    size: 100, color: primaryColor),
                const SizedBox(height: 16),
                // Manage Admin Roles
                Text(
                  'Manage Admin Roles',
                  style: TextStyles.headline2(context).copyWith(fontSize: 24),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 8),
                // Enter the user's email to add or remove admin access
                Text(
                  'Enter the user\'s email to add or remove admin access.',
                  style: TextStyles.cartItemTitle(context).copyWith(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                // Card
                Card(
                  elevation: 5,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  semanticContainer: true,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color: primaryColor,
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // User Email
                        CustomTextFormFieldWidget(
                          controller: emailController,
                          hintText: 'example@yahoo.com',
                          labelText: 'User Email',
                          obscureText: false,
                          suffixIconOnPressed: () {},
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter user email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        BlocConsumer<AppCubit, AppStates>(
                          listener: (context, state) {
                            if (state is MakeAdminSuccessState) {
                              Fluttertoast.showToast(
                                msg: '${emailController.text} is admin now',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                              emailController.clear();
                            }

                            if (state is MakeAdminErrorState) {
                              Fluttertoast.showToast(
                                msg: state.error,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            }
                            if (state is DeleteAdminSuccessState) {
                              Fluttertoast.showToast(
                                msg:
                                    '${emailController.text} is no longer admin',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                              emailController.clear();
                            }

                            if (state is DeleteAdminErrorState) {
                              Fluttertoast.showToast(
                                msg: state.error,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            }
                          },
                          builder: (context, state) {
                            return Row(
                              children: [
                                // Make Admin
                                Expanded(
                                  child: CustomButtonWidget(
                                    onTap: () {
                                      if (formKey.currentState!.validate()) {
                                        AppCubit.get(context).makeAdmin(
                                          email: emailController.text,
                                        );
                                      }
                                    },
                                    color: primaryColor,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: state is MakeAdminLoadingState
                                          ? CircularProgressIndicator(
                                              color: secondaryColor)
                                          : FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                'Make Admin',
                                                style: TextStyles.buttonText(
                                                    context),
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                // Remove Admin
                                Expanded(
                                  child: CustomButtonWidget(
                                    onTap: () {
                                      if (formKey.currentState!.validate()) {
                                        if (formKey.currentState!.validate()) {
                                          AppCubit.get(context).deleteAdmin(
                                            email: emailController.text,
                                          );
                                        }
                                      }
                                    },
                                    color: Colors.red,
                                    child: state is DeleteAdminLoadingState
                                        ? CircularProgressIndicator(
                                            color: secondaryColor)
                                        : FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              'Remove Admin',
                                              style: TextStyles.buttonText(
                                                  context),
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
