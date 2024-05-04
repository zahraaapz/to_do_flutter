import 'package:flutter/material.dart';

showDateTimePicker(BuildContext context) async {
  final initialDate = DateTime.now();
  final lastDate = DateTime.now().add(const Duration(days: 1000));
  final firstDate = initialDate.subtract(const Duration(days: 5));

  DateTime? selectDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate);

  if (selectDate == null) return null;
  if (!context.mounted) return selectDate;

  TimeOfDay? selectTime = await showTimePicker(
      context: context, initialTime: TimeOfDay.fromDateTime(selectDate));

  return selectTime == null
      ? selectDate
      : DateTime(selectDate.year, selectDate.month, selectDate.day,
          selectTime.hour, selectTime.minute);
}
