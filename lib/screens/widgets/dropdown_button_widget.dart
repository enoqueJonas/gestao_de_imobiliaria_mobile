// province_dropdown.dart
import 'package:flutter/material.dart';

class DropdownButtonCombBox extends StatelessWidget {
  final String typeValue;
  final List<String> values;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;

  DropdownButtonCombBox({
    required this.typeValue,
    required this.values,
    this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
            width: 0.4,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
          value: values.contains(selectedValue) ? selectedValue : null,
          isExpanded: true,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          hint: Text(typeValue),
          onChanged: onChanged,
          items: values.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        )));
  }
}
