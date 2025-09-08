import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:projek_ara/api/get_menu.dart';
import 'package:projek_ara/api/list_menu_model.dart';
import 'package:projek_ara/view/profile_page.dart';
import 'package:projek_ara/view/reservasi_screen.dart';
import 'package:projek_ara/view/tambah_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const id = "/home";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Datum> menus = [];
  bool isLoading = false;
  int _selectedIndex = 0;

  List<Datum> keranjang = [];
  int get totalHarga {
    return keranjang.fold(0, (sum, item) {
      final harga =
          int.tryParse(item.price.replaceAll(RegExp(r'[^0-9]'), "")) ?? 0;
      return sum + harga;
    });
  }

  void tambahKeKeranjang(Datum menu) {
    setState(() {
      keranjang.add(menu);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadMenus();
  }

  Future<void> _loadMenus() async {
    setState(() {
      isLoading = true;
    });
    final data = await getMenu();
    setState(() {
      menus = data;
      isLoading = false;
    });
  }

  List<Widget> get _pages => [
    _buildHomeContent(),
    ReservasiScreen(keranjang: keranjang),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 40, 117, 72),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TambahMenu()),
          );
          if (result == true) _loadMenus();
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      backgroundColor: Colors.white,

      bottomSheet: _selectedIndex == 0 && keranjang.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff798645),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 20,
                    ),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return ListView(
                          children: keranjang.asMap().entries.map((entry) {
                            final index = entry.key;
                            final menu = entry.value;

                            return ListTile(
                              title: Text(menu.name),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.remove_circle,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        keranjang.removeAt(index);
                                      });
                                      Navigator.pop(context);
                                    },
                                  ),
                                  Text("Rp ${menu.price}"),
                                ],
                              ),
                            );
                          }).toList(),
                        );
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${keranjang.length} item"),
                      Text("Total: Rp$totalHarga"),
                    ],
                  ),
                ),
              ),
            )
          : null,

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xff748873),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: "Reservasi"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),

      body: Container(child: SafeArea(child: _pages[_selectedIndex])),
    );
  }

  Widget _buildHomeContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            SizedBox(
              height: 140,
              width: double.infinity,
              child: Lottie.asset(
                'assets/lottie/Foodies.json',
                width: 200,
                height: 200,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            height: 45,
                            width: 45,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 15),
        Expanded(
          child: Card(
            color: const Color(0xff748873),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 4,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: menus.length,
              itemBuilder: (context, index) {
                final menu = menus[index];
                return Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (menu.imageUrl != null && menu.imageUrl!.isNotEmpty)
                          ? GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                  ),
                                  builder: (context) {
                                    return Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image.network(
                                                menu.imageUrl ?? "",
                                                height: 200,
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            const SizedBox(height: 12),
                                            Text(
                                              menu.name,
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              "Rp ${menu.price}",
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.green,
                                              ),
                                            ),
                                            const SizedBox(height: 12),
                                            Text(
                                              menu.description ??
                                                  "Tidak ada deskripsi",
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            ElevatedButton.icon(
                                              onPressed: () {
                                                tambahKeKeranjang(menu);
                                                Navigator.pop(context);
                                              },
                                              icon: const Icon(
                                                Icons.add_shopping_cart,
                                              ),
                                              label: const Text(
                                                "Tambah ke Keranjang",
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: const Color(
                                                  0xff798645,
                                                ),
                                                foregroundColor: Colors.white,
                                                minimumSize: const Size(
                                                  double.infinity,
                                                  50,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Image.network(
                                menu.imageUrl!,
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              height: 150,
                              width: double.infinity,
                              color: Colors.grey[300],
                              child: const Icon(
                                Icons.fastfood,
                                size: 50,
                                color: Colors.grey,
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              menu.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(
                                  Icons.attach_money,
                                  color: Colors.green,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  menu.price,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                tambahKeKeranjang(menu);
                              },
                              icon: const Icon(
                                Icons.add_circle,
                                color: Colors.black,
                                size: 28,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
