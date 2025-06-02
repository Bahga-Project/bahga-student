import 'package:flutter/material.dart';

class AssignmentCard extends StatelessWidget {
  final Map<String, dynamic> assignment;
  final VoidCallback? onTap; // Add onTap callback

  const AssignmentCard(this.assignment, {Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Handle tap to navigate
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: Colors.grey.shade300, blurRadius: 5, spreadRadius: 1),
          ],
        ),
        child: Row(
          children: [
            // ✅ Subject Icon
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: assignment["color"],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.menu_book, color: Colors.white, size: 30),
            ),
            SizedBox(width: 15),

            // ✅ Assignment Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    assignment["title"],
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 2),
                  Text(
                    assignment["subject"],
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(height: 5),
                  Text(
                    assignment["due"],
                    style: TextStyle(fontSize: 12, color: Colors.redAccent),
                  ),
                  // ✅ Display Status (optional, for clarity)
                  Text(
                    "Status: ${assignment["status"]}",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),

            // ✅ Assignment Date
            Text(
              assignment["date"],
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}