import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/utils/local_storage/hive/hive_helper.dart';


class BoxDetailsScreen extends StatelessWidget {
  final String boxName;

  const BoxDetailsScreen({
    super.key,
    required this.boxName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(boxName),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              _showClearBoxDialog(context);
            },
            icon: const Icon(Icons.delete_sweep),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDataBottomSheet(context);
        },
        child: const Icon(Icons.add),
      ),
      body: ValueListenableBuilder<Box>(
        valueListenable: HiveHelper.listenToBox(boxName: boxName),
        builder: (context, box, child) {
          final keys = box.keys.toList();

          if (keys.isEmpty) {
            return const Center(
              child: Text(
                'No data in this box',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: keys.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final key = keys[index];
              final value = box.get(key);

              return Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Key',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              key.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Value',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              value.toString(),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await HiveHelper.removeData(
                            boxName: boxName,
                            key: key.toString(),
                          );
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showAddDataBottomSheet(BuildContext context) {
    final keyController = TextEditingController();
    final valueController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Add Data',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: keyController,
                decoration: const InputDecoration(
                  labelText: 'Key',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: valueController,
                decoration: const InputDecoration(
                  labelText: 'Value',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final key = keyController.text.trim();
                    final value = valueController.text.trim();

                    if (key.isEmpty || value.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter key and value'),
                        ),
                      );
                      return;
                    }

                    await HiveHelper.saveData(
                      boxName: boxName,
                      key: key,
                      value: value,
                    );

                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showClearBoxDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Clear Box'),
          content: Text(
            'Are you sure you want to remove all data from $boxName?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                await HiveHelper.clearBox(boxName: boxName);

                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: const Text('Clear'),
            ),
          ],
        );
      },
    );
  }
}