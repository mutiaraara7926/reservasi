import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:projek_ara/view/register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(245, 7, 35, 89),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(245, 7, 35, 89),
          child: Padding(
            padding: EdgeInsetsGeometry.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Hello welcome Back",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Welcome back please",
                  style: TextStyle(
                    fontSize: 14,
                    color: const Color.fromARGB(155, 216, 207, 207),
                  ),
                ),
                Text(
                  "sign in again",
                  style: TextStyle(
                    fontSize: 14,
                    color: const Color.fromARGB(155, 216, 207, 207),
                  ),
                ),
                SizedBox(height: 10),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      spacing: 12,
                      children: [
                        TextFormField(
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
                            return null;
                          },
                        ),
        
                        TextFormField(
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
                          width: 327,
                          height: 60,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                255,
                                249,
                                249,
                                249,
                              ),
                              foregroundColor: const Color.fromARGB(
                                245,
                                7,
                                35,
                                89,
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   SnackBar(content: Text("Login Berhasil")),
                                // );
                                // Navigator.pushReplacement(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => Tugaas8(),
                                //   ),
                                // );
                                // showSuccessDialog(
                                //   context,
                                //   message: 'Succesful login',
                                // );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Login Gagal"),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text("Email atau Password salah"),
                                          SizedBox(height: 20),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                            },
        
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(245, 7, 35, 89),
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
        
                        SizedBox(height: 25),
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
        
                        SizedBox(
                          width: 327,
                          height: 55,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                255,
                                29,
                                52,
                                107,
                              ),
                              foregroundColor: const Color.fromARGB(
                                255,
                                255,
                                255,
                                255,
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Koneksi Terputus")),
                                );
                              }
                            },
                            child: Text("Facebook"),
                          ),
                        ),
                        SizedBox(
                          width: 327,
                          height: 55,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                255,
                                29,
                                52,
                                107,
                              ),
                              foregroundColor: const Color.fromARGB(
                                255,
                                255,
                                255,
                                255,
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Koneksi Terputus")),
                                );
                              }
                            },
                            child: Text("Gmail"),
                          ),
                        ),
                        SizedBox(height: 20),
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Register(),
                                    ),
                                  );
                                },
                                text: "Sign Up",
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 66, 133, 244),
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
      ),
    );
  }
}