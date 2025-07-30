import 'package:flutter/material.dart';

class Exercise {
  final String id;
  final String title;
  final String description;
  final String category;

  Exercise({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
});

  factory Exercise.fromJson(Map<String, dynamic> json){
    return Exercise(
        id: json['_id'],
        title: json['title'],
        description: json['description'],
        category: json['category']
    );
  }

  IconData get icon {
    switch(category){
      case 'Breathing':
        return Icons.air;
      case 'Mindfulness':
        return Icons.self_improvement;
      case 'Daily Task':
        return Icons.check_circle_outline;
      default:
        return Icons.spa;
    }
  }
}