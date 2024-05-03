import 'package:flutter/material.dart';
import 'package:style_sensei/favorites_service.dart';

class Classic extends StatefulWidget {
  const Classic({super.key});

  @override
  State<Classic> createState() => _ClassicState();
}

class _ClassicState extends State<Classic> {
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
    final classicImageUrls = [
      "https://hips.hearstapps.com/hmg-prod/images/hailey-bieber-is-seen-in-brooklyn-on-june-15-2022-in-new-news-photo-1657725290.jpg",
      "https://i.ibb.co/BsF9QFV/download-1.jpg",
      "https://images.pexels.com/photos/7538098/pexels-photo-7538098.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "https://images.pexels.com/photos/3422138/pexels-photo-3422138.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      // Add more image URLs here
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Classic",
          style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: classicImageUrls.length,
        itemBuilder: (context, index) {
          final imageUrl = classicImageUrls[index];
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