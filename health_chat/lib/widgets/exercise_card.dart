import 'package:flutter/material.dart';
import 'package:health_chat/models/exercise.dart';

class ExerciseCard extends StatelessWidget {
  final Exercise exercise;
  const ExerciseCard({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          // Optional: show detail or play audio/video etc.
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(exercise.icon, size: 30, color: color.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      exercise.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                exercise.description,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: color.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
