import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/core/constant/storage_key.dart';
import 'package:todo_app/core/services/preferences_manager.dart';
import 'package:todo_app/core/theme/theme_controler.dart';
import 'package:todo_app/core/widgets/custom_svg_picture.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/features/profile/profil_detials_screen.dart';
import 'package:todo_app/features/welcome/welcome._screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String userName;
  late String? motivationQuate;
  String? userImagePath;

  bool isLoading = true;
  bool isDark = false;

  void _loadUserName() async {
    setState(() {
      userName = PreferencesManager().getString(StorageKey.username)!;
      motivationQuate =
          PreferencesManager().getString('motivation_quate') ??
          'One task at a time. One step closer.';
      userImagePath = PreferencesManager().getString('user_image');
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
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Text(
                      'My Profile',
                      style: Theme.of(context).textTheme.bodyMedium,
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
                            backgroundImage: userImagePath == null
                                ? AssetImage('assets/images/profile.png')
                                : FileImage(File(userImagePath!)),
                            backgroundColor: Colors.transparent,
                          ),
                          GestureDetector(
                            onTap: () {
                              _showImageSourceDialoge(context, ((XFile file) {
                                _saveImade(file);

                                setState(() {
                                  userImagePath = file.path;
                                });
                              }));
                            },
                            child: Container(
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Theme.of(
                                  context,
                                ).colorScheme.primaryContainer,
                              ),
                              child: Icon(Icons.camera_alt_outlined),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      Text(
                        userName,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),

                      Text(
                        motivationQuate!,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'Profile Info',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 8),
                ListTile(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext contixt) {
                          return ProfilDetialsScreen(
                            userName: userName,
                            motivationQuate: motivationQuate!,
                          );
                        },
                      ),
                    );
                    if (result != null && result) {
                      _loadUserName();
                    }
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: CustomSvgPicture(
                    imageSrc: 'assets/images/profileIcon.svg',
                  ),
                  title: Text(
                    'User Details',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  trailing: Icon(Icons.arrow_forward),
                ),

                Divider(thickness: 1),

                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CustomSvgPicture(
                    imageSrc: 'assets/images/darkmode.svg',
                  ),
                  title: Text(
                    'Dark Mode',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  trailing: ValueListenableBuilder(
                    valueListenable: ThemeControler.themeNotifier,
                    builder: (context, value, child) {
                      return Switch(
                        value: isDark,
                        onChanged: (value) {
                          isDark =
                              ThemeControler.themeNotifier.value ==
                              ThemeMode.light;
                          ThemeControler().toggelTheme();
                        },
                      );
                    },
                  ),
                ),
                Divider(thickness: 1),

                ListTile(
                  onTap: () async {
                    PreferencesManager().remove(StorageKey.username);
                    PreferencesManager().remove('motivation_quate');
                    PreferencesManager().remove('tasks');

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => Welcome(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: CustomSvgPicture(
                    imageSrc: 'assets/images/log_out.svg',
                  ),
                  title: Text(
                    'Log Out',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  trailing: Icon(Icons.arrow_forward),
                ),
                SizedBox(width: 16),
              ],
            ),
          );
  }

  void _saveImade(XFile file) async {
    final appDir = await getApplicationDocumentsDirectory();
    final newPath = await File(file.path).copy('${appDir.path}/${file.name}');
    PreferencesManager().setString('user_image', newPath.path);
  }

  void _showImageSourceDialoge(
    BuildContext context,
    Function(XFile) selectedFile,
  ) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        children: [
          SimpleDialogOption(
            onPressed: () async {
              Navigator.pop(context);
              XFile? image = await ImagePicker().pickImage(
                source: ImageSource.camera,
              );

              if (image != null) {
                selectedFile(image);
              }
            },
            child: Row(
              children: [
                Icon(Icons.camera_alt),
                SizedBox(width: 8),
                Text('Camera', style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () async {
              Navigator.pop(context);
              XFile? image = await ImagePicker().pickImage(
                source: ImageSource.gallery,
              );

              if (image != null) {
                selectedFile(image);
              }
            },
            child: Row(
              children: [
                Icon(Icons.photo_library),
                SizedBox(width: 8),
                Text('Galary', style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDataTime(BuildContext context) async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2002),
      lastDate: DateTime(2026, 9),
    );
    showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 12, minute: 0),
    );
  }

  _showMoadal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.9,
          ),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 7,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsetsGeometry.all(18),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  color: Colors.deepOrange,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
