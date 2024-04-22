import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: const Color.fromARGB(255, 43, 43, 43)
              ),
              child: const Text(
                'Fashion Trend',
                style: TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'Montserrat',
                  color: Colors.white
                ),
              ),
            ),
          ),
          Container(),
          Container(),
          // Add other widgets below if needed
        ],
      ),
    );
  }
}
