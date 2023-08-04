import 'package:adoptini/screens/homepage.dart';
import 'package:adoptini/screens/signuppage.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class OnBoarding2 extends StatelessWidget {
  static String id = "OnBoarding2";
  const OnBoarding2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/images/background1.png',
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 16.h,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  alignment: Alignment.center,
                  height: 80,
                  width: 282,
                  child: Text(
                    "What are you here for ?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: const Color(0xff7F7D45).withOpacity(0.8),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lemon'),
                  ),
                ),
              ),
              const SizedBox(
                height: 58,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Container(
                      width: 42.w,
                      height: 240,
                      decoration: ShapeDecoration(
                        color: const Color(0xffFED7B4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, SignupPage.id);
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  'assets/images/image1.png',
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                "Looking For a Friend !",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color:
                                      const Color(0xff48441B).withOpacity(0.8),
                                  fontSize: 13,
                                  fontFamily: 'Lemon',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Container(
                      width: 42.w,
                      height: 240,
                      decoration: ShapeDecoration(
                        color: const Color(0xffFED7B4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(18),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                'assets/images/image2.png',
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              "Giving a Friend for Adoption !",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color:
                                      const Color(0xff48441B).withOpacity(0.8),
                                  fontSize: 13,
                                  fontFamily: 'Lemon'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              Text(
                'pick now !',
                style: TextStyle(
                  color: const Color(0xff7F7D45).withOpacity(0.9),
                  fontSize: 35,
                  fontFamily: 'Lemon',
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
