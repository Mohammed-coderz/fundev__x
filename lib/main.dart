import 'package:flutter/material.dart';

import 'core/utils/local_storage/hive/hive_helper.dart';
import 'feature/boxes_screen/view/boxes_screen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await HiveHelper.init();

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BoxesScreen(),
    );
  }
}
