import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:projek_ara/extension/navigation.dart';
import 'package:projek_ara/shared_preference/shared_preference.dart';
import 'package:projek_ara/view/home_page.dart';
import 'package:projek_ara/view/login.dart';

class Day16SplashScreen extends StatefulWidget {
  const Day16SplashScreen({super.key});
  static const id = "/splash_screen";

  @override
  State<Day16SplashScreen> createState() => _Day16SplashScreenState();
}

class _Day16SplashScreenState extends State<Day16SplashScreen> {
  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async {
    bool? isLogin = await PreferenceHandler.getLogin();

    Future.delayed(Duration(seconds: 3)).then((value) async {
      print(isLogin);
      if (isLogin == true) {
        context.pushReplacementNamed(HomePage.id);
      } else {
        context.push(Login());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Color(0xff748873),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset("assets/lottie/Foodies.json"),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
