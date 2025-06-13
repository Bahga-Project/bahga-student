import 'package:flutter/material.dart';
import 'package:bahga_student/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AssignmentDetailScreen extends StatefulWidget {
  final Map<String, dynamic> assignment;
  final Function(String solution) onSubmit;

  const AssignmentDetailScreen({
    Key? key,
    required this.assignment,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<AssignmentDetailScreen> createState() => _AssignmentDetailScreenState();
}

class _AssignmentDetailScreenState extends State<AssignmentDetailScreen> {
  final TextEditingController _solutionController = TextEditingController();
  bool _submitted = false;

  @override
  void dispose() {
    _solutionController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final solutionText = _solutionController.text.trim();
    if (solutionText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please write a solution before submitting.")),
      );
      return;
    }

    widget.onSubmit(solutionText);
    setState(() {
      _submitted = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Assignment submitted successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final assignment = widget.assignment;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        title: Text(
          "Assignment Detail",
          style: GoogleFonts.cairo(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              assignment['title'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            // Subject
            Text(
              assignment['subject'],
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),

            SizedBox(height: 10),

            // Due Date
            Text(
              assignment['due'],
              style: TextStyle(fontSize: 14, color: Colors.red[700]),
            ),

            Divider(height: 30),

            // Input field for solution
            Text(
              "Your Solution:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _solutionController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Write your solution here...",
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),

            SizedBox(height: 10),

            // Submit button
            ElevatedButton(
              onPressed: _submitted ? null : _handleSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.appBarColor,
              ),
              child: Text(_submitted ? "Submitted" : "Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
