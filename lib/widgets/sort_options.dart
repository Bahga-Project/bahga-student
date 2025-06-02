import 'package:flutter/material.dart';

class SortOptions extends StatelessWidget {
  final String selectedOption;
  final Function(String) onOptionSelected;

  const SortOptions({
    required this.selectedOption,
    required this.onOptionSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> sortOptions = [
      "Assigned Date - Latest",
      "Assigned Date - Oldest",
      "Due Date - Latest",
      "Due Date - Oldest",
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sort By',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 10),
          Column(
            children: sortOptions.map((option) {
              return RadioListTile<String>(
                title: Text(option),
                value: option,
                groupValue: selectedOption,
                onChanged: (value) {
                  if (value != null) {
                    onOptionSelected(value);
                  }
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
