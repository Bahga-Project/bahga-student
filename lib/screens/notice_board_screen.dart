import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bahga_student/colors.dart';
import 'package:bahga_student/widgets/custom_app_bar.dart';
import 'package:bahga_student/widgets/custom_bottom_navigation_bar.dart';
import 'package:bahga_student/screens/home_screen.dart';
import 'package:bahga_student/screens/assignments_screen.dart';
import 'package:bahga_student/models/notice_model.dart';



class NoticeBoardScreen extends StatelessWidget {
  const NoticeBoardScreen({Key? key}) : super(key: key);


  final List<Notice> notices = const [
    Notice(
      title: "Career Day",
      date: "about a year ago",
    ),
    Notice(
      title: "Sports day",
      imageName: "event.png",
      date: "9 months ago",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // ضبط الـ Status Bar
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    final customAppBar = CustomAppBar(
      title: "Notice Board",
      backgroundColor: AppColors.primaryColor,
      showBackButton: true,
      titleWidget: const Text(
        "Notice Board",
        style: TextStyle(
          color: AppColors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: customAppBar,
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: notices.length,
        itemBuilder: (context, index) {
          final notice = notices[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: NoticeCard(notice: notice),
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 3, // "Menu" مختار
        onTap: (index) {
          // منطق التنقل
          switch (index) {
            case 0: // Home
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
              break;
            case 1: // Assignments
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AssignmentsScreen()),
              );
              break;
            case 3: // Menu
            // مُعالج بالفعل في CustomBottomNavigationBar
              break;
          }
        },
      ),
    );
  }
}

// ويدجت لعرض الملاحظة
class NoticeCard extends StatelessWidget {
  final Notice notice;

  const NoticeCard({Key? key, required this.notice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            notice.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 8),
          if (notice.imageName != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  notice.imageName!,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textColor_2,
                  ),
                ),
                // IconButton(
                //   icon: const Icon(
                //     Icons.download,
                //     color: AppColors.primaryColor,
                //     size: 24,
                //   ),
                //   onPressed: () {
                //   },
                // ),
              ],
            ),
          const SizedBox(height: 8),

          Text(
            notice.date,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textColor_2,
            ),
          ),
        ],
      ),
    );
  }
}