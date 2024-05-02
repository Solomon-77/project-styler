import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:style_sensei/browseStyles/casual.dart';
import 'package:style_sensei/browseStyles/formal.dart';
import 'package:style_sensei/browseStyles/bohemian.dart';
import 'package:style_sensei/browseStyles/vintage.dart';
import 'package:style_sensei/browseStyles/classic.dart';
import 'package:style_sensei/browseStyles/artsy.dart';

class Results extends StatelessWidget {
  const Results({super.key});

  void navigateToStyleScreen(BuildContext context, String style) {
    switch (style) {
      case 'Casual':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Casual()),
        );
        break;
      case 'Formal':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Formal()),
        );
        break;
      case 'Bohemian':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Bohemian()),
        );
        break;
      case 'Vintage':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Vintage()),
        );
        break;
      case 'Classic':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Classic()),
        );
        break;
      case 'Artsy':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Artsy()),
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Results",
          style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('quizResults')
            .where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data?.docs.isEmpty ?? true) {
            return const Center(
              child: Text(
                'No result found',
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w500
                ),
              )
            );
          }

          return Padding(
            padding: const EdgeInsets.all(30),
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                final quizResult = snapshot.data!.docs[index];
                final style = quizResult['style'];

                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 233, 233, 233),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 3),
                            const Text(
                              "Style:",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              style,
                              style: const TextStyle(
                                fontFamily: "Montserrat",
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => navigateToStyleScreen(context, style),
                              child: const Text(
                                "View",
                                style: TextStyle(
                                  fontFamily: "Montserrat"
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            IconButton(
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('quizResults')
                                    .doc(quizResult.id)
                                    .delete();
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}