import 'package:flutter/material.dart';
import 'package:bahga_student/colors.dart';
import 'package:bahga_student/screens/change_password_bottom_sheet.dart';

String getCurrentDay() {
  final now = DateTime.now();
  switch (now.weekday) {
    case 1:
      return "Mon";
    case 2:
      return "Tue";
    case 3:
      return "Wed";
    case 4:
      return "Thu";
    case 5:
      return "Fri";
    case 6:
      return "Sat";
    case 7:
      return "Sun";
    default:
      return "Mon";
  }
}

Future<String?> showLanguageBottomSheet(BuildContext context, String currentLanguage) async {
  String selectedLanguage = currentLanguage;
  return await showModalBottomSheet<String?>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      padding: EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 30.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Application language",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Column(
            children: [
              RadioListTile<String>(
                title: Text("English"),
                value: "English",
                groupValue: selectedLanguage,
                activeColor: AppColors.primaryColor,
                onChanged: (value) {
                  if (value != null) {
                    selectedLanguage = value;
                    Navigator.pop(context, selectedLanguage);
                  }
                },
              ),
              RadioListTile<String>(
                title: Text("Arabic"),
                value: "Arabic",
                groupValue: selectedLanguage,
                activeColor: AppColors.primaryColor,
                onChanged: (value) {
                  if (value != null) {
                    selectedLanguage = value;
                    Navigator.pop(context, selectedLanguage);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Future<bool> showChangePasswordBottomSheet(BuildContext context) async {
  return await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => ChangePasswordBottomSheet(),
  ) ?? false;
}

bool validatePasswordMatch(String newPassword, String confirmPassword) {
  return newPassword == confirmPassword;
}

Map<String, dynamic> getSubjectDetails(String subjectId, List<Map<String, dynamic>> subjects) {

  print('getSubjectDetails called for subjectId: $subjectId');

  final subject = subjects.firstWhere(
        (s) => s['id'].toString() == subjectId,
    orElse: () => {
      'name': 'Unknown',
      'icon': Icons.subject,
      'color': '0xFF9E9E9E',
    },
  );


  print('Subject found: ${subject['name'] ?? 'Not found'}, Icon: ${subject['icon']}, Color: ${subject['color']}');

  return {
    'name': subject['name'] as String,
    'icon': subject['icon'] as IconData,
    'color': Color(int.parse(subject['color'])),
  };
}