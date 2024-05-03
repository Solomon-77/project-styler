import 'package:flutter/material.dart';
import 'package:style_sensei/favorites_service.dart';

class Bohemian extends StatefulWidget {
  const Bohemian({super.key});

  @override
  State<Bohemian> createState() => _BohemianState();
}

class _BohemianState extends State<Bohemian> {
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
    final bohemianImageUrls = [
      "https://i.ibb.co/DtxGCrK/download-3.jpg",
      "https://i.ibb.co/nrNCBb7/Light-Beige-Festival-Top-Men-Minimalist-Men-Baggy-Top-Tribal-Tee-Tan-Handmade-Mens-Bohemian-Clothing.jpg",
      "https://images.pexels.com/photos/10433902/pexels-photo-10433902.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "https://images.pexels.com/photos/7576576/pexels-photo-7576576.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "https://images.pexels.com/photos/19834972/pexels-photo-19834972/free-photo-of-black-woman-in-traditional-robe-posing-near-fence.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      // Add more image URLs here
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Bohemian",
          style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: bohemianImageUrls.length,
        itemBuilder: (context, index) {
          final imageUrl = bohemianImageUrls[index];
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
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
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
                            color:
                                _favoritesService.favorites.contains(imageUrl)
                                    ? Colors.red
                                    : null,
                          ),
                          onPressed: () {
                            if (_favoritesService.favorites
                                .contains(imageUrl)) {
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
