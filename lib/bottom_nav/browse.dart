import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:style_sensei/browseStyles/casual.dart';
import 'package:style_sensei/browseStyles/formal.dart';
import 'package:style_sensei/browseStyles/bohemian.dart';
import 'package:style_sensei/browseStyles/vintage.dart';
import 'package:style_sensei/browseStyles/classic.dart';
import 'package:style_sensei/browseStyles/artsy.dart';

class Browse extends StatefulWidget {
  const Browse({super.key});

  @override
  State<Browse> createState() => _BrowseState();
}

class _BrowseState extends State<Browse> {
  final List<Map<String, String>> cardData = [
    {"title": "Casual", "imagePath": "images/casual.jpg"},
    {"title": "Formal", "imagePath": "images/formal.jpg"},
    {"title": "Bohemian", "imagePath": "images/bohemian.jpg"},
    {"title": "Vintage", "imagePath": "images/vintage.jpg"},
    {"title": "Classic", "imagePath": "images/classic.jpg"},
    {"title": "Artsy", "imagePath": "images/artsy.jpg"},
  ];

  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredCards = cardData.where((card) {
      final title = card['title']?.toLowerCase() ?? '';
      final query = _searchController.text.toLowerCase();
      return title.contains(query);
    }).toList();

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
                  setState(() {});
                },
              ),
              const SizedBox(height: 20),
              Expanded(
                child: filteredCards.isNotEmpty
                    ? ListView(
                        children: filteredCards
                            .asMap()
                            .entries
                            .map(
                              (entry) {
                                final index = entry.key;
                                final card = entry.value;
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: CustomCard(
                                    title: card["title"]!,
                                    imagePath: card["imagePath"]!,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            switch (index) {
                                              case 0:
                                                return const Casual();
                                              case 1:
                                                return const Formal();
                                              case 2:
                                                return const Bohemian();
                                              case 3:
                                                return const Vintage();
                                              case 4:
                                                return const Classic();
                                              case 5:
                                                return const Artsy();
                                              default:
                                                return const Casual();
                                            }
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            )
                            .toList(),
                      )
                    : const Center(
                        child: Text(
                          "Not Found",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 15,
                            fontWeight: FontWeight.w500
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
  final VoidCallback onTap;

  const CustomCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
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
      ),
    );
  }
}