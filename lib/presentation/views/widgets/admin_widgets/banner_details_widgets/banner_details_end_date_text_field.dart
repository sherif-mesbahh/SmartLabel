import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';

class BannerDetailsEndDateTextField extends StatelessWidget {
  const BannerDetailsEndDateTextField({
    super.key,
    required this.endDateController,
  });

  final TextEditingController endDateController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: endDateController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'End Date',
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
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today, color: primaryColor),
          onPressed: () async {
            final pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (pickedDate != null) {
              final formatted = DateFormat('dd MMM yyyy').format(pickedDate);
              endDateController.text = formatted;
            }
          },
        ),
      ),
    );
  }
}
