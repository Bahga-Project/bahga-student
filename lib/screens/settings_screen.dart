import 'package:flutter/material.dart';
import 'package:bahga_student/colors.dart';
import 'package:bahga_student/widgets/custom_app_bar.dart';
import 'package:bahga_student/widgets/settings_title.dart';
import 'package:bahga_student/utils.dart';
import 'package:bahga_student/routes/route_names.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String selectedLanguage = "English";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Settings",
        backgroundColor: AppColors.appBarColor,
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  SettingsTile(
                    icon: Icons.language,
                    title: selectedLanguage,
                    onTap: () async {
                      final newLanguage = await showLanguageBottomSheet(context, selectedLanguage);
                      if (newLanguage != null) {
                        setState(() {
                          selectedLanguage = newLanguage;
                        });
                      }
                    },
                  ),
                  SettingsTile(
                    icon: Icons.lock,
                    title: "Change password",
                    onTap: () async {
                      final success = await showChangePasswordBottomSheet(context);
                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Password changed successfully!")),
                        );
                      }
                    },
                  ),
                  SettingsTile(
                    icon: Icons.notifications,
                    title: "Notifications",
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).pushNamed(RouteNames.Notifications);
                    },
                  ),
                  SettingsTile(
                    icon: Icons.description,
                    title: "Terms & Condition",
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).pushNamed(RouteNames.Terms);
                    },
                  ),
                  SettingsTile(
                    icon: Icons.info,
                    title: "About Us",
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).pushNamed(RouteNames.About_us);
                    },
                  ),
                  SettingsTile(
                    icon: Icons.contact_support,
                    title: "Contact Us",
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).pushNamed(RouteNames.Contact_us);
                    },
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        //  SharedPreferences
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.remove('student_password');
                        await prefs.remove('student_email');


                        Navigator.pushReplacementNamed(context, '/login');  //
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.power_settings_new, color: Colors.white),
                          SizedBox(width: 10),
                          Text(
                            "Log out",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}