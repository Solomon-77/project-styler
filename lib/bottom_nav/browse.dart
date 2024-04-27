import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Browse extends StatelessWidget {
  const Browse({super.key});

  static const List<Map<String, String>> cardData = [
    {"title": "Casual", "imagePath": "images/casual.jpg"},
    {"title": "Formal", "imagePath": "images/formal.jpg"},
    {"title": "Bohemian", "imagePath": "images/bohemian.jpg"},
    {"title": "Vintage", "imagePath": "images/vintage.jpg"},
    {"title": "Classic", "imagePath": "images/classic.jpg"},
    {"title": "Artsy", "imagePath": "images/artsy.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                "Fashion Styles",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Montserrat"),
              ),
              const SizedBox(height: 20),
              const CupertinoSearchTextField(),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: cardData
                      .map(
                        (card) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: CustomCard(
                            title: card["title"]!,
                            imagePath: card["imagePath"]!,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String title;
  final String imagePath;

  const CustomCard({
    super.key,
    required this.title,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.white,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: "Montserrat",
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
