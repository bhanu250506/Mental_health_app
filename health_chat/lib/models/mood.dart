import 'package:flutter/material.dart';


class Mood {
  final String id;
  final String mood;
  final DateTime date;

  Mood({
    required this.id,
    required this.mood,
    required this.date
  });

  factory Mood.fromJson(Map<String, dynamic> json){
    return Mood(
      id: json['_id'],
      mood: json['mood'],
      date: DateTime.parse(json['date']),
    );
  }

  IconData get icon {
    switch (mood) {
      case 'Happy':
        return Icons.sentiment_very_satisfied;
      case 'Okay':
        return Icons.sentiment_satisfied;
      case 'Sad':
        return Icons.sentiment_very_dissatisfied;
      case 'Anxious':
        return Icons.sentiment_neutral;
      case 'Angry':
        return Icons.sentiment_dissatisfied;
      default:
        return Icons.sentiment_satisfied;
    }
  }
  Color get color {
    switch (mood) {
      case 'Happy':
        return Colors.green;
      case 'Okay':
        return Colors.blue;
      case 'Sad':
        return Colors.grey;
      case 'Anxious':
        return Colors.orange;
      case 'Angry':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }
}