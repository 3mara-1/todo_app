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
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xff181818),
        selectedItemColor: Color(0xff15B86C),
        unselectedItemColor: Color(0xFFC6C6C6),

        onTap: (int? index) {
          setState(() {
            _currentIndex = index ?? 0;
          });
        },
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/homeicon.svg',
              colorFilter: ColorFilter.mode(
                _currentIndex == 0 ? Color(0xff15B86C) : Color(0xFFC6C6C6),
                BlendMode.srcIn,
              ),
            ),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/task.svg',
              colorFilter: ColorFilter.mode(
                _currentIndex == 1 ? Color(0xff15B86C) : Color(0xFFC6C6C6),
                BlendMode.srcIn,
              ),
            ),
            label: 'Tasks',
          ),

          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/completed.svg',
              colorFilter: ColorFilter.mode(
                _currentIndex == 2 ? Color(0xff15B86C) : Color(0xFFC6C6C6),
                BlendMode.srcIn,
              ),
            ),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/profileIcon.svg',
              colorFilter: ColorFilter.mode(
                _currentIndex == 3 ? Color(0xff15B86C) : Color(0xFFC6C6C6),
                BlendMode.srcIn,
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
      body: SafeArea(child: screens[_currentIndex]),
    );
  }
}
