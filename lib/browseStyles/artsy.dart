import 'package:flutter/material.dart';
import 'package:style_sensei/favorites_service.dart';

class Artsy extends StatefulWidget {
  const Artsy({super.key});

  @override
  State<Artsy> createState() => _ArtsyState();
}

class _ArtsyState extends State<Artsy> {
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
    final artsyImageUrls = [
      "https://i.ibb.co/VDf9k6c/download-2.jpg",
      "https://images.pexels.com/photos/16275779/pexels-photo-16275779/free-photo-of-young-woman-posing-next-to-a-graffiti-wall.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Artsy",
          style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: artsyImageUrls.length,
        itemBuilder: (context, index) {
          final imageUrl = artsyImageUrls[index];
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