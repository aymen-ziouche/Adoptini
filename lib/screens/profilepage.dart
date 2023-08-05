import 'package:adoptini/screens/homepage2.dart';
import 'package:adoptini/screens/onBoarding.dart';
import 'package:adoptini/services/auth.dart';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);
  static String id = "ProfilePage";
  final _auth = Auth();
  @override
  Widget build(BuildContext context) {
    Future<void> _logout() async {
      try {
        await _auth.logout();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const OnBoarding()),
          (Route<dynamic> route) => false,
        );
      } catch (e) {
        debugPrint('logout error: $e');
      }
    }

    return Scaffold(
        body: Stack(
      children: [
        Image.asset('assets/images/profile-background.png',
            fit: BoxFit.fill, width: double.infinity, height: double.infinity),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.w, right: 8.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(
                          context,
                        );
                      },
                      icon: Image.asset('assets/images/arrow-right-box.png')),
                  IconButton(onPressed: () {}, icon: Image.asset('assets/images/Vector.png')),
                ],
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Text(
              'My Profile',
              style: TextStyle(
                color: Colors.black.withOpacity(0.85),
                fontSize: 41,
                fontFamily: 'Spartian',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.w, right: 15.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/images/profile-pic.png',
                      )),
                  Image.asset('assets/images/profile.png'),
                  IconButton(onPressed: () {}, icon: Image.asset('assets/images/edit.png'))
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Lilly Zouiche',
              style: TextStyle(
                color: Colors.black.withOpacity(0.9),
                fontSize: 22,
                fontFamily: 'League Spartan',
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.phone,
                  color: Colors.grey.withOpacity(0.8),
                  size: 20,
                ),
                const Text(
                  '  +213 .....',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
            SizedBox(height: 4.h),
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              width: 343,
              height: 70,
              decoration: ShapeDecoration(
                color: Color(0xFFD9D9D9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
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
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'My Adoptions',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontFamily: 'Spartian',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Image.asset('assets/images/cat.png'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 3.h),
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              width: 343,
              height: 70,
              decoration: ShapeDecoration(
                color: const Color(0xFFD9D9D9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
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
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Favorites',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontFamily: 'Spartian',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Image.asset('assets/images/favorite.png'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 3.h),
            Container(
              width: 343,
              height: 70,
              decoration: ShapeDecoration(
                color: const Color(0xFFD9D9D9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
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
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Help',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontFamily: 'Spartian',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Image.asset('assets/images/help.png'),
                  ],
                ),
              ),
            )
          ],
        )
      ],
    ));
  }
}
