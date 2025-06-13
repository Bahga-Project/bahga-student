import 'package:flutter/material.dart';

class TimetableEntry {
  final String startTime;
  final String endTime;
  final String subjectId;
  final String className;
  final String teacher;

  TimetableEntry({
    required this.startTime,
    required this.endTime,
    required this.subjectId,
    required this.className,
    required this.teacher,
  });

  factory TimetableEntry.fromFirestore(Map<String, dynamic> data) {
    return TimetableEntry(
      startTime: data['startTime'] as String,
      endTime: data['endTime'] as String,
      subjectId: data['subjectId'] as String,
      className: data['className'] as String,
      teacher: data['teacher'] as String,
    );
  }

}

Map<String, List<TimetableEntry>> timetableData = {
  'Sun': [
    TimetableEntry(
      startTime: '08:00 AM',
      endTime: '09:00 AM',
      subjectId: 'math',
      className: '2 A',
      teacher: 'Ali Ahmed',
    ),
    TimetableEntry(
      startTime: '09:00 AM',
      endTime: '10:00 AM',
      subjectId: 'arab',
      className: '2 A',
      teacher: 'Sara Abbas',
    ),
    TimetableEntry(
      startTime: '10:00 AM',
      endTime: '11:00 AM',
      subjectId: 'eng',
      className: '2 A',
      teacher: 'Mona Hassan',
    ),
    TimetableEntry(
      startTime: '11:00 AM',
      endTime: '12:00 PM',
      subjectId: 'hist',
      className: '2 A',
      teacher: 'Ahmed Ali',
    ),
    TimetableEntry(
      startTime: '12:00 PM',
      endTime: '01:00 PM',
      subjectId: 'bio',
      className: '2 A',
      teacher: 'Fatima Abbas',
    ),
    TimetableEntry(
      startTime: '01:00 PM',
      endTime: '02:00 PM',
      subjectId: 'phys',
      className: '2 A',
      teacher: 'Hassan Mona',
    ),
  ],
  'Mon': [
    TimetableEntry(
      startTime: '08:00 AM',
      endTime: '09:00 AM',
      subjectId: 'cs',
      className: '2 A',
      teacher: 'Rohby',
    ),
    TimetableEntry(
      startTime: '09:00 AM',
      endTime: '10:00 AM',
      subjectId: 'geo',
      className: '2 A',
      teacher: 'Rohby Rohby',
    ),
    TimetableEntry(
      startTime: '10:00 AM',
      endTime: '11:00 AM',
      subjectId: 'math',
      className: '2 A',
      teacher: 'Ali Ahmed',
    ),
    TimetableEntry(
      startTime: '11:00 AM',
      endTime: '12:00 PM',
      subjectId: 'arab',
      className: '2 A',
      teacher: 'Sara Abbas',
    ),
    TimetableEntry(
      startTime: '12:00 PM',
      endTime: '01:00 PM',
      subjectId: 'eng',
      className: '2 A',
      teacher: 'Mona Hassan',
    ),
    TimetableEntry(
      startTime: '01:00 PM',
      endTime: '02:00 PM',
      subjectId: 'hist',
      className: '2 A',
      teacher: 'Ahmed Ali',
    ),
  ],
  'Tue': [
    TimetableEntry(
      startTime: '08:00 AM',
      endTime: '09:00 AM',
      subjectId: 'bio',
      className: '2 A',
      teacher: 'Fatima Abbas',
    ),
    TimetableEntry(
      startTime: '09:00 AM',
      endTime: '10:00 AM',
      subjectId: 'phys',
      className: '2 A',
      teacher: 'Hassan Mona',
    ),
    TimetableEntry(
      startTime: '10:00 AM',
      endTime: '11:00 AM',
      subjectId: 'cs',
      className: '2 A',
      teacher: 'Rohby',
    ),
    TimetableEntry(
      startTime: '11:00 AM',
      endTime: '12:00 PM',
      subjectId: 'geo',
      className: '2 A',
      teacher: 'Rohby Rohby',
    ),
    TimetableEntry(
      startTime: '12:00 PM',
      endTime: '01:00 PM',
      subjectId: 'math',
      className: '2 A',
      teacher: 'Ali Ahmed',
    ),
    TimetableEntry(
      startTime: '01:00 PM',
      endTime: '02:00 PM',
      subjectId: 'arab',
      className: '2 A',
      teacher: 'Sara Abbas',
    ),
  ],
  'Wed': [
    TimetableEntry(
      startTime: '08:00 AM',
      endTime: '09:00 AM',
      subjectId: 'eng',
      className: '2 A',
      teacher: 'Mona Hassan',
    ),
    TimetableEntry(
      startTime: '09:00 AM',
      endTime: '10:00 AM',
      subjectId: 'hist',
      className: '2 A',
      teacher: 'Ahmed Ali',
    ),
    TimetableEntry(
      startTime: '10:00 AM',
      endTime: '11:00 AM',
      subjectId: 'bio',
      className: '2 A',
      teacher: 'Fatima Abbas',
    ),
    TimetableEntry(
      startTime: '11:00 AM',
      endTime: '12:00 PM',
      subjectId: 'phys',
      className: '2 A',
      teacher: 'Hassan Mona',
    ),
    TimetableEntry(
      startTime: '12:00 PM',
      endTime: '01:00 PM',
      subjectId: 'cs',
      className: '2 A',
      teacher: 'Rohby',
    ),
    TimetableEntry(
      startTime: '01:00 PM',
      endTime: '02:00 PM',
      subjectId: 'geo',
      className: '2 A',
      teacher: 'Rohby Rohby',
    ),
  ],
  'Thu': [
    TimetableEntry(
      startTime: '08:00 AM',
      endTime: '09:00 AM',
      subjectId: 'math',
      className: '2 A',
      teacher: 'Ali Ahmed',
    ),
    TimetableEntry(
      startTime: '09:00 AM',
      endTime: '10:00 AM',
      subjectId: 'arab',
      className: '2 A',
      teacher: 'Sara Abbas',
    ),
    TimetableEntry(
      startTime: '10:00 AM',
      endTime: '11:00 AM',
      subjectId: 'eng',
      className: '2 A',
      teacher: 'Mona Hassan',
    ),
    TimetableEntry(
      startTime: '11:00 AM',
      endTime: '12:00 PM',
      subjectId: 'hist',
      className: '2 A',
      teacher: 'Ahmed Ali',
    ),
    TimetableEntry(
      startTime: '12:00 PM',
      endTime: '01:00 PM',
      subjectId: 'bio',
      className: '2 A',
      teacher: 'Fatima Abbas',
    ),
    TimetableEntry(
      startTime: '01:00 PM',
      endTime: '02:00 PM',
      subjectId: 'phys',
      className: '2 A',
      teacher: 'Hassan Mona',
    ),
  ],
  'Fri': [],
  'Sat': [
    TimetableEntry(
      startTime: '08:00 AM',
      endTime: '09:00 AM',
      subjectId: 'arab',
      className: '2 A',
      teacher: 'Fatima Abbas',
    ),
    TimetableEntry(
      startTime: '09:00 AM',
      endTime: '10:00 AM',
      subjectId: 'phys',
      className: '2 A',
      teacher: 'Hassan Mona',
    ),
    TimetableEntry(
      startTime: '10:00 AM',
      endTime: '11:00 AM',
      subjectId: 'cs',
      className: '2 A',
      teacher: 'Rohby',
    ),
    TimetableEntry(
      startTime: '11:00 AM',
      endTime: '12:00 PM',
      subjectId: 'geo',
      className: '2 A',
      teacher: 'Rohby Rohby',
    ),
    TimetableEntry(
      startTime: '12:00 PM',
      endTime: '01:00 PM',
      subjectId: 'math',
      className: '2 A',
      teacher: 'Ali Ahmed',
    ),
    TimetableEntry(
      startTime: '01:00 PM',
      endTime: '02:00 PM',
      subjectId: 'arab',
      className: '2 A',
      teacher: 'Sara Abbas',
    ),
  ],
};


String getCurrentDay() {
  final now = DateTime.now();
  switch (now.weekday) {
    case DateTime.monday:
      return 'Mon';
    case DateTime.tuesday:
      return 'Tue';
    case DateTime.wednesday:
      return 'Wed';
    case DateTime.thursday:
      return 'Thu';
    case DateTime.friday:
      return 'Fri';
    case DateTime.saturday:
      return 'Sat';
    case DateTime.sunday:
      return 'Sun';
    default:
      return 'Mon';
  }
}