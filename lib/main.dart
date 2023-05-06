import 'package:educational_system/Login/login.dart';
import 'package:flutter/material.dart';
import 'Helpers/read_data.dart';
import 'Home/bottomNavigation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoading = true;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Map<String, dynamic> authData = {};
  void checkLoginStatus() async {
    authData = await readUserStorageData();
    if (authData.length > 0) {
      isLoggedIn = true;
      isLoading = false;
    } else {
      isLoading = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Education App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.deepPurple,
        fontFamily: 'OpenSans',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: isLoading
          ? LoadingPage()
          : isLoggedIn
              ? MyBottomNavigation()
              : LoginPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => MyBottomNavigation(),
      },
    );
  }
}

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(), // Material Loader
            SizedBox(height: 20),
            Text('Loading...'),
          ],
        ),
      ),
    );
  }
}
