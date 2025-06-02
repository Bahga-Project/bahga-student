class Assignment {
  final String title;
  final String subject;
  final String date;
  final String due;
  final String iconPath;
  final int color;

  Assignment({
    required this.title,
    required this.subject,
    required this.date,
    required this.due,
    required this.iconPath,
    required this.color,
  });

  // Factory method to create Assignment object from Firestore document
  factory Assignment.fromFirestore(Map<String, dynamic> data) {
    return Assignment(
      title: data['title'] ?? 'Untitled',
      subject: data['subject'] ?? 'Unknown Subject',
      due: data['due'] ?? 'No Due Date',
      date: data['date'] ?? 'No Date',
      iconPath: data['iconPath'] ?? 'assets/default_icon.png',
      color: (data['color'] as int?) ?? 0xFF2196F3, // Default blue color
    );
  }
}
