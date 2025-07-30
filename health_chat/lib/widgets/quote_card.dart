import 'package:flutter/material.dart';
import 'package:health_chat/models/quote.dart';

class QuoteCard extends StatelessWidget {
  final Quote quote;
  const QuoteCard({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: theme.cardColor,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.format_quote_rounded,
                size: 28, color: theme.primaryColor.withOpacity(0.7)),
            const SizedBox(height: 12),
            Text(
              '"${quote.text}"',
              style: theme.textTheme.bodyLarge?.copyWith(
                height: 1.5,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                '- ${quote.author}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.primaryColorDark.withOpacity(0.8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
