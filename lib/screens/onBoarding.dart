import 'package:adoptini/screens/signuppage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';

class OnBoarding extends StatelessWidget {
  static String id = "OnBoarding";
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OnBoardingSlider(
      headerBackgroundColor: Colors.transparent,
      finishButtonText: 'Get Started',
      // finishButtonColor: Colors.indigo,
      finishButtonStyle: const FinishButtonStyle(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(50.0),
          ),
        ),
        backgroundColor: Colors.indigo,
      ),
      controllerColor: Colors.indigo,
      onFinish: () {
        Navigator.pushReplacementNamed(context, SignupPage.id);
      },
      background: [
        Container(
          color: Colors.white,
          height: 700,
          width: 800,
        ),
        Container(
          color: Colors.white,
          height: 700,
          width: 800,
        ),
        Container(
          color: Colors.white,
          height: 700,
          width: 800,
        ),
      ],
      totalPage: 3,
      speed: 1.8,
      pageBodies: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 400,
              width: 400,
              child: Image.asset('assets/logo3.jpg'),
            ),
            const SizedBox(height: 60),
            const SizedBox(
              width: 350,
              child: Text(
                "Let's find your new pet",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff5F5B5B),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(
              width: 300,
              child: Text(
                "Adoptini is a free platform that helps you find and post pets for adoption, all in one place.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xffADA8A8),
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 400,
              width: 400,
              child: Image.asset('assets/logo2.jpg'),
            ),
            const SizedBox(height: 60),
            const SizedBox(
              width: 350,
              child: Text(
                "Find your new friends",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff5F5B5B),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(
              width: 300,
              child: Text(
                "Make your life more happy with us by having little new friends",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xffADA8A8),
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 400,
              width: 400,
              child: Image.asset('assets/logo.jpg'),
            ),
            const SizedBox(height: 60),
            const SizedBox(
              width: 350,
              child: Text(
                "Find your perfect pet",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff5F5B5B),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(
              width: 300,
              child: Text(
                "We have a wide variety of pets to choose from! You can filter by type, age, gender, or even by distance.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xffADA8A8),
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
