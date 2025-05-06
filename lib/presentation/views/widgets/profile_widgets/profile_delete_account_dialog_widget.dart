import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_cubit.dart';
import 'package:smart_label_software_engineering/presentation/cubits/app_states.dart';

class DeleteAccountDialogWidget extends StatelessWidget {
  const DeleteAccountDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Text('Delete Account', style: TextStyles.headline2(context)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            'assets/lottie/warning.json',
            width: 100,
            height: 100,
          ),
          const SizedBox(height: 12),
          Text(
            'Are you sure you want to delete your account? This action cannot be undone.',
            style: TextStyles.productTitle(context).copyWith(color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text('Cancel', style: TextStyles.productTitle(context)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {
            if (state is DeleteAccountSuccessState) {
              Navigator.of(context).pop();
              Fluttertoast.showToast(
                msg: 'Account deleted successfully',
                backgroundColor: Colors.green,
                textColor: secondaryColor,
                gravity: ToastGravity.BOTTOM,
                toastLength: Toast.LENGTH_LONG,
                fontSize: 16,
              );
              AppCubit.get(context).getUserInfo();
            }
            if (state is DeleteAccountErrorState) {
              Fluttertoast.showToast(
                msg: state.error,
                backgroundColor: Colors.red,
                textColor: secondaryColor,
                gravity: ToastGravity.BOTTOM,
                toastLength: Toast.LENGTH_LONG,
                fontSize: 16,
              );
            }
          },
          builder: (context, state) {
            return state is DeleteAccountLoadingState
                ? Lottie.asset(
                    'assets/lottie/loading_indicator.json',
                    width: 50,
                    height: 50,
                  )
                : TextButton(
                    child: Text('Delete',
                        style: TextStyles.productTitle(context)
                            .copyWith(color: Colors.red)),
                    onPressed: () {
                      AppCubit.get(context).deleteAccount();
                    },
                  );
          },
        ),
      ],
    );
  }
}
