// multi_select_dialog_field.dart
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class MultiSelectDialogFieldWidget extends StatelessWidget {
  final List<String> items;
  final String title;
  final void Function(List<String>) onConfirm;

  const MultiSelectDialogFieldWidget({
    super.key,
    required this.items,
    required this.title,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return MultiSelectDialogField(
      items: items.map((item) => MultiSelectItem<String>(item, item)).toList(),
      title: Text(title),
      onConfirm: (values) {
        onConfirm(values.cast<String>());
      },
    );
  }
}
