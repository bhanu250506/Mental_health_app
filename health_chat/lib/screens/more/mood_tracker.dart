import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_chat/providers/chat_provider.dart';
import 'package:intl/intl.dart';


import '../../widgets/mood_selector.dart';

class MoodTrackerScreen extends ConsumerWidget {
  const MoodTrackerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moodHistoryAsync = ref.watch(moodHistoryProvider);
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Mood Diary'),
        elevation: 1,
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(moodHistoryProvider.notifier).fetchMoods(),
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            Text(
              "How are you feeling today?",
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              DateFormat.yMMMMd().format(DateTime.now()),
              style: theme.textTheme.titleMedium?.copyWith(
                color: color.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            MoodSelector(
              onMoodSelected: (mood) {
                ref.read(moodHistoryProvider.notifier).addMood(mood);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Mood for today saved as "$mood"'),
                    backgroundColor: color.primary,
                  ),
                );
              },
            ),
            const SizedBox(height: 32),
            Text(
              "Recent History",
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            moodHistoryAsync.when(
              data: (moods) {
                if (moods.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.0),
                    child: Center(child: Text("No mood history yet.")),
                  );
                }
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: moods.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final mood = moods[index];
                    return Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 1,
                      child: ListTile(
                        leading: Icon(mood.icon, color: mood.color, size: 32),
                        title: Text(
                          mood.mood,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(DateFormat.yMMMMd().format(mood.date)),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('Error: $err')),
            ),
          ],
        ),
      ),
    );
  }
}