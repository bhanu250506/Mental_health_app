import 'package:flutter/material.dart';

class MoodSelector extends StatefulWidget {
  final Function(String) onMoodSelected;
  const MoodSelector({super.key, required this.onMoodSelected});

  @override
  State<MoodSelector> createState() => _MoodSelectorState();
}

class _MoodSelectorState extends State<MoodSelector> {
  String? _selectedMood;

  final Map<String, IconData> moods = {
    'Happy': Icons.sentiment_very_satisfied,
    'Okay': Icons.sentiment_satisfied,
    'Sad': Icons.sentiment_very_dissatisfied,
    'Anxious': Icons.sentiment_neutral,
    'Angry': Icons.sentiment_dissatisfied,
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: color.surfaceVariant.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: moods.entries.map((entry) {
          final isSelected = _selectedMood == entry.key;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedMood = entry.key;
              });
              widget.onMoodSelected(entry.key);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected ? color.primary.withOpacity(0.2) : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    entry.value,
                    size: 32,
                    color: isSelected ? color.primary : theme.iconTheme.color?.withOpacity(0.6),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    entry.key,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? color.primary : theme.textTheme.bodySmall?.color,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
