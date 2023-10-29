// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gami_acad_web/ui/utils/extensions/date_extension.dart';

class DatePicker {
  static Future<void> handleDateTimePickerActions({
    required BuildContext context,
    required TextEditingController controller,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
  }) async {
    DateTime? selectedDate = await showDatePicker(
      locale: const Locale('pt', 'BR'),
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (selectedDate == null) {
      return;
    }
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 0, minute: 0),
      builder: (BuildContext context, Widget? child) {
        return Localizations.override(
          context: context,
          locale: const Locale('pt', 'BR'),
          child: child,
        );
      },
    );
    if (selectedTime != null) {
      selectedDate = selectedDate.add(
        Duration(
          hours: selectedTime.hour,
          minutes: selectedTime.minute,
        ),
      );
    }
    controller.text = selectedDate.toLocalDateTimeString();
  }
}
