import 'package:adoptini/screens/onBoarding2.dart';
import 'package:adoptini/screens/signuppage.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

class OnBoarding extends StatelessWidget {
  static String id = "OnBoarding";
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100.h,
        color: const Color(0xffFFF9E6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 15.h,
            ),
            SizedBox(
              height: 30.h,
              width: 100.w,
              child: Image.asset(
                'assets/images/boarding.png',
              ),
            ),
            SizedBox(height: 10.h),
            Center(
              child: Container(
                width: 200.w,
                height: 45.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.w),
                    topRight: Radius.circular(20.w),
                  ),
                  color: Color(0xFF807A46),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 50, bottom: 25),
                      child: Text(
                        "Adopt a Friend !",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lemon'),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: Text(
                        "Adopt the cutest pet as your playmate.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Lemon',
                            color: Colors.white.withOpacity(0.9)),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        shadowColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 0, 0, 0)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xff5E592D)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        fixedSize: MaterialStateProperty.all<Size>(
                          const Size(314, 84),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, OnBoarding2.id);
                      },
                      child: Text(
                        'Get Started !',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Lemon',
                            color: Colors.white.withOpacity(0.8)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
