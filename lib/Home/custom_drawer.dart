import 'dart:convert';
import 'package:educational_system/Login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            iconColor: theme.colorScheme.onPrimaryContainer,
            textColor: theme.colorScheme.onPrimaryContainer,
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              onLogoutTap(context); // Close the drawer
            },
          ),
        ],
      ),
    );
  }

  Future<void> onLogoutTap(context) async {
    const storage = FlutterSecureStorage();
    final jsonString = jsonEncode("");
    await storage.write(key: 'authData', value: jsonString);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => LoginPage(),
      ),
    );
  }
}
