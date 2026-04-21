import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fun_dev_x/feature/users/presentation/view/users_screen.dart';

import 'feature/home_screen/presentation/view/my_home_page.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: UsersScreen(),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
