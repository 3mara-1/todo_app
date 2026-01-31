import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/screens/home_page.dart';
import 'package:todo_app/screens/profile_screen.dart';
import 'package:todo_app/screens/task_completed_screen.dart';
import 'package:todo_app/screens/taskes_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> screens = [
    HomePage(),
    TaskesScreen(),
    TaskCompletedScreen(),
    ProfileScreen(),
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int? index) {
          setState(() {
            _currentIndex = index ?? 0;
          });
        },
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: _svgPicture('assets/images/homeicon.svg', 0),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: _svgPicture('assets/images/task.svg', 1),
            label: 'Tasks',
          ),

          BottomNavigationBarItem(
            icon: _svgPicture('assets/images/completed.svg', 2),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: _svgPicture('assets/images/profileIcon.svg', 3),
            label: 'Profile',
          ),
        ],
      ),
      body: SafeArea(child: screens[_currentIndex]),
    );
  }

  SvgPicture _svgPicture(String path, int index) {
    return SvgPicture.asset(
      path,
      colorFilter: ColorFilter.mode(
        _currentIndex == index
            ? Color(0xff15B86C)
            : Theme.of(context).colorScheme.onSecondary,
        BlendMode.srcIn,
      ),
    );
  }
}
