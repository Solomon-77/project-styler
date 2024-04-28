import 'package:flutter/material.dart';
import 'package:style_sensei/favorites_service.dart';

class Vintage extends StatefulWidget {
  const Vintage({super.key});

  @override
  State<Vintage> createState() => _VintageState();
}

class _VintageState extends State<Vintage> {
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
    final vintageImageUrls = [
      "https://images.pexels.com/photos/19596272/pexels-photo-19596272/free-photo-of-young-woman-posing-near-retro-car-on-city-street.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      
      // Add more image URLs here
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Vintage",
          style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: vintageImageUrls.length,
        itemBuilder: (context, index) {
          final imageUrl = vintageImageUrls[index];
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