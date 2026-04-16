import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController phoneController = TextEditingController();
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var H = MediaQuery.of(context).size.height;
    var W = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.purple),
              child: Center(
                child: Column(
                  mainAxisAlignment: .center,
                  children: [
                    CircleAvatar(child: Icon(Icons.person)),
                    Text("mhmdsameer75@gmail.com"),
                    Text("0796133785"),
                  ],
                ),
              ),
            ),
            ListTile(
              title: Text("Home"),
              leading: Icon(Icons.home),
              onTap: () {},
            ),
            ListTile(
              title: Text("setting"),
              leading: Icon(Icons.home),
              onTap: () {},
            ),
            ListTile(
              title: Text("logout"),
              leading: Icon(Icons.home),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              if (context.locale.languageCode == "en") {
                context.setLocale(Locale('ar'));
              } else {
                context.setLocale(Locale('en'));
              }
            },
            icon: Icon(Icons.language),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Spacer(flex: 3),
            Text(
              'counter'.tr(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: H * 0.05),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                helper: Text("phone"),
                label: Text("phone"),
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.phone),
              ),
            ),
            Spacer(flex: 5),
            Row(
              mainAxisAlignment: .spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _incrementCounter,
                  child: SvgPicture.asset("assets/images/svg/add.svg"),
                ),
                InkWell(
                  onTap: () {
                    print(phoneController);
                    print(phoneController.text);
                  },
                  child: Container(
                    height: H * 0.05,
                    width: W * 0.2,
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: SvgPicture.asset("assets/images/svg/add.svg"),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: _incrementCounter,
                  child: Text("increment"),
                ),
              ],
            ),
            Spacer(flex: 2),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: SvgPicture.asset("assets/images/svg/add.svg"),
      ),
    );
  }
}
