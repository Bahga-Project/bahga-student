class ResultModel {
  final String examName;
  final String date;
  final String grade;
  final String percentage;
  final String subject;
  final bool isOffline;
  final double totalObtained;
  final double totalMarks;
  final List<Map<String, dynamic>> subjects;

  ResultModel({
    required this.examName,
    required this.date,
    required this.grade,
    required this.percentage,
    required this.subject,
    required this.isOffline,
    required this.totalObtained,
    required this.totalMarks,
    required this.subjects,
  });
}
