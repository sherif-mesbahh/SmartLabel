import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';

class EditProfileDialogWidget extends StatefulWidget {
  const EditProfileDialogWidget({super.key});

  @override
  State<EditProfileDialogWidget> createState() =>
      _EditProfileDialogWidgetState();
}

class _EditProfileDialogWidgetState extends State<EditProfileDialogWidget> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;

  @override
  void initState() {
    super.initState();
    final userData = AppCubit.get(context).userInfoModel?.data;
    firstNameController =
        TextEditingController(text: userData?.firstName ?? '');
    lastNameController = TextEditingController(text: userData?.lastName ?? '');
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text('Edit Profile', style: TextStyles.headline2),
      content: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // First Name
            TextField(
              controller: firstNameController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: 'First Name',
                labelStyle: TextStyles.smallText,
                hintStyle: TextStyles.smallText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: greyColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: primaryColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: greyColor),
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Last Name
            TextField(
              keyboardType: TextInputType.name,
              controller: lastNameController,
              decoration: InputDecoration(
                labelText: 'Last Name',
                labelStyle: TextStyles.smallText,
                hintStyle: TextStyles.smallText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: greyColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: primaryColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: greyColor),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancel', style: TextStyles.productTitle),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {
            if (state is UpdateProfileSuccessState) {
              Navigator.of(context).pop();
              Fluttertoast.showToast(
                msg: 'Profile updated successfully',
                backgroundColor: Colors.green,
                textColor: secondaryColor,
                gravity: ToastGravity.BOTTOM,
                toastLength: Toast.LENGTH_LONG,
                timeInSecForIosWeb: 1,
                fontSize: 16,
              );
              AppCubit.get(context).getUserInfo();
            }
            if (state is UpdateProfileErrorState) {
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
            return state is UpdateProfileLoadingState
                ? Lottie.asset(
                    'assets/lottie/loading_indicator.json',
                    width: 50,
                    height: 50,
                  )
                : TextButton(
                    child: Text('Save', style: TextStyles.productTitle),
                    onPressed: () {
                      AppCubit.get(context).updateProfile(
                        firstName: firstNameController.text.trim(),
                        lastName: lastNameController.text.trim(),
                        email:
                            AppCubit.get(context).userInfoModel!.data?.email ??
                                '',
                      );
                    },
                  );
          },
        ),
      ],
    );
  }
}
