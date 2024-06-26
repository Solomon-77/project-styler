import 'package:flutter/material.dart';
import 'package:style_sensei/favorites_service.dart';

class Formal extends StatefulWidget {
  const Formal({super.key});

  @override
  State<Formal> createState() => _FormalState();
}

class _FormalState extends State<Formal> {
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
    final formalImageUrls = [
      "https://i.ibb.co/3c288Tx/8ec581d03a9524ebfc2c1af9d2aea939.jpg",
      "https://aphrodite.gmanetwork.com/imagefiles/800/1643970236_675075478_12_ent.jpg",
      "https://i.ibb.co/s9ppQKD/10-Affordable-Online-Shops-Stylish-Women-Visit-for-Work-Outfits.jpg",
      "https://i.ibb.co/rZp7bdk/download.jpg",
      "https://i.ibb.co/L833mF3/1.png"
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Formal",
          style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: formalImageUrls.length,
        itemBuilder: (context, index) {
          final imageUrl = formalImageUrls[index];
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
