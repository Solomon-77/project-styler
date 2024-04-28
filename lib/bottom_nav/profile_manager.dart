import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileManager {
  static final UserProfileManager _instance = UserProfileManager._internal();
  final _auth = FirebaseAuth.instance;

  factory UserProfileManager() => _instance;

  UserProfileManager._internal();

  String? _profileImageUrl;

  Future<void> loadProfileData() async {
    final user = _auth.currentUser;
    if (user != null) {
      final prefs = await SharedPreferences.getInstance();
      _profileImageUrl = prefs.getString('profile_image_url_${user.uid}') ??
          await _fetchProfileImageUrl(user.uid);
    }
  }

  Future<String?> _fetchProfileImageUrl(String uid) async {
    try {
      final ref = FirebaseStorage.instance.ref().child('profile_images/$uid');
      final downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error fetching profile image URL: $e');
      return null;
    }
  }

  void updateProfileImageUrl(String? downloadUrl) {
    _profileImageUrl = downloadUrl;
  }

  String? get profileImageUrl => _profileImageUrl;
}
