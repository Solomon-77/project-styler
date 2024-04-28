import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:style_sensei/favorites_service.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  final _favoritesService = FavoritesService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Favorites",
          style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _favoritesService.favoritesStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final favorites = snapshot.data!.docs;

          if (favorites.isEmpty) {
            return const Center(
              child: Text(
                'No favorites yet',
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                )
              ),
            );
          }

          return SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: favorites
                      .map(
                        (doc) => Padding(
                          padding: const EdgeInsets.only(bottom: 25),
                          child: Card(
                            elevation: 3,
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  child: Image.network(doc['imageUrl']),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Remove from Favorites",
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 15,
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: () {
                                          _favoritesService.removeFromFavorites(doc['imageUrl']);
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}