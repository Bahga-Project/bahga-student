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
}

Map<String, List<TimetableEntry>> timetableData = {
  'Sun': [
    TimetableEntry(
      startTime: '08:00 AM',
      endTime: '09:30 AM',
      subjectId: 'math',
      className: '2 A',
      teacher: 'Ali Ahmed',
    ),
    TimetableEntry(
      startTime: '09:30 AM',
      endTime: '11:00 AM',
      subjectId: 'arab',
      className: '2 A',
      teacher: 'Sara Abbas',
    ),
    TimetableEntry(
      startTime: '09:00 AM',
      endTime: '10:30 AM',
      subjectId: 'eng',
      className: '2 A',
      teacher: 'Mona Hassan',
    ),
    TimetableEntry(
      startTime: '09:00 AM',
      endTime: '10:30 AM',
      subjectId: 'hist',
      className: '2 A',
      teacher: 'Mona Hassan',
    ),
    TimetableEntry(
      startTime: '09:00 AM',
      endTime: '10:30 AM',
      subjectId: 'bio',
      className: '2 A',
      teacher: 'Mona Hassan',
    ),
    TimetableEntry(
      startTime: '09:00 AM',
      endTime: '10:30 AM',
      subjectId: 'phys',
      className: '2 A',
      teacher: 'Mona Hassan',
    ),
  ],
  'Mon': [
    TimetableEntry(
      startTime: '07:30 AM',
      endTime: '09:00 AM',
      subjectId: 'cs',
      className: '2 A',
      teacher: 'Rohby',
    ),
    TimetableEntry(
      startTime: '09:00 AM',
      endTime: '10:30 AM',
      subjectId: 'eng',
      className: '2 A',
      teacher: 'Mona Hassan',
    ),
    TimetableEntry(
      startTime: '09:00 AM',
      endTime: '10:30 AM',
      subjectId: 'bio',
      className: '2 A',
      teacher: 'Mona Hassan',
    ),
    TimetableEntry(
      startTime: '09:00 AM',
      endTime: '10:30 AM',
      subjectId: 'hist',
      className: '2 A',
      teacher: 'Mona Hassan',
    ),
    TimetableEntry(
      startTime: '09:00 AM',
      endTime: '10:30 AM',
      subjectId: 'geo',
      className: '2 A',
      teacher: 'Mona Hassan',
    ),
  ],
  'Tue': [],
  'Wed': [],
  'Thu': [],
  'Fri': [],
  'Sat': [],
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