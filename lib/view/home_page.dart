import 'package:flutter/material.dart';
import 'package:projek_ara/widget/widget_category.dart';
import 'package:projek_ara/widget/widget_resto.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[70],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: "tersimpan",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "profil"),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Stack(
                children: [
                  Container(
                    height: 140,
                    width: double.infinity,
                    color: Colors.brown,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
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
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        "https://id.images.search.yahoo.com/search/images;_ylt=Awrx_97VVrVoKoELM7DNQwx.;_ylu=c2VjA3NlYXJjaARzbGsDYnV0dG9u;_ylc=X1MDMjExNDczMzAwNQRfcgMyBGZyA21jYWZlZQRmcjIDcDpzLHY6aSxtOnNiLXRvcARncHJpZANIWkw1ZjExR1JscVF1dEZvX0IzdHpBBG5fcnNsdAMwBG5fc3VnZwMzBG9yaWdpbgNpZC5pbWFnZXMuc2VhcmNoLnlhaG9vLmNvbQRwb3MDMARwcXN0cgMEcHFzdHJsAzAEcXN0cmwDMTcEcXVlcnkDY2lyY3VsYXIlMjBwcm9maWxlJTIwBHRfc3RtcAMxNzU2NzE2MDQz?p=circular+profile+&fr=mcafee&fr2=p%3As%2Cv%3Ai%2Cm%3Asb-top&ei=UTF-8&x=wrt&type=E210ID91215G0#id=20&iurl=https%3A%2F%2Fi.pinimg.com%2F736x%2F73%2Faa%2Fd0%2F73aad0d78ac1e1267aad164d5ea34112.jpg&action=click",
                                      ),
                                    ),
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(),
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Hallo Ara, Selamat datang!",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.topRight,
                              child: Icon(
                                Icons.notifications_active,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextField(
                            cursorHeight: 20,
                            autofocus: false,
                            decoration: InputDecoration(
                              hintText: "cari resto favoritmu",
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.indigo,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Category(
                    imagePath: "assets/images/bakery.png",
                    title: "Dessert",
                  ),
                  Category(
                    imagePath: "assets/images/seafood.png",
                    title: "Seafood",
                  ),
                  Category(imagePath: "assets/images/meat.png", title: "Steak"),
                  Category(
                    imagePath: "assets/images/shusi.png",
                    title: "Shusi",
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  "Rekomendasi",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              resto_widget(
                imagePath: "assets/images/restoran_4.jpg",
                nameResto: "resto 1",
                rating: "4.5",
                jamBuka: "10.00 - 23.00",
              ),
              resto_widget(
                imagePath: "assets/images/restoran_3.jpg",
                nameResto: "resto 1",
                rating: "4.5",
                jamBuka: "10.00 - 23.00",
              ),
              resto_widget(
                imagePath: "assets/images/restoran_2.jpg",
                nameResto: "resto 1",
                rating: "4.5",
                jamBuka: "10.00 - 23.00",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
