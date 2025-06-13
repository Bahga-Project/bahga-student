import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bahga_student/widgets/assignment_card.dart';
import 'package:bahga_student/widgets/sort_options.dart';
import 'package:bahga_student/widgets/custom_app_bar.dart';
import 'package:bahga_student/widgets/subject_chip.dart';
import 'package:bahga_student/widgets/empty_state_message.dart';
import 'package:bahga_student/colors.dart';
import 'package:bahga_student/routes/route_names.dart'; // Import route names

class AssignmentsScreen extends StatefulWidget {
  @override
  _AssignmentsScreenState createState() => _AssignmentsScreenState();
}

class _AssignmentsScreenState extends State<AssignmentsScreen> {
  bool isAssignedSelected = true;
  String selectedSubject = "All Subjects";
  String sortBy = "Assigned Date - Latest";
  final DateFormat dateFormat = DateFormat("dd-MM-yyyy");
  final DateFormat fullDateTimeFormat = DateFormat("dd MMMM yyyy, hh:mm a");

  final List<Map<String, dynamic>> assignments = [
    {
      "title": "Homework",
      "subject": "English - Theory",
      "date": "15-06-2025",
      "due": "Due, 17 June 2025, 03:00 PM",
      "iconPath": "assets/icons/english.png",
      "color": AppColors.materialColor,
      "status": "Assigned",
      "solution": "",
    },
    {
      "title": "Assignment 1",
      "subject": "English - Theory",
      "date": "18-06-2025",
      "due": "Due, 20 June 2025, 09:00 AM",
      "iconPath": "assets/icons/english.png",
      "color": AppColors.materialColor,
      "status": "Assigned",
      "solution": "",
    },
    {
      "title": "Basic Maths operations",
      "subject": "Mathematics - Theory",
      "date": "20-06-2025",
      "due": "Due, 25 June 2025, 11:00 AM",
      "iconPath": "assets/icons/math.png",
      "color": AppColors.materialColor,
      "status": "Assigned",
      "solution": "",
    },
  ];

  void sortAssignments(List<Map<String, dynamic>> filteredAssignments) {
    switch (sortBy) {
      case "Assigned Date - Latest":
        filteredAssignments.sort((a, b) {
          DateTime dateA = dateFormat.parse(a["date"]);
          DateTime dateB = dateFormat.parse(b["date"]);
          return dateB.compareTo(dateA);
        });
        break;
      case "Assigned Date - Oldest":
        filteredAssignments.sort((a, b) {
          DateTime dateA = dateFormat.parse(a["date"]);
          DateTime dateB = dateFormat.parse(b["date"]);
          return dateA.compareTo(dateB);
        });
        break;
      case "Due Date - Latest":
        filteredAssignments.sort((a, b) {
          String dueA = a["due"].replaceFirst("Due, ", "");
          String dueB = b["due"].replaceFirst("Due, ", "");
          DateTime dueDateA = fullDateTimeFormat.parse(dueA);
          DateTime dueDateB = fullDateTimeFormat.parse(dueB);
          return dueDateB.compareTo(dueDateA);
        });
        break;
      case "Due Date - Oldest":
        filteredAssignments.sort((a, b) {
          String dueA = a["due"].replaceFirst("Due, ", "");
          String dueB = b["due"].replaceFirst("Due, ", "");
          DateTime dueDateA = fullDateTimeFormat.parse(dueA);
          DateTime dueDateB = fullDateTimeFormat.parse(dueB);
          return dueDateA.compareTo(dueDateB);
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredAssignments = assignments.where((a) {
      bool matchesSubject =
          selectedSubject == "All Subjects" || a["subject"] == selectedSubject;
      bool matchesStatus =
      isAssignedSelected ? a["status"] == "Assigned" : a["status"] == "Submitted";
      return matchesSubject && matchesStatus;
    }).toList();

    sortAssignments(filteredAssignments);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: "Assignments",
        titleWidget: const Text(
          "Assignments",
          style: TextStyle(
            color: AppColors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        showToggleButtons: true,
        isFirstSelected: isAssignedSelected,
        onFirstButtonPressed: () => setState(() => isAssignedSelected = true),
        onSecondButtonPressed: () => setState(() => isAssignedSelected = false),
        firstButtonText: "Assigned",
        secondButtonText: "Submitted",
        onFilterPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return SortOptions(
                selectedOption: sortBy,
                onOptionSelected: (option) {
                  setState(() {
                    sortBy = option;
                  });
                  Navigator.pop(context);
                },
              );
            },
          );
        },
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                SubjectChip(
                  subject: "All Subjects",
                  isSelected: selectedSubject == "All Subjects",
                  onTap: () {
                    setState(() {
                      selectedSubject = "All Subjects";
                    });
                  },
                ),
                SubjectChip(
                  subject: "English - Theory",
                  isSelected: selectedSubject == "English - Theory",
                  onTap: () {
                    setState(() {
                      selectedSubject = "English - Theory";
                    });
                  },
                ),
                SubjectChip(
                  subject: "Mathematics - Theory",
                  isSelected: selectedSubject == "Mathematics - Theory",
                  onTap: () {
                    setState(() {
                      selectedSubject = "Mathematics - Theory";
                    });
                  },
                ),
                SubjectChip(
                  subject: "Science - Theory",
                  isSelected: selectedSubject == "Science - Theory",
                  onTap: () {
                    setState(() {
                      selectedSubject = "Science - Theory";
                    });
                  },
                ),
                SubjectChip(
                  subject: "History - Theory",
                  isSelected: selectedSubject == "History - Theory",
                  onTap: () {
                    setState(() {
                      selectedSubject = "History - Theory";
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: filteredAssignments.isEmpty
                ? EmptyStateMessage(
              imagePath: 'assets/animations/Work time.gif',
              message: isAssignedSelected
                  ? "No assignments assigned yet!"
                  : "No assignments submitted yet!",
            )
                : ListView.builder(
              itemCount: filteredAssignments.length,
              itemBuilder: (context, index) {
                return AssignmentCard(
                  filteredAssignments[index],
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RouteNames.AssignmentDetail,
                      arguments: {
                        'assignment': filteredAssignments[index],
                        'onSubmit': (String solution) {
                          setState(() {
                            filteredAssignments[index]["status"] = "Submitted";
                            filteredAssignments[index]["solution"] = solution;
                          });
                        },
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}