import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/providers/quote_provider.dart';

class QuotePage extends ConsumerWidget {
  const QuotePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quoteAsyncValue = ref.watch(quoteProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Quote Page'),
      ),
      body: Center(
        child: quoteAsyncValue.when(
          data: (quote) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '"${quote.quote}"',
                  style: const TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16.0),
                Text(
                  '"~ ${quote.author}"',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
          error: (error, stack) => Text('Error: $error'),
          loading: () => CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.refresh(quoteProvider),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
