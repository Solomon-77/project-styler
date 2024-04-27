import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Browse extends StatefulWidget {
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
  State<Browse> createState() => _BrowseState();
}

class _BrowseState extends State<Browse> {
  List<Map<String, String>> filteredCardData = Browse.cardData;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
                  fontFamily: "Montserrat",
                ),
              ),
              const SizedBox(height: 20),
              CupertinoSearchTextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    filteredCardData = Browse.cardData
                        .where((card) =>
                            card["title"]!.toLowerCase().contains(value.toLowerCase()))
                        .toList();
                  });
                },
              ),
              const SizedBox(height: 20),
              Expanded(
                child: filteredCardData.isNotEmpty
                    ? ListView(
                        children: filteredCardData
                            .map(
                              (card) => Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: CustomCard(
                                  title: card["title"]!,
                                  imagePath: card["imagePath"]!,
                                ),
                              ),
                            )
                            .toList(),
                      )
                    : const Center(
                        child: Text(
                          "Not found",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
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
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}