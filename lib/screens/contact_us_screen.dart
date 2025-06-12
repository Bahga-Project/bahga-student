import 'package:flutter/material.dart';
import 'package:bahga_student/colors.dart';
import 'package:bahga_student/widgets/custom_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  // Function to launch URLs or phone numbers
  Future<void> _launchURL(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch $url')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Contact Us",
        backgroundColor: AppColors.appBarColor,
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Contacts",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () => _launchURL(context, "tel:01003138425"),
                  child: Row(
                    children: [
                      Icon(Icons.phone, size: 18.0, color: Colors.green[700]),
                      SizedBox(width: 5),
                      Text(
                        "01003138425 - Technical Department",
                        style: TextStyle(fontSize: 16.0, color: AppColors.appBarColor, decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Important Links",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  "Dr. Sherif Taha Younos:",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                InkWell(
                  onTap: () => _launchURL(context, "https://www.facebook.com/SherifTahaYounos"),
                  child: Row(
                    children: [
                      Icon(Icons.facebook, size: 18.0, color: Color(0xFF3b5998)),
                      SizedBox(width: 5),
                      Text(
                        "Dr. Sherif Taha Younos's Official Facebook Page",
                        style: TextStyle(fontSize: 16.0, color: AppColors.appBarColor, decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                InkWell(
                  onTap: () => _launchURL(context, "https://drsheriftahayounos.net/"),
                  child: Row(
                    children: [
                      Icon(Icons.web, size: 18.0, color: Color(0xFF008080)),
                      SizedBox(width: 5),
                      Text(
                        "Official Website",
                        style: TextStyle(fontSize: 16.0, color: AppColors.appBarColor, decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                InkWell(
                  onTap: () => _launchURL(context, "https://t.me/SherifTahaYounos"),
                  child: Row(
                    children: [
                      Icon(Icons.telegram, size: 18.0, color: Color(0xFF0088cc)),
                      SizedBox(width: 5),
                      Text(
                        "Telegram: Sherif Taha Younos",
                        style: TextStyle(fontSize: 16.0, color: AppColors.appBarColor, decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Bahga Activities:",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                InkWell(
                  onTap: () => _launchURL(context, "https://t.me/BahgaCityBahgaClub"),
                  child: Row(
                    children: [
                      Icon(Icons.telegram, size: 18.0, color: Color(0xFF0088cc)),
                      SizedBox(width: 5),
                      Text(
                        "Telegram: Bahga City Bahga Club",
                        style: TextStyle(fontSize: 16.0, color: AppColors.appBarColor, decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Bahga Club for Primary Grades:",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                InkWell(
                  onTap: () => _launchURL(context, "https://t.me/BahgaClub"),
                  child: Row(
                    children: [
                      Icon(Icons.telegram, size: 18.0, color: Color(0xFF0088cc)),
                      SizedBox(width: 5),
                      Text(
                        "Telegram: Bahga Club",
                        style: TextStyle(fontSize: 16.0, color: AppColors.appBarColor, decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                // Text(
                //   "Science and Work Reading Club:",
                //   style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                // ),
                // SizedBox(height: 5),
                // Text(
                //   "A cultural and methodological club to revive the servitude of {Read} methodology (scientific thinking, 'analytical reasoning'; practical 'implementation and activation')",
                //   style: TextStyle(fontSize: 16.0),
                // ),
                SizedBox(height: 5),
                InkWell(
                  onTap: () => _launchURL(context, "https://t.me/LACMR"),
                  child: Row(
                    children: [
                      Icon(Icons.telegram, size: 18.0, color: Color(0xFF0088cc)),
                      SizedBox(width: 5),
                      Text(
                        "Telegram: LACMR",
                        style: TextStyle(fontSize: 16.0, color: AppColors.appBarColor, decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "YouTube Channels:",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                InkWell(
                  onTap: () => _launchURL(context, "https://youtube.com/@belwahinhya?si=32UjitJrZEI857bm"),
                  child: Row(
                    children: [
                      Icon(Icons.play_circle_filled, size: 18.0, color: Color(0xFFff0000)),
                      SizedBox(width: 5),
                      Text(
                        "YouTube: Belwah Inhya",
                        style: TextStyle(fontSize: 16.0, color: AppColors.appBarColor, decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}