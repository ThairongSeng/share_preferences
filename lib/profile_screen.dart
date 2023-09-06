import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  clearSharePreference() async{
    SharedPreferences pre = await SharedPreferences.getInstance();
    pre.remove('newLaunch');
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Profile Screen"),
            ElevatedButton(
                onPressed: () => clearSharePreference(),
                child: const Text("Clear SharedPreference")
            )
          ],
        )
      ),
    );
  }
}
