import 'package:adoptini/services/auth.dart';
import 'package:adoptini/widgets/mainbutton.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);
  static String id = "ProfilePage";
  final _auth = Auth();
// TODO: FIX THIS SO IT POPS OUT OF ALL SCREENS WHEN THE USE CLICKS THE BUTTON
  @override
  Widget build(BuildContext context) {
    Future<void> _logout() async {
      try {
        await _auth.logout();
        Navigator.pop(context);
      } catch (e) {
        debugPrint('logout error: $e');
      }
    }

    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 60.0),
      child: Column(
        children: [
          const Spacer(),
          MainButton(
              text: 'Log Out',
              onTap: () {
                _logout();
              })
        ],
      ),
    );
  }
}
