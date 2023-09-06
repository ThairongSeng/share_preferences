import 'package:flutter/material.dart';
import 'package:share_reference/profile_screen.dart';
import 'package:share_reference/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool newLaunch = false;

  void _loadNewLaunch() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      newLaunch = (prefs.getBool("newLaunch")) ?? true;
    });
  }

  void _loadCounter() async{
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

  void _incrementCounter() async{
    SharedPreferences pre= await SharedPreferences.getInstance();
    setState(() {
      _counter = (pre.getInt('counter') ?? 0) + 1;
      pre.setInt('counter', _counter);

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: newLaunch ? const SplashScreen() : const ProfileScreen(),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
