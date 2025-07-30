import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../providers/chat_provider.dart';
import '../../widgets/quote_card.dart';

class QuotesScreen extends ConsumerWidget {
  const QuotesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quotesAsync = ref.watch(quotesProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Positive Quotes'),
        elevation: 0,
      ),
      body: quotesAsync.when(
        data: (quotes) {
          if (quotes.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.format_quote_rounded,
                        color: theme.primaryColor, size: 60),
                    const SizedBox(height: 16),
                    Text(
                      "No quotes available yet.",
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700),
                    ),
                  ],
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(quotesProvider);
              await ref.read(quotesProvider.future);
            },
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 600;

                return MasonryGridView.count(
                  crossAxisCount: isWide ? 3 : 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  padding: const EdgeInsets.all(16),
                  itemCount: quotes.length,
                  itemBuilder: (context, index) {
                    return QuoteCard(quote: quotes[index]);
                  },
                );
              },
            ),
          );
        },
        loading: () =>
        const Center(child: CircularProgressIndicator(strokeWidth: 2.5)),
        error: (err, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              'Failed to load quotes.\n$err',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}
