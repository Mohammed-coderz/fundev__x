import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/users_provider.dart';

class UsersScreen extends ConsumerWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(usersProvider);
    final notifier = ref.read(usersProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Users Fake API')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: state.isLoading ? null : notifier.loadUsers,
                    child: const Text('Load Users'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: state.isLoading ? null : notifier.reset,
                    child: const Text('Reset'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            if (state.isLoading)
              const Expanded(child: Center(child: CircularProgressIndicator()))
            else if (state.errorMessage != null)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.errorMessage!,
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: notifier.loadUsers,
                        child: const Text('Reload'),
                      ),
                    ],
                  ),
                ),
              )
            else if (state.users.isEmpty)
              const Expanded(
                child: Center(
                  child: Text(
                    'No users loaded yet',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.separated(
                  itemCount: state.users.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final user = state.users[index];

                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(child: Text(user.id.toString())),
                        title: Text(user.name),
                        subtitle: Text(user.email),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
