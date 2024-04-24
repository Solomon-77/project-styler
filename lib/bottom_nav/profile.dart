import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:style_sensei/nav.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _auth = FirebaseAuth.instance;
  String _username = FirebaseAuth.instance.currentUser?.displayName ?? '';
  String? _profileImageUrl;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  void _getCurrentUser() async {
  final user = _auth.currentUser;
    if (user != null) {
      // Fetch profile image URL if exists
      final storageRef = FirebaseStorage.instance.ref().child('profile_images/${user.uid}');
      try {
        final downloadUrl = await storageRef.getDownloadURL();
        setState(() {
          _profileImageUrl = downloadUrl;
        });
      } catch (e) {
        print('Error fetching profile image: $e');
      }

      setState(() {
        _username = user.displayName ?? '';
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      await _uploadImage(File(pickedFile.path));
    }
  }

  Future<void> _uploadImage(File image) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final storageRef =
        FirebaseStorage.instance.ref().child('profile_images/${user.uid}');
    final uploadTask = storageRef.putFile(image);
    final snapshot = await uploadTask.whenComplete(() {});
    final downloadUrl = await snapshot.ref.getDownloadURL();

    setState(() {
      _profileImageUrl = downloadUrl;
    });
  }

  Future<void> _changeUsername() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final newUsername = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        final controller = TextEditingController(text: _username);
        return AlertDialog(
          title: const Text('Change Username'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Enter new username',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, controller.text),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );

    if (newUsername != null && newUsername.isNotEmpty) {
      await user.updateDisplayName(newUsername);
      setState(() {
        _username = newUsername;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
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
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.grey[300],
                            child: _profileImageUrl == null
                                ? const Icon(Icons.person, size: 60)
                                : ClipOval(
                                    child: Image.network(
                                      _profileImageUrl!,
                                      fit: BoxFit.cover,
                                      width: 120, // width and height should be double of radius
                                      height: 120,
                                    ),
                                  ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SafeArea(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListTile(
                                            leading: const Icon(Icons.camera_alt),
                                            title: const Text('Take a Photo'),
                                            onTap: () {
                                              Navigator.pop(context);
                                              _pickImage(ImageSource.camera);
                                            },
                                          ),
                                          ListTile(
                                            leading: const Icon(Icons.photo_library),
                                            title: const Text('Choose from Gallery'),
                                            onTap: () {
                                              Navigator.pop(context);
                                              _pickImage(ImageSource.gallery);
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
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
                    Row(
                      children: [
                        Text(
                          _username,
                          style: const TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 12
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: _changeUsername,
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
                    Text(
                      _auth.currentUser?.email ?? '',
                      style: const TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 13
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const Nav()),
                        );
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 44, 44, 44),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                            child: Text(
                              "Refresh",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}