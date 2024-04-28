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
      "https://images.pexels.com/photos/6311691/pexels-photo-6311691.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "https://images.pexels.com/photos/15910676/pexels-photo-15910676/free-photo-of-young-woman-in-a-trendy-outfit-posing-outdoors.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "https://images.pexels.com/photos/17403707/pexels-photo-17403707/free-photo-of-young-man-in-a-trendy-outfit-posing-outdoors.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
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