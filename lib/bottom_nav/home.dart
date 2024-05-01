import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:style_sensei/quiz.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  static const List<String> imageAssets = [
    'images/trend1.jpg',
    'images/trend2.jpg',
    'images/trend3.jpg',
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: const Color.fromARGB(255, 43, 43, 43),
                ),
                child: const Text(
                  'Fashion Trend',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              items: imageAssets.map((asset) {
                return Container(
                  margin: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    image: DecorationImage(
                      image: AssetImage(asset),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                imageAssets.length,
                (index) => Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index
                        ? const Color.fromARGB(255, 46, 46, 46)
                        : Colors.grey.withOpacity(0.5),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[200]
              ),
              child: Column(
                children: [
                  const SizedBox(height: 9),
                  const Text(
                    "Upcoming Features",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 17,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 49, 49, 49),
                          ),
                          borderRadius: BorderRadius.circular(30)
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                          child: Text(
                            "Personal Stylist",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500,
                              fontSize: 13
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 49, 49, 49),
                          ),
                          borderRadius: BorderRadius.circular(30)
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                          child: Text(
                            "Ecommerce",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500,
                              fontSize: 13
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              "Style Suggester Quiz",
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 16,
                fontWeight: FontWeight.w600
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Quiz()),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color.fromARGB(255, 43, 43, 43),
                ),
                child: const Text(
                  "Answer Quiz",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    color: Colors.white,
                    fontSize: 13
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}