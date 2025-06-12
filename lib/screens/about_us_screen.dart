import 'package:flutter/material.dart';
import 'package:bahga_student/colors.dart';
import 'package:bahga_student/widgets/custom_app_bar.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "About Us",
        backgroundColor: AppColors.appBarColor,
        showBackButton: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child:Text(
            "\n\n"
                "We are a leading academy in comprehensive education. We believe that building a person begins at the roots, from childhood to maturity, through balanced paths that combine faith and knowledge, values and skills.\n\n"
                "We offer educational and training programs aimed at developing a well-rounded personality: confident, aware, and influential in their community.\n\n"
                "Our Vision\n\n"
                "To raise a guided Muslim generation, systematic in its thinking, refined in its faith, skilled in its skills, and prepared to build a civilization based on knowledge and values.\n\n"
                "Our Mission\n\n"
                "We teach for change and educate for authenticity.\n\n"
                "We provide an educational environment that combines authenticity and modernity, building a balanced individual in mind, spirit, and behavior.\n\n"
                "Our Departments\n\n"
                "1. The Educational School (from kindergarten to high school)\n\n"
                "We provide a distinguished school education that combines accredited educational curricula with a value-based educational approach. Our goal is not just to achieve grades, but to build character:\n\n"
                "A guided Muslim: lives his identity with confidence, drawing his path from the Qur'an and Sunnah.\n"
                "A systematic thinker: learns how to think, not just what to think.\n"
                "An improved believer: develops his relationship with God through daily educational practices.\n"
                "A skilled builder: acquires practical skills that prepare him for a productive and effective life.\n\n"
                "2. Life Skills and Vocational Training Department\n\n"
                "This department provides an enjoyable and realistic learning experience in various fields, including:\n\n"
                "Technical and vocational skills: electronics, electricity, programming, sewing, crochet, pottery, and more.\n"
                "Cognitive skills: mental arithmetic, critical thinking, and problem-solving.\n"
                "Physical activities: such as the sport 'Vida,' which develops strength, fitness, and balance.\n\n"
                "3. Faith Education Department - Young Contemplative\n\n"
                "A unique program to instill faith awareness from an early age, based on three axes:\n\n"
                "The Unity of the Quranic Message: We teach children that the Quran is not just a book to be recited, but rather a message of life and a path of guidance.\n"
                "The Quran as Knowledge: Understanding the meanings and contemplating the verses.\n"
                "The Quran as Recitation: Mastering memorization and correct recitation.\n"
                "The Quran as Care: Translating the Quran into daily practical behavior that demonstrates the impact of faith in life.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}