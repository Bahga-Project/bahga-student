// models/subject.dart
import 'package:flutter/material.dart';

class Topic {
  final String type;
  final String title;
  final String url;
  final String content;

  Topic({
    required this.type,
    required this.title,
    required this.url,
    required this.content,
  });

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      type: json['type'] ?? '',
      title: json['title'] ?? '',
      url: json['url'] ?? '',
      content: json['content'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'title': title,
      'url': url,
      'content': content,
    };
  }
}

class Lesson {
  final String title;
  final String description;
  final List<Topic> topics;

  Lesson({
    required this.title,
    required this.description,
    required this.topics,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      topics: (json['topics'] as List<dynamic>?)
              ?.map((topicJson) =>
                  Topic.fromJson(topicJson as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'topics': topics.map((topic) => topic.toJson()).toList(),
    };
  }
}

class Subject {
  final String id;
  final String name;
  final IconData icon;
  final String color;
  final List<Lesson> lessons;

  Subject({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.lessons,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      icon: _iconFromString(json['icon'] ?? 'help_outline'),
      color: json['color'] ?? '0xFF9E9E9E',
      lessons: (json['lessons'] as List<dynamic>?)
              ?.map((lessonJson) =>
                  Lesson.fromJson(lessonJson as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'iconName': _iconToString(icon),
      'color': color,
      'lessons': lessons.map((lesson) => lesson.toJson()).toList(),
    };
  }

  // Helper method to convert IconData to string for Firebase storage
  static String _iconToString(IconData icon) {
    switch (icon) {
      case Icons.calculate:
        return 'calculate';
      case Icons.language:
        return 'language';
      case Icons.computer:
        return 'computer';
      case Icons.science:
        return 'science';
      case Icons.psychology:
        return 'psychology';
      case Icons.book:
        return 'book';
      case Icons.history_edu:
        return 'history_edu';
      case Icons.public:
        return 'public';
      default:
        return 'help_outline';
    }
  }

  // Helper method to convert string to IconData from Firebase
  static IconData _iconFromString(String iconName) {
    switch (iconName) {
      case 'calculate':
        return Icons.calculate;
      case 'language':
        return Icons.language;
      case 'computer':
        return Icons.computer;
      case 'science':
        return Icons.science;
      case 'psychology':
        return Icons.psychology;
      case 'book':
        return Icons.book;
      case 'history_edu':
        return Icons.history_edu;
      case 'public':
        return Icons.public;
      case 'lightbulb':
        return Icons.lightbulb;
      case 'local_florist':
        return Icons.local_florist;
      case 'menu_book':
        return Icons.menu_book;
      case 'map':
        return Icons.map;
      case 'library_books':
        return Icons.library_books;
      default:
        return Icons.subject; // Default icon
    }
  }
}
