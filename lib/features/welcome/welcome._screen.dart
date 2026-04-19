import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/constant/app_size.dart';

import 'package:todo_app/core/constant/constant.dart';
import 'package:todo_app/core/constant/storage_key.dart';
import 'package:todo_app/core/services/preferences_manager.dart';
import 'package:todo_app/core/widgets/custom_svg_picture.dart';
import 'package:todo_app/core/widgets/custom_text_form_filed.dart';
import 'package:todo_app/features/navigation/main_screen.dart';

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
            padding: EdgeInsets.symmetric(horizontal: AppSize.h16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: AppSize.h30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomSvgPicture.withoutcolor(
                      imageSrc: kLogoPath,
                      width: AppSize.w40,
                      height: AppSize.h40,
                    ),
                    SizedBox(width: AppSize.w4),
                    Text(
                      'Tasky',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
                SizedBox(height: AppSize.h108),
                Column(
                  children: [
                    Text(
                      'Welcome To Tasky ',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),

                    SizedBox(height: AppSize.h12),
                    Text(
                      'Your productivity journey starts here. ',
                      style: Theme.of(
                        context,
                      ).textTheme.displaySmall!.copyWith(fontSize: AppSize.f16),
                    ),
                  ],
                ),
                SizedBox(height: AppSize.h24),

                CustomSvgPicture.withoutcolor(
                  imageSrc: kPanaPath,
                  width: AppSize.w216,
                  height: AppSize.h204,
                ),
                SizedBox(height: AppSize.h24),
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
                      SizedBox(height: AppSize.w24),
                      ElevatedButton(
                        onPressed: () async {
                          if (_key.currentState?.validate() ?? false) {
                            await PreferencesManager().setString(
                              StorageKey.username,
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

                        child: Text('Let’s Get Started'),
                      ),
                      SizedBox(height: AppSize.h124),
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
