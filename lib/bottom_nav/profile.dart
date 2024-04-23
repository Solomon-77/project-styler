import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            // Changeable profile pic
            const SizedBox(height: 20),
            const Center(
              child: Text(
                "Profile",
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w800
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 233, 233, 233),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                children: [
                  
                ],
              ),
            )
            // Changeable username
            // display email
          ],
        ),
      )
    );
  }
}