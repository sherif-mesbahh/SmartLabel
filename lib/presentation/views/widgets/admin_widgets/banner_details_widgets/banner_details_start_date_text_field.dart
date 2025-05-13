import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_label_software_engineering/core/utils/constants.dart';
import 'package:smart_label_software_engineering/core/utils/text_styles.dart';
import 'package:smart_label_software_engineering/generated/l10n.dart';

class BannerDetailsStartDateTextField extends StatelessWidget {
  const BannerDetailsStartDateTextField({
    super.key,
    required this.startDateController,
  });

  final TextEditingController startDateController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: startDateController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: S.of(context).editBannerStartDateText,
        labelStyle: TextStyles.smallText(context),
        hintStyle: TextStyles.smallText(context),
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
              firstDate: DateTime.now(),
              lastDate: DateTime(2100),
            );

            if (pickedDate != null) {
              final pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );

              if (pickedTime != null) {
                final combinedDateTime = DateTime(
                  pickedDate.year,
                  pickedDate.month,
                  pickedDate.day,
                  pickedTime.hourOfPeriod +
                      (pickedTime.period == DayPeriod.pm
                          ? 12
                          : 0), // Handle AM/PM conversion
                  pickedTime.minute,
                );

                final formatted = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                    .format(combinedDateTime);
                startDateController.text = formatted;
              }
            }
          },
        ),
      ),
    );
  }
}
