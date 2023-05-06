import 'package:flutter/material.dart';
import '../Courses/courses.dart';
import '../Profile/profile.dart';

class MyBottomNavigation extends StatefulWidget {
  @override
  _MyBottomNavigationState createState() => _MyBottomNavigationState();
}

class _MyBottomNavigationState extends State<MyBottomNavigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    CoursesPage(parent: "courses"),
    CoursesPage(parent: "results"),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.home),
          //   label: 'Home',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Courses',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.assignment),
          //   label: 'Exams',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.poll),
            label: 'Results',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        backgroundColor: theme.colorScheme
            .primaryContainer, // Set bottom navigation bar background color
        selectedItemColor:
            theme.colorScheme.onPrimaryContainer, // Set selected item color
        unselectedItemColor:
            theme.colorScheme.primary, // Set unselected item color
        type: BottomNavigationBarType
            .fixed, // Set type to fixed for more than 3 items
      ),
    );
  }
}
