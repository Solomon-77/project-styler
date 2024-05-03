import 'package:flutter/material.dart';
import 'package:style_sensei/favorites_service.dart';

class Casual extends StatefulWidget {
  const Casual({super.key});

  @override
  State<Casual> createState() => _CasualState();
}

class _CasualState extends State<Casual> {
  late final FavoritesService _favoritesService;

  @override
  void initState() {
    super.initState();
    _favoritesService = FavoritesService();
    _loadFavorites();
    _favoritesService.addListener(_updateFavorites);
  }

  Future<void> _loadFavorites() async {
    await _favoritesService.loadFavorites();
  }

  void _updateFavorites() {
    setState(() {});
  }

  @override
  void dispose() {
    _favoritesService.removeListener(_updateFavorites);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final casualImageUrls = [
      "https://i.ibb.co/bsGYTcr/Le-Bron-James-Stars-in-UNKNWN-s-Debut-Private-Label-Collection-Lookbook.jpg",
      "https://i.ibb.co/6rcjxNt/Vice-Ganda.jpg",
      "https://images.pexels.com/photos/9558777/pexels-photo-9558777.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "https://images.pexels.com/photos/1018911/pexels-photo-1018911.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "https://images.pexels.com/photos/4066290/pexels-photo-4066290.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "https://images.pexels.com/photos/4348277/pexels-photo-4348277.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      // Add more image URLs here
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Casual",
          style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: casualImageUrls.length,
        itemBuilder: (context, index) {
          final imageUrl = casualImageUrls[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 25, right: 40, left: 40),
            child: Card(
              elevation: 3,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Image.network(
                      imageUrl,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Add to Favorites",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 16,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color: _favoritesService.favorites.contains(imageUrl) ? Colors.red : null,
                          ),
                          onPressed: () {
                            if (_favoritesService.favorites.contains(imageUrl)) {
                              _favoritesService.removeFromFavorites(imageUrl);
                            } else {
                              _favoritesService.addToFavorites(imageUrl);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}