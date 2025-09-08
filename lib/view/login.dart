import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:projek_ara/api/register_user.dart';
import 'package:projek_ara/extension/navigation.dart';
import 'package:projek_ara/model/user_model.dart';
import 'package:projek_ara/shared_preference/shared_preference.dart';
import 'package:projek_ara/view/home_page.dart';
import 'package:projek_ara/view/register_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

void showSuccessDialog(BuildContext context, {required String message}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black54,
    builder: (context) {
      Future.delayed(Duration(seconds: 3), () {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      });

      return Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.75,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  'assets/lottie/Foodies.json',
                  width: 150,
                  height: 150,
                  repeat: false,
                  animate: true,
                ),
                SizedBox(height: 8),
                Text(
                  'Success!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 12, 51, 141),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class Login extends StatefulWidget {
  const Login({super.key});
  static const id = "/login";
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  RegistUserModel? user;
  String? errorMessage;
  bool isVisibility = false;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  Future<void> _saveUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("userName", name);
  }

  void login() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email, dan Password tidak boleh kosong")),
      );
      isLoading = false;

      return;
    }
    try {
      final result = await AuthenticationAPI.loginUser(
        email: email,
        password: password,
      );
      setState(() {
        user = result;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Login berhasil")));
      PreferenceHandler.saveToken(user?.data.token.toString() ?? "");
      context.pushReplacementNamed(HomePage.id);
      print(user?.toJson());
    } catch (e) {
      print(e);
      setState(() {
        errorMessage = e.toString();
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(errorMessage.toString())));
    } finally {
      setState(() {});
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff748873),
      ),
      body: Container(
        color: const Color(0xff748873),
        child: Padding(
          padding: EdgeInsetsGeometry.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Hello",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    spacing: 12,
                    children: [
                      TextFormField(
                        controller: emailController,
                        style: TextStyle(color: Color(0xFFFFFFFF)),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hint: Text(
                            "Email",
                            style: TextStyle(color: Colors.white),
                          ),
                          hintStyle: TextStyle(color: Color(0xFFFFFFFF)),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email Tidak boleh kosong";
                          }
                          if (!value.contains("@")) {
                            return "Email tidak valid";
                          }
                          if (!(value.endsWith("@gmail.com") ||
                              value.endsWith("@yahoo.com"))) {
                            return "Email tidak terdaftar";
                          }
                          if (RegExp('[A-Z]').hasMatch(value)) {
                            return "Email harus huruf kecil";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: passwordController,
                        obscureText: !isVisibility,
                        style: TextStyle(color: Color(0xFFFFFFFF)),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hint: Text(
                            "Password",
                            style: TextStyle(color: Colors.white),
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color(0xFFFFFFFF),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isVisibility
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.amberAccent,
                            ),
                            onPressed: () {
                              setState(() {
                                isVisibility = !isVisibility;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password salah";
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 10),
                      SizedBox(
                        width: 300,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              253,
                              253,
                              253,
                            ),
                            // foregroundColor: Colors.amber,
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              login();
                              // pakai fungsi login baru
                            }
                          },

                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(245, 59, 41, 0),
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 0.1),
                      Row(
                        children: [
                          Expanded(child: Divider()),
                          Padding(
                            padding: EdgeInsetsGeometry.all(10),
                            child: Text(
                              "or",
                              style: TextStyle(
                                color: const Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {},
                              icon: Image.asset(
                                "assets/images/google.png",
                                width: 24,
                                height: 24,
                              ),

                              label: Text(
                                "Google",
                                style: TextStyle(color: Colors.white),
                              ),
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    8,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 0),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {},
                              icon: Image.asset(
                                "assets/images/facebook.png",
                                width: 24,
                                height: 24,
                              ),

                              label: Text(
                                "Facebook",
                                style: TextStyle(color: Colors.white),
                              ),
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    8,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 0),
                        ],
                      ),
                      SizedBox(height: 50),
                      Text.rich(
                        TextSpan(
                          text: "Don't have account?",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.pushNamed(RegisterApi.id);
                                },
                              text: "Sign Up",
                              style: TextStyle(
                                color: Colors.amberAccent,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
