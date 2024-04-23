import 'package:flutter/material.dart';
import 'package:style_sensei/login.dart';
import 'package:style_sensei/nav.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Style Sensei',
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) { 
            return const Nav(); // User is logged in, navigate to the Nav screen
          } else {
            return const SplashScreen(); // User is not logged in, navigate to the Login screen
          }
        },
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              image: AssetImage("images/bg.jpg"),
              fit: BoxFit.cover,
              opacity: 0.5,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Positioned(
                top: 70,
                child: Text(
                  "Style Sensei",
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: "Montserrat",
                    letterSpacing: 7,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Positioned(
                bottom: 50,
                left: 45,
                right: 45,
                child: Builder(builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    },
                    child: Container(
                      height: 50,
                      color: Colors.white,
                      child: const Center(
                        child: Text(
                          "Get Started",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: "Montserrat",
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
