import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/presentation/views/widgets/profile_widgets/profile_edit_details_dialog_widget.dart';


class EditInfoButtonWidget extends StatelessWidget {
  const EditInfoButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => EditProfileDialogWidget(),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Image.asset(
              'assets/images/edit_icon.png',
              width: 30,
              height: 30,
            ),
          ),
        ),
      ],
    );
  }
}
