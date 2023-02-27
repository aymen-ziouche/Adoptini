import 'package:adoptini/screens/mainPage.dart';
import 'package:adoptini/screens/signuppage.dart';
import 'package:adoptini/services/auth.dart';
import 'package:adoptini/widgets/mainbutton.dart';
import 'package:flutter/material.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);
  static String id = "SigninPage";

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _auth = Auth();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Align(
            alignment: Alignment.topRight,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    const Color(0xff827397),
                    Theme.of(context).primaryColor,
                  ],
                ),
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(200),
                ),
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 60,
                horizontal: 32,
              ),
              child: Form(
                key: _globalKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Login",
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                      const SizedBox(height: 90.0),
                      TextFormField(
                        controller: _emailController,
                        focusNode: _emailFocusNode,
                        onEditingComplete: () => FocusScope.of(context)
                            .requestFocus(_passwordFocusNode),
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        validator: (val) =>
                            val!.isEmpty ? 'Please enter your email!' : null,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter your email!',
                          hintStyle: TextStyle(
                            color: Colors.black54,
                          ),
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 34.0),
                      TextFormField(
                        controller: _passwordController,
                        focusNode: _passwordFocusNode,
                        validator: (val) =>
                            val!.isEmpty ? 'Please enter your password!' : null,
                        
                        obscureText: true,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your pasword!',
                          hintStyle: TextStyle(
                            color: Colors.black54,
                          ),
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          child: const Text(
                            'Forgot your password?',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      MainButton(
                        text: "Login",
                        hasCircularBorder: true,
                        onTap: () async {
                          if (_globalKey.currentState!.validate()) {
                            _globalKey.currentState!.save();
                            try {
                              final authresult = await _auth.signIn(
                                  _emailController.text,
                                  _passwordController.text);
                              Navigator.pushReplacementNamed(
                                  context, MainPage.id);
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    e.toString(),
                                  ),
                                ),
                              );
                            }
                          }
                        },
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.indigo,
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, SignupPage.id);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
