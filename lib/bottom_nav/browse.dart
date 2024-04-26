import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Browse extends StatelessWidget {
  const Browse({super.key});

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
                child: ListView( // Wrap the cards with a ListView
                  children: [
                    Card(
                      elevation: 3,
                      color: Colors.white,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)
                            ),
                            child: Image.asset(
                              "images/casual.jpg",
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "Casual",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 17
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Card(
                      elevation: 3,
                      color: Colors.white,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)
                            ),
                            child: Image.asset(
                              "images/formal.jpg",
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "Formal",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 17
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Card(
                      elevation: 3,
                      color: Colors.white,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)
                            ),
                            child: Image.asset(
                              "images/bohemian.jpg",
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "Bohemian",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 17
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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