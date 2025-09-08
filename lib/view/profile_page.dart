import 'package:flutter/material.dart';
import 'package:projek_ara/api/register_user.dart';
import 'package:projek_ara/extension/navigation.dart';
import 'package:projek_ara/model/get_user.dart';
import 'package:projek_ara/shared_preference/shared_preference.dart';
import 'package:projek_ara/view/login.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  static const id = "/ProfilePage";

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  GetUserModel? userData;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final data = await AuthenticationAPI.getProfile();
      setState(() {
        userData = data;
        _nameController.text = data.data?.name ?? '';
        _emailController.text = data.data?.email ?? '';
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  void showEditDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit Profile"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nama',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () async {
                await AuthenticationAPI.updateUser(name: _nameController.text);
                _loadProfileData();
                Navigator.pop(context);
              },
              child: const Text("Simpan"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff748873),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
          ? Center(child: Text("Error: $errorMessage"))
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: const Color.fromARGB(
                            255,
                            19,
                            73,
                            41,
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.amber,
                            child: IconButton(
                              onPressed: showEditDialog,
                              icon: const Icon(
                                Icons.edit,
                                size: 18,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(
                            Icons.person,
                            color: Colors.amber,
                          ),
                          title: const Text("Nama"),
                          subtitle: Text(userData?.data?.name ?? "-"),
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.email, color: Colors.amber),
                          title: const Text("Email"),
                          subtitle: Text(userData?.data?.email ?? "-"),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),

                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      PreferenceHandler.removeLogin();
                      context.pushReplacementNamed(Login.id);
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text("Logout"),
                  ),
                ],
              ),
            ),
    );
  }
}
