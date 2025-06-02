import 'package:flutter/material.dart';
import 'package:bahga_student/colors.dart';
import 'package:bahga_student/models/result_model.dart';
import 'package:bahga_student/widgets/custom_app_bar.dart';
import 'package:bahga_student/widgets/result_table.dart';
import 'package:bahga_student/widgets/summary_card.dart';

class ResultDetailsPage extends StatefulWidget {
  final ResultModel result;

  const ResultDetailsPage({required this.result, Key? key}) : super(key: key);

  @override
  State<ResultDetailsPage> createState() => _ResultDetailsPageState();
}

class _ResultDetailsPageState extends State<ResultDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.result.examName,
        showBackButton: true,
        titleWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.result.examName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.result.date,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Downloading result...")),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Subjects",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ResultTable(subjects: widget.result.subjects),
            const SizedBox(height: 40),
            SummaryCard(
              obtained: widget.result.totalObtained,
              total: widget.result.totalMarks,
              grade: widget.result.grade,
              percentage: widget.result.percentage,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}