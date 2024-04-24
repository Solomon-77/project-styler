import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            // Changeable profile pic
            const SizedBox(height: 20),
            const Center(
              child: Text(
                "Profile",
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 233, 233, 233),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 
                    Center(
                      child: Stack(
                        children: [
                          const CircleAvatar(
                            radius: 60,
                            child: Icon(Icons.person, size: 60),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: IconButton(
                              onPressed: () {
                                //
                              },
                              icon: const Icon(Icons.add_a_photo),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Username",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w800,
                        fontSize: 13
                      ),
                    ),
                    // changeable username
                    Row(
                      children: [
                        const Text(
                          "John Doe", // the username must be according to firebase
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 12
                          ),
                        ),
                        const SizedBox(width: 10,),
                        GestureDetector(
                          onTap: () {
                            
                          },
                          child: Image.asset(
                            'images/edit.png',
                            width: 14,
                            height: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Email",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w800,
                        fontSize: 13
                      ),
                    ),
                    const Text(
                      "wasd@gmail.com",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 13
                      ),
                    ),
                  ],
                ),
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