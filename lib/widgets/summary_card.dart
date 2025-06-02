import 'package:flutter/material.dart';
import 'package:bahga_student/colors.dart';

class SummaryCard extends StatelessWidget {
  final double obtained;
  final double total;
  final String grade;
  final String percentage;

  const SummaryCard({
    required this.obtained,
    required this.total,
    required this.grade,
    required this.percentage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primaryColor.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildItem("Total", total.toStringAsFixed(0)),
          _buildItem("Obtained", obtained.toStringAsFixed(0)),
          _buildItem("Grade", grade),
          _buildItem("Percentage", "$percentage%"),
        ],
      ),
    );
  }

  Widget _buildItem(String title, String value) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: AppColors.primaryColor,
            )),
        const SizedBox(height: 4),
        Text(title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            )),
      ],
    );
  }
}
