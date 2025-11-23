import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/home_page.dart';

class Welcome extends StatelessWidget {
  Welcome({super.key});
  final TextEditingController namecontroller = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff181818),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  SvgPicture.asset(kLogoPath, width: 42, height: 42),
                  Text(
                    'Tasky',
                    style: TextStyle(
                      color: Color(0xffffffff),
                      fontSize: 28,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),

              Column(
                children: [
                  Text(
                    'Welcome To Tasky ',
                    style: TextStyle(
                      color: Color(0xffffffff),
                      fontSize: 28,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Your productivity journey starts here. ',
                    style: TextStyle(
                      color: Color(0xffffffff),
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SvgPicture.asset(kPanaPath, width: 216, height: 204),
              Form(
                key: _key,
                child: Column(
                  spacing: 15,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Full Name:",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 344,
                      child: TextFormField(
                        controller: namecontroller,
                        cursorColor: Color(0xffffffff),
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'e.g. Sarah Khalid',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Color(0xff282828),
                        ),
                        validator: (String? value) {
                          if (value == null || value!.trim().isEmpty) {
                            return "please enter your full name";
                          } else {}
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_key.currentState?.validate() ?? false) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => HomePage(),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff15B86C),
                        minimumSize: Size(344, 40),
                      ),
                      child: Text(
                        'Let’s Get Started',
                        style: TextStyle(
                          color: Color(0xffffffff),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
