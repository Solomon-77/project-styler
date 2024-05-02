import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> members = [
      {'imagePath': 'images/devs/dollano.jpg', 'name': 'Dollano, Melissa',},
      {'imagePath': 'images/devs/Enriquez.png', 'name': 'Enriquez, Leslie',},
      {'imagePath': 'images/devs/Estanislao.PNG', 'name': 'Estanislao, Kier',},
      {'imagePath': 'images/devs/eustaquio.jpg', 'name': 'Eustaquio, Cyrill',},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "About",
          style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 233, 233, 233),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Column(
                    children: [
                      Text(
                        "About the App",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 15),
                      Text(
                        "The Style Sensei app is a digital application that combines the functions of a personal stylist, wardrobe organizer, and shopping assistant. Its core purpose is to assist customers with wardrobe curation, fashion trend discovery, and the creation of occasion-appropriate outfits tailored to their unique preferences and body types. This innovative app sets itself apart by allowing users to fully customize clothing pieces that they wear repeatedly, ensuring a perfect fit and alignment with their individual style.",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontFamily: "Montserrat"
                        ),
                      ) // Add your app description here
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 233, 233, 233),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Creators",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      ...List.generate(
                        members.length,
                        (index) {
                          final member = members[index];
                          return MemberCard(
                            imagePath: member['imagePath']!,
                            name: member['name']!,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MemberCard extends StatelessWidget {
  final String imagePath;
  final String name;

  const MemberCard({
    super.key,
    required this.imagePath,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            height: 100,
            width: 100,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          name,
          style: const TextStyle(
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}