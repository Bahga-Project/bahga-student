import 'package:flutter/material.dart';
import 'package:bahga_student/colors.dart';

class ResultTable extends StatelessWidget {
  final List<Map<String, dynamic>> subjects;

  const ResultTable({required this.subjects, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: Colors.grey.shade300),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
      },
      children: [
        _buildHeaderRow(),
        ...subjects.map(_buildDataRow).toList(),
      ],
    );
  }

  TableRow _buildHeaderRow() {
    return TableRow(
      decoration: BoxDecoration(color: AppColors.primaryColor),
      children: const [
        Padding(
          padding: EdgeInsets.all(12),
          child: Text("Subject", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Text("Obtained", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: EdgeInsets.all(12),
          child: Text("Total", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  TableRow _buildDataRow(Map<String, dynamic> subject) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(subject['name']),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(subject['obtained'].toString()),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(subject['total'].toString()),
        ),
      ],
    );
  }
}
