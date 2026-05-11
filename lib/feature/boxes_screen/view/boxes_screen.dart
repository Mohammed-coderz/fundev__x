import 'package:flutter/material.dart';

import '../../../core/utils/local_storage/hive/const/hive_boxes.dart';
import '../../boxes_details_screen/view/box_details_screen.dart';

class BoxesScreen extends StatelessWidget {
  const BoxesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final boxes = [
      HiveBoxes.authBox,
      HiveBoxes.settingsBox,
      HiveBoxes.cartBox,
      HiveBoxes.cacheBox,
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive Boxes'),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: boxes.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final boxName = boxes[index];

          return Card(
            elevation: 2,
            child: ListTile(
              title: Text(
                boxName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text('Tap to manage this box'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BoxDetailsScreen(
                      boxName: boxName,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}