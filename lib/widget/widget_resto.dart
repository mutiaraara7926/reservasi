import 'package:flutter/material.dart';

class resto extends StatelessWidget {
  final String imagePath;
  final String nameResto;
  final String rating;
  final String jamBuka;
  const resto({
    super.key,
    required this.imagePath,
    required this.nameResto,
    required this.rating,
    required this.jamBuka,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(10),
      ),
      elevation: 10,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 150,
            child: Image.asset("", fit: BoxFit.cover),
          ),
          Positioned(
            bottom: 0,
            left: 10,
            child: SizedBox(
              height: 70,
              child: Padding(
                padding: const EdgeInsets.only(left: 12, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber),
                        Text("4.5", style: TextStyle(fontSize: 12)),
                        SizedBox(width: 20),
                        Icon(Icons.access_time, color: Colors.grey),
                        Text("10.00 - 23.00", style: TextStyle(fontSize: 12)),
                        SizedBox(width: 20),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
