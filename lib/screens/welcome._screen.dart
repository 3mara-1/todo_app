import 'package:flutter/material.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/core/services/preferences_manager.dart';
import 'package:todo_app/core/widgets/custom_svg_picture.dart';
import 'package:todo_app/core/widgets/custom_text_form_filed.dart';
import 'package:todo_app/screens/main_screen.dart';

class Welcome extends StatelessWidget {
  Welcome({super.key});
  final TextEditingController namecontroller = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 0),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomSvgPicture.withoutcolor(
                      imageSrc: kLogoPath,
                      width: 42,
                      height: 42,
                    ),
                    Text(
                      'Tasky',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
                SizedBox(height: 180),
                Column(
                  children: [
                    Text(
                      'Welcome To Tasky ',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),

                    SizedBox(height: 10),
                    Text(
                      'Your productivity journey starts here. ',
                      style: Theme.of(
                        context,
                      ).textTheme.displaySmall!.copyWith(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(height: 24),

                CustomSvgPicture.withoutcolor(
                  imageSrc: kPanaPath,
                  width: 216,
                  height: 204,
                ),
                SizedBox(height: 24),
                Form(
                  key: _key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomTextFormFiled(
                        controller: namecontroller,
                        title: "Full Name",
                        hintText: 'e.g. Sarah Khalid',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "please enter your full name";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () async {
                          if (_key.currentState?.validate() ?? false) {
                            await PreferencesManager().setString(
                              'username',
                              namecontroller.value.text,
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => MainScreen(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("please enter valed name "),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(
                            MediaQuery.of(context).size.width,
                            40,
                          ),
                        ),
                        child: Text('Let’s Get Started'),
                      ),
                      SizedBox(height: 124),
                    ],
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
