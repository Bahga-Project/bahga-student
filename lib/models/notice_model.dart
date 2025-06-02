class Notice {
  final String title;
  final String? imageName; // اسم الصورة (اختياري)
  final String date;

  const Notice({
    required this.title,
    this.imageName,
    required this.date,
  });
}