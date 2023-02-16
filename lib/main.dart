import 'package:adoptini/providers/petProvider.dart';
import 'package:adoptini/providers/userProvider.dart';
import 'package:adoptini/screens/addpetpage.dart';
import 'package:adoptini/screens/favoritespage.dart';
import 'package:adoptini/screens/homepage.dart';
import 'package:adoptini/screens/mainPage.dart';
import 'package:adoptini/screens/mapscreen.dart';
import 'package:adoptini/screens/onBoarding.dart';
import 'package:adoptini/screens/profilepage.dart';
import 'package:adoptini/screens/signinpage.dart';
import 'package:adoptini/screens/signuppage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
      theme: ThemeData(
          primaryColor: Colors.indigo,
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: Theme.of(context).textTheme.subtitle1,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: const BorderSide(
                color: Color(0xff827397),
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: const BorderSide(
                color: Color(0xff827397),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: const BorderSide(
                color: Color(0xff827397),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
          )),
      initialRoute: OnBoarding.id,
      routes: {
        MainPage.id: (context) => MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (_) => UserProvider(),
                ),
                ChangeNotifierProvider(create: (_) => PetsProvider())
              ],
              child: const MainPage(),
            ),
        HomePage.id: (context) => const HomePage(),
        OnBoarding.id: (context) => const OnBoarding(),
        SigninPage.id: (context) => const SigninPage(),
        SignupPage.id: (context) => SignupPage(),
        AddPetPage.id: (context) => const AddPetPage(),
        ProfilePage.id: (context) => ProfilePage(),
        MapScreen.id: (context) => const MapScreen(),
        FavoritesPage.id: (context) => ChangeNotifierProvider(
            create: (_) => PetsProvider(), child: FavoritesPage()),
      },
    );
  }
}
