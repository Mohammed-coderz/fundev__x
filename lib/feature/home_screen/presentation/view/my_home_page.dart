import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/counter_provider.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    final counterNotifier = ref.read(counterProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            const SizedBox(height: 12),
            Text('$counter', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: counterNotifier.add,
              child: const Text('Add'),
            ),
            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: counterNotifier.remove,
              child: const Text('Remove'),
            ),
            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: counterNotifier.reset,
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
