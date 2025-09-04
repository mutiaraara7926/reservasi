import 'package:flutter/material.dart';
import 'package:projek_ara/api/register_user.dart';
import 'package:projek_ara/model/user_model.dart';

class RegisterApi extends StatefulWidget {
  const RegisterApi({super.key});
  static const id = "/register";

  @override
  State<RegisterApi> createState() => _RegisterApiState();
}

class _RegisterApiState extends State<RegisterApi> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  RegistUserModel? user;
  String? errorMessage;
  bool isVisibility = false;
  bool isLoading = false;

  Future<void> registerUser() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final name = nameController.text.trim();
    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email, Password, dan Nama tidak boleh kosong"),
        ),
      );
      isLoading = false;

      return;
    }
    try {
      final result = await AuthenticationAPI.registerUser(
        email: email,
        password: password,
        name: name,
      );
      setState(() {
        user = result;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Pendaftaran berhasil")));
      // PreferenceHandler.saveToken(user?.data?.token.toString() ?? "");
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
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Buat akun",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // EMAIL
                    TextFormField(
                      controller: emailController,
                      style: TextStyle(color: Color(0xFFFFFFFF)),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(Icons.email, color: Colors.white),
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
                          return "Email harus @gmail.com atau @yahoo.com";
                        }
                        if (RegExp('[A-Z]').hasMatch(value)) {
                          return "Email harus huruf kecil";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: nameController,
                      style: TextStyle(color: Color(0xFFFFFFFF)),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "nama",
                        hintStyle: TextStyle(color: Colors.white),
                        // prefixIcon: Icon(Icons.email, color: Colors.white),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "nama Tidak boleh kosong";
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    // PASSWORD
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      style: TextStyle(color: Color(0xFFFFFFFF)),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(Icons.lock, color: Colors.white),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password wajib diisi";
                        }
                        if (value.length < 6) {
                          return "Password minimal 6 karakter";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    // KONFIRMASI PASSWORD
                    TextFormField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      style: TextStyle(color: Color(0xFFFFFFFF)),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Konfirmasi Password",
                        hintStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(Icons.lock, color: Colors.white),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Konfirmasi password wajib diisi";
                        }
                        if (value != passwordController.text) {
                          return "Password tidak sama";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

                    SizedBox(
                      width: 327,
                      height: 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          // foregroundColor: Colors.amber,
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await registerUser();

                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   SnackBar(
                            //     content: Text("Registrasi Berhasil!"),
                            //     backgroundColor: Colors.amber,
                            //   ),
                            // );

                            // Navigator.pop(context); // kembali ke login page
                          }
                        },

                        child: Text(
                          "Daftar",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(245, 41, 89, 121),
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
