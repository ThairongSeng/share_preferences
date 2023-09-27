import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_reference/model_theme.dart';
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
    return  Consumer<ModelTheme>(
      builder: (context, ModelTheme themeNotifier, child ){
        return Scaffold(
          appBar: AppBar(
            title: Text(themeNotifier.isDark ? "Dark Mode" : "Light Mode"),
            actions: [
              IconButton(
                  icon: Icon(themeNotifier.isDark
                      ? Icons.nightlight_round
                      : Icons.wb_sunny),
                  onPressed: () {
                    themeNotifier.isDark
                        ? themeNotifier.isDark = false
                        : themeNotifier.isDark = true;
                  })
            ],
          ),
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
      },
    );
  }
}
