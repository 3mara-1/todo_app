import 'package:flutter/material.dart';
import 'package:todo_app/core/constant/storage_key.dart';
import 'package:todo_app/core/services/preferences_manager.dart';
import 'package:todo_app/core/widgets/custom_text_form_filed.dart';

class ProfilDetialsScreen extends StatefulWidget {
  ProfilDetialsScreen({
    super.key,
    required this.userName,
    required this.motivationQuate,
  });
  final String userName;
  final String motivationQuate;

  @override
  State<ProfilDetialsScreen> createState() => _ProfilDetialsScreenState();
}

class _ProfilDetialsScreenState extends State<ProfilDetialsScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController motivationController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey();
  @override
  void initState() {
    nameController.text = widget.userName;
    motivationController.text = widget.motivationQuate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Details')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _key,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      CustomTextFormFiled(
                        controller: nameController,
                        hintText: 'Ahmed Omara',
                        title: 'User Name',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "please enter your name";
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      CustomTextFormFiled(
                        controller: motivationController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'please enter Motivation quate';
                          }
                        },
                        hintText: 'One task at a time. One step closer.',
                        title: 'Motivation Quate',
                        maxLines: 5,
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      await PreferencesManager().setString(
                        StorageKey.username,
                        nameController.value.text,
                      );
                      await PreferencesManager().setString(
                        StorageKey.motivationQuates,
                        motivationController.value.text,
                      );
                      Navigator.pop(context, true);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width, 40),
                  ),

                  child: Text(
                    'Save Changes',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xffFFFCFC),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
