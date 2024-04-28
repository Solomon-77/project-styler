import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FavoritesService extends ChangeNotifier {
  final List<String> _favorites = [];

  List<String> get favorites => _favorites;

  Future<void> addToFavorites(String imageUrl) async {
    final alreadyFavorited = await isImageFavorited(imageUrl);
    if (!alreadyFavorited) {
      await FirebaseFirestore.instance.collection('favorites').add({
        'imageUrl': imageUrl,
      });
      _favorites.add(imageUrl);
      notifyListeners();
    }
  }

  Future<void> removeFromFavorites(String imageUrl) async {
    final batch = FirebaseFirestore.instance.batch();
    final snapshot = await FirebaseFirestore.instance
        .collection('favorites')
        .where('imageUrl', isEqualTo: imageUrl)
        .get();
    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
    _favorites.remove(imageUrl);
    notifyListeners();
  }

  Future<bool> isImageFavorited(String imageUrl) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('favorites')
        .where('imageUrl', isEqualTo: imageUrl)
        .get();
    return snapshot.docs.isNotEmpty;
  }

  Stream<QuerySnapshot> get favoritesStream {
    return FirebaseFirestore.instance.collection('favorites').snapshots();
  }

  Future<void> loadFavorites() async {
    final snapshot = await FirebaseFirestore.instance.collection('favorites').get();
    final favoriteImageUrls = snapshot.docs.map((doc) => doc['imageUrl'] as String).toList();
    _favorites.clear();
    _favorites.addAll(favoriteImageUrls);
    notifyListeners();
  }
}