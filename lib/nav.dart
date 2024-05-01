import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:style_sensei/bottom_nav/home.dart';
import 'package:style_sensei/bottom_nav/browse.dart';
import 'package:style_sensei/bottom_nav/profile.dart';
import 'package:style_sensei/login.dart';
import 'package:style_sensei/bottom_nav/profile_manager.dart';
import 'package:style_sensei/side_nav/favorites.dart';
import 'package:style_sensei/side_nav/about.dart';
import 'package:style_sensei/side_nav/result.dart';

class Nav extends StatefulWidget {
  const Nav({super.key});

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  final _auth = FirebaseAuth.instance;
  late String _username = '';
  String? _profileImageUrl;
  final _userProfileManager = UserProfileManager();

  @override
  void initState() {
    super.initState();
    _loadProfileData();
    _subscribeToAuthChanges();
  }

  Future<void> _loadProfileData() async {
    await _userProfileManager.loadProfileData();
    final user = _auth.currentUser;
    if (user != null) {
      setState(() {
        _username = user.displayName ?? '';
        _profileImageUrl = _userProfileManager.profileImageUrl;
      });
    }
  }

  void _subscribeToAuthChanges() {
    _auth.userChanges().listen((user) async {
      if (user != null) {
        setState(() {
          _username = user.displayName ?? '';
          _profileImageUrl = _userProfileManager.profileImageUrl;
        });
      }
    });
  }

  int _currentIndex = 0;
  final List<Widget> _pages = const [Home(), Browse(), Profile()];

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
            fontSize: 20,
          ),
        ),
      ),
      drawer: SizedBox(
        width: 250,
        child: Drawer(
          child: ListView(
            children: [
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(23.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 22),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 31, 31, 31),
                          Color.fromARGB(255, 110, 110, 110)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _profileImageUrl != null
                            ? CircleAvatar(
                                radius: 40,
                                backgroundImage:
                                    NetworkImage(_profileImageUrl!),
                              )
                            : const CircleAvatar(
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
                        const SizedBox(height: 1),
                        Text(
                          _auth.currentUser?.email ?? '',
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 11,
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
              ),
              ListTile(
                leading: const Padding(
                  padding:
                      EdgeInsets.only(left: 10.0), // Adjust the value as needed
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                ),
                title: const Text(
                  'Results',
                  style: TextStyle(
                      fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Results(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Padding(
                  padding:
                      EdgeInsets.only(left: 10.0), // Adjust the value as needed
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                ),
                title: const Text(
                  'Favorites',
                  style: TextStyle(
                      fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Favorite(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Padding(
                  padding:
                      EdgeInsets.only(left: 10.0), // Adjust the value as needed
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                ),
                title: const Text(
                  'About',
                  style: TextStyle(
                      fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const About(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Padding(
                  padding:
                      EdgeInsets.only(left: 10.0), // Adjust the value as needed
                  child: Icon(
                    Icons.logout,
                    size: 18,
                  ),
                ),
                title: const Text(
                  'Logout',
                  style: TextStyle(
                      fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  _auth.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ),
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
            backgroundColor: const Color.fromARGB(255, 48, 48, 48),
            unselectedItemColor: const Color.fromARGB(255, 216, 216, 216),
            selectedItemColor: Colors.white,
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
            onTap: (index) => setState(() => _currentIndex = index),
          ),
        ),
      ),
      body: _pages[_currentIndex],
    );
  }
}
