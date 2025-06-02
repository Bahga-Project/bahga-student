import 'package:flutter/material.dart';
import 'package:bahga_student/colors.dart';

class AssignmentDetailScreen extends StatefulWidget {
  final Map<String, dynamic> assignment;
  final Function(String) onSubmit;

  AssignmentDetailScreen({required this.assignment, required this.onSubmit});

  @override
  _AssignmentDetailScreenState createState() => _AssignmentDetailScreenState();
}

class _AssignmentDetailScreenState extends State<AssignmentDetailScreen> {
  final TextEditingController _solutionController = TextEditingController();

  @override
  void dispose() {
    _solutionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.assignment["title"]),
        backgroundColor: AppColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Subject: ${widget.assignment["subject"]}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Due: ${widget.assignment["due"]}",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 16),
            Text(
              "Assignment Details",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Enter your solution below:",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _solutionController,
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Type your solution here...",
              ),
            ),
            SizedBox(height: 16),
            if (widget.assignment["status"] == "Assigned")
              ElevatedButton(
                onPressed: () {
                  if (_solutionController.text.isNotEmpty) {
                    widget.onSubmit(_solutionController.text);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Assignment submitted successfully!")),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please enter a solution before submitting.")),
                    );
                  }
                },
                child: Text("Submit"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.materialColor,
                  foregroundColor: Colors.white,
                ),
              ),
            if (widget.assignment["status"] == "Submitted") ...[
              SizedBox(height: 16),
              Text(
                "Your Solution:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                widget.assignment["solution"] ?? "No solution provided",
                style: TextStyle(fontSize: 14),
              ),
            ],
          ],
        ),
      ),
    );
  }
}