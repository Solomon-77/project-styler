import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:style_sensei/bottom_nav/home.dart';
import 'package:style_sensei/bottom_nav/browse.dart';
import 'package:style_sensei/bottom_nav/profile.dart';
import 'package:style_sensei/login.dart';

class Nav extends StatefulWidget {
  const Nav({super.key});

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  final _auth = FirebaseAuth.instance;
  late String _username;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  void _getCurrentUser() {
    final user = _auth.currentUser;
    _username = user?.displayName ?? '';
  }

  int _currentIndex = 0;
  final List<Widget> _pages = const [
    Home(),
    Browse(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Style Sensei',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
            fontSize: 20
          ),
        ),
      ),
      drawer: SizedBox(
        width: 250,
        child: Drawer(
          child: ListView(
            children: [
              SizedBox(
                height: 200,
                child: DrawerHeader(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 31, 31, 31), // Dark gray
                        Color.fromARGB(255, 110, 110, 110), // Light reddish-brown
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        child: Icon(Icons.person, size: 60),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        _username.isNotEmpty ? _username : 'Guest',
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 21,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black,
                              offset: Offset(0, 0),
                              blurRadius: 1,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        _auth.currentUser?.email ?? '',
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 13,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black,
                              offset: Offset(0, 0),
                              blurRadius: 1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.folder),
                title: const Text(
                  'Results',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.favorite),
                title: const Text(
                  'Favorites',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text(
                  'About',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text(
                  'Logout',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
                onTap: () {
                  _auth.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: const Color.fromARGB(255, 48, 48, 48), // Dark gray
            unselectedItemColor:
                const Color.fromARGB(255, 216, 216, 216), // Light gray
            selectedItemColor: Colors.white, // Off-white
            currentIndex: _currentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.style),
                label: 'Browse',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ),
      body: _pages[_currentIndex],
    );
  }
}
