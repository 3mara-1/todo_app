import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final String userName;
  bool isLoading = true;
  bool isDark = true;

  void _loadUserName() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      userName = pref.getString('username')!;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? CircularProgressIndicator()
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    'My Profile',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffFFFCFC),
                    ),
                  ),
                ),

                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: AlignmentGeometry.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: AssetImage(
                              'assets/images/profile.png',
                            ),
                            backgroundColor: Colors.transparent,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Color(0xff282828),
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: Color(0xfffffcfc),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      Text(
                        userName,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffFFFCFC),
                        ),
                      ),

                      Text(
                        'One task at a time. One step closer.',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffC6C6C6),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'Profile Info',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffFFFCFC),
                  ),
                ),
                SizedBox(height: 8),
                ListTile(
                  onTap: () {},
                  contentPadding: EdgeInsets.zero,
                  leading: SvgPicture.asset('assets/images/profileIcon.svg'),
                  title: Text(
                    'User Details',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffFFFCFC),
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward, color: Color(0xFFC6C6C6)),
                ),
                Divider(thickness: 1, color: Color(0xFF6E6E6E)),

                ListTile(
              
                  contentPadding: EdgeInsets.zero,
                  leading: SvgPicture.asset('assets/images/darkmode.svg'),
                  title: Text(
                    'Dark Mode',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffFFFCFC),
                    ),
                  ),
                  trailing: Switch(
                    value: isDark,
                    onChanged: (value) {
                      setState(() {
                        isDark = value;
                      });
                    },
                 
                  ),
                ),
                Divider(thickness: 1, color: Color(0xFF6E6E6E)),

                ListTile(
                  onTap: () {},
                  contentPadding: EdgeInsets.zero,
                  leading: SvgPicture.asset('assets/images/log_out.svg'),
                  title: Text(
                    'Log Out',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffFFFCFC),
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward, color: Color(0xFFC6C6C6)),
                ),
                SizedBox(width: 16),
              ],
            ),
          );
  }
}
