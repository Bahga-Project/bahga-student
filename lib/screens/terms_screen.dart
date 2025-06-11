import 'package:flutter/material.dart';
import 'package:bahga_student/colors.dart';
import 'package:bahga_student/widgets/custom_app_bar.dart';

class TermsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Terms & Condition",
        backgroundColor: AppColors.appBarColor,
        showBackButton: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "\n\n"
                "Welcome to the Bahja School for Assisted Learning website. By using this website, you agree to be bound by the following terms and conditions, so please read them carefully.\n\n"
                "1. Definitions\n\n"
                "Refers to the educational institution that provides the programs and services mentioned herein.\n\n"
                "Anyone who visits or uses this website, whether a parent, student, or general visitor.\n\n"
                "2. Use of the Website\n\n"
                "This website may not be used for any purpose that is illegal or inconsistent with our ethical and educational values.\n\n"
                "All information and materials published on the website are for educational and educational purposes only.\n\n"
                "The Academy reserves the right to modify or discontinue any part of the content or services at any time without prior notice.\n\n"
                "3. Intellectual Property\n\n"
                "All materials published on the website (text, images, videos, logos) are the exclusive property of the Academy or have been used under a legal license.\n\n"
                "No content may be copied, republished, or distributed without prior written permission from the Academy.\n\n"
                "4. Data Protection and Privacy\n\n"
                "We respect your privacy. Any personal data provided through the website is treated with the strictest confidentiality and is used only for internal educational and administrative purposes.\n\n"
                "Student or parent data is not shared with any third party without prior consent, unless required by law.\n\n"
                "5. Registration and Subscription\n\n"
                "Some sections of the website require creating an account or completing online forms.\n\n"
                "The user is obligated to provide accurate and correct information upon registration and is responsible for updating it as necessary.\n\n"
                "The Academy reserves the right to suspend or cancel any account used in violation of the website policy.\n\n"
                "6. Liability\n\n"
                "We make every effort to ensure the accuracy and up-to-dateness of the information on the website; however, we are not responsible for any errors or omissions.\n\n"
                "We are not responsible for any direct or indirect damages that may result from using the website or relying on its content.\n\n"
                "7. External Links\n\n"
                "The website may contain links to relevant external websites.\n\n"
                "We are not responsible for the content or privacy policies of those websites.\n\n"
                "8. Modifications to the Terms and Conditions\n\n"
                "We reserve the right to modify these Terms and Conditions at any time without prior notice.\n\n"
                "Continued use of the Site following the posting of modifications constitutes your acceptance of those modifications.\n\n"
                "9. Applicable Law\n\n"
                "These Terms shall be governed by and construed in accordance with the laws of the country in which the Academy operates.\n\n"
                "In the event of any dispute, it shall be subject to the jurisdiction of the competent courts of that country.\n\n"
                "If you have any questions regarding these Terms, you may contact us through the 'Contact Us' page on the Site.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}