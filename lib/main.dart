import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_reference/profile_screen.dart';
import 'package:share_reference/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ModelTheme(),
        child: Consumer<ModelTheme>(
            builder: (context, ModelTheme themeNotifier, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: themeNotifier.isDark
                ? ThemeData(
                    brightness: Brightness.dark,
                  )
                : ThemeData(
                    brightness: Brightness.light,
                    primaryColor: Colors.green,
                    primarySwatch: Colors.green),
            debugShowCheckedModeBanner: false,
            home: const MyHomePage()
          );
        }));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool newLaunch = false;

  void _loadNewLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      newLaunch = (prefs.getBool("newLaunch")) ?? true;
    });
  }

  void _loadCounter() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    setState(() {
      _counter = pre.getInt('counter')!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadCounter();
    _loadNewLaunch();
  }

  void _incrementCounter() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    setState(() {
      _counter = (pre.getInt('counter') ?? 0) + 1;
      pre.setInt('counter', _counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: newLaunch ? const SplashScreen() : const ProfileScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
