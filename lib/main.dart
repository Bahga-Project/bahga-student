
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bahga_student/routes/app_routes_map.dart';
import 'package:bahga_student/routes/route_names.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/assignments_screen.dart';
import 'screens/home_screen.dart';
import 'screens/main_screen.dart';
import 'screens/menu_sheet.dart';
import 'screens/exams-screen.dart';
import 'screens/timetable_screen.dart';
import 'screens/notice_board_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/attendance_screen.dart';
import 'screens/result_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/terms_screen.dart';
import 'screens/about_us_screen.dart';
import 'screens/contact_us_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';



/*


import 'screens/report_screen.dart';
import 'screens/guardian_details_screen.dart';
import 'screens/holidays_screen.dart';
import 'screens/gallery_screen.dart';
import 'screens/settings_screen.dart';
*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.cairoTextTheme(),
        radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.all(Colors.blue), // اللون الجديد للدائرة
        ),
      ),

      // ✅ Start from MainScreen with globalKey
      initialRoute: RouteNames.splash,
      // استخدام AppRoutesMap بدلاً من كتابة الروترات يدويًا
      routes: AppRoutesMap.routes,
      // Already connected with its globalKey inside

      // ✅ Named routes for pages outside bottom navigation

    );
  }
}
