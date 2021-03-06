import 'package:flutter/material.dart';
import 'package:flutter_nga/utils/route.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("设置")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text("账号管理"),
              subtitle: Text("管理您的账号"),
              onTap: () =>
                  Routes.navigateTo(context, Routes.ACCOUNT_MANAGEMENT),
            ),
          ],
        ),
      ),
    );
  }
}
